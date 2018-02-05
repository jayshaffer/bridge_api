
module BridgeAPI
  class ApiArray
    include Enumerable

    @next_page = nil
    @prev_page = nil

    attr_reader :status, :headers, :members, :body, :errors

    def self.process_response(response, api_client, result_mapping)
      ApiArray.new(response, api_client, result_mapping)
    end

    def initialize(response, api_client, result_mapping)
      @meta_fields = %w(meta linked)
      @api_client = api_client
      @linked = {}
      @meta = {}
      @extra_meta_fields = []
      @headers = response.try(:headers)
      @status= response.try(:status)
      @body= response.try(:body)
      @errors = response.body['errors']  rescue []
      pattern = /.*(\/api\/.*)/
      path = response.env.url
      matches = pattern.match(path.to_s)
      mapping = nil
      if matches
        mapping_exists = result_mapping.key?(matches[1])
        mapping = result_mapping[matches[1]] if mapping_exists
      end
      unless mapping.nil?
        @extra_meta_fields.concat(mapping[:meta])
      end
      case response.status
        when *((200..206).to_a + [302])
          apply_response_metadata(response)
          @members = get_response_content(response)
      end
    end

    def length
      @members.length
    end

    def [](i)
      @members[i]
    end

    def last
      @members.last
    end

    def each(&block)
      @members.each { |member| block.call(member) }
    end

    def pages?
      !@next_page.nil?
    end

    def meta
      @meta
    end

    def linked
      @linked
    end

    def next_page
      load_page(@next_page)
    end

    def each_page(&block)
      block.call(@members, @linked, @meta)
      while @next_page
        response = get_page(@next_page)
        apply_response_metadata(response, false)
        @members = get_response_content(response)
        block.call(@members, @linked, @meta)
      end
      @link_hash = {}
    end

    def all_pages!
      if pages?
        response = get_page(@next_page)
        apply_response_metadata(response)
        @members.concat(get_response_content(response))
        while @next_page
          response = get_page(@next_page)
          apply_response_metadata(response)
          @members.concat(get_response_content(response))
        end
      end
      self
    end

    private

    def get_page(url, params = {})
      query = URI.parse(url).query
      p = CGI.parse(query).merge(params)
      u = url.gsub("?#{query}", '')
      p.each { |k, v| p[k] = v.first if v.is_a?(Array) }
      @api_client.connection.send(:get) do |r|
        r.url(u, p)
      end
    end

    def load_page(url)
      response = get_page(url)
      ApiArray.process_response(response, @api_client)
    end

    def get_response_content(response)
      return [] unless response.body.is_a?(Hash)
      content = response.body.reject{|k, v| @meta_fields.include?(k) || @extra_meta_fields.include?(k)}
      if content.length > 0
        return content.values[0]
      end
      []
    end

    def apply_response_metadata(response, concat = true)
      unless concat
        @linked = {}
        @meta = {}
      end
      @method = response.env[:method]
      init_pages(response)
      init_linked(response)
      init_meta(response)
    end

    def init_linked(response)
      if response.body.is_a?(Hash) && response.body.key?('linked')
        @linked = @linked.merge(response.body['linked']){|key,oldval,newval| [*oldval].to_a + [*newval].to_a }
      end
    end

    def init_meta(response)
      if response.body.is_a?(Hash) && response.body.key?('meta')
        @meta = @meta.merge(response.body['meta']){|key,oldval,newval| [*oldval].to_a + [*newval].to_a }
        @extra_meta_fields.each do |field|
          @meta[field] = response.body[field]
        end
      end
    end

    def init_pages(response)
      @next_page = nil
      @prev_page = nil
      if response.body.is_a?(Hash) && response.body.key?('meta')
        if response.body['meta'].key?('next')
          @next_page = response.body['meta']['next']
        end
        if response.body['meta'].key?('prev')
          @prev_page = response.body['meta']['prev']
        end
      end
    end

  end
end
