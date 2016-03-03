
module BridgeAPI
  class ApiArray
    include Enumerable

    @next_page = nil
    @prev_page = nil

    META_FIELDS = %w(meta linked).freeze

    attr_reader :status, :headers, :members

    def self.process_response(response, api_client)
        ApiArray.new(response, api_client)
    end

    def initialize(response, api_client)
      @api_client = api_client
      case response.status
        when 200..206
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

    def next_page
      load_page(@next_page)
    end

    def each_page(&block)
      block.call(@members)
      while @next_page
        response = get_page(@next_page)
        apply_response_metadata(response)
        block.call(@members)
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
      if response.body.is_a?(Hash)
        content = response.body.reject{|k, v| META_FIELDS.include?(k)}
        if content.length > 0
          return content.values[0]
        end
      end
      []
    end

    def apply_response_metadata(response)
      @status = response.status
      @headers = response.headers
      @method = response.env[:method]
      init_pages(response)
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
