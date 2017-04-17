require 'footrest/client'
require 'faraday'
require 'footrest'
require 'footrest/http_error'
require 'footrest/pagination'
require 'footrest/follow_redirects'
require 'footrest/parse_json'
require 'base64'


module BridgeAPI
  class Client < Footrest::Client

    DATA_DUMP_DOWNLOAD_PATH = '/data_dumps/download'
    DATA_DUMP_PATH = '/data_dumps'
    COURSE_TEMPLATE_PATH = '/course_templates'
    ENROLLMENT_PATH = '/enrollments'
    USER_PATH = '/users'
    GROUPS_PATH = '/groups'
    MANAGER_PATH = '/managers'
    ADMIN_PATH = "/admin"
    AUTHOR_PATH = "/author"
    LEARNER_PATH = "/learner"
    CUSTOM_FIELD_PATH = "/custom_fields"
    API_VERSION = 1
    API_PATH = '/api'

    require 'bridge_api/api_array'

    Dir[File.dirname(__FILE__) + '/client/*.rb'].each do |file|
      require file
      include self.const_get("#{File.basename(file).gsub('.rb','').split("_").map{|ea| ea.capitalize}.join('')}")
    end

    # Override Footrest request for ApiArray support
    def request(method, &block)
      ApiArray::process_response(connection.send(method, &block), self)
    end

    def set_connection(config)
      config[:logger] = config[:logging] if config[:logging]
      @connection = Faraday.new(url: config[:prefix]) do |faraday|
        faraday.request                     :multipart
        faraday.request                     :url_encoded
        if config[:logger] == true
          faraday.response :logger
        elsif config[:logger]
          faraday.use Faraday::Response::Logger, config[:logger]
        end
        faraday.use                         Footrest::FollowRedirects, limit: 5 unless config[:follow_redirects] == false
        faraday.adapter                     Faraday.default_adapter
        faraday.use                         Footrest::ParseJson, :content_type => /\bjson$/
        faraday.use                         Footrest::RaiseFootrestErrors
        faraday.use                         Footrest::Pagination
        faraday.headers[:accept]          = "application/json"
        faraday.headers[:authorization]   = "Bearer #{config[:token]}" if config[:token]
        faraday.headers[:user_agent]      = "Footrest"
        if config[:api_key] && config[:api_secret]
          faraday.headers[:authorization] =   'Basic ' + Base64.strict_encode64("#{config[:api_key]}:#{config[:api_secret]}")
        elsif config[:token]
          faraday.headers[:authorization] =   "Bearer #{config[:token]}"
        else
          raise 'No api authorization provided'
        end
      end
    end
  end
end

