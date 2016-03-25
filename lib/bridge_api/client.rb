require 'footrest/client'
require 'faraday'
require 'footrest'
require 'byebug'
require 'footrest/http_error'
require 'footrest/pagination'
require 'footrest/follow_redirects'
require 'footrest/parse_json'


module BridgeAPI
  class Client < Footrest::Client

    COURSE_TEMPLATE_PATH = '/course_templates'
    ENROLLMENT_PATH = '/enrollments'
    USER_PATH = '/users'
    ADMIN_PATH = "/admin"
    AUTHOR_PATH = "/author"
    LEARNER_PATH = "/learner"
    API_VERSION = 1
    API_PATH = '/api'

    require 'bridge_api/api_array'

    Dir[File.dirname(__FILE__) + '/client/*.rb'].each {|file| require file }

    include CourseTemplate
    include Enrollment
    include User
    include Footrest

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
        faraday.adapter                     Faraday.default_adapter
        faraday.use                         Footrest::FollowRedirects
        faraday.use                         Footrest::ParseJson, :content_type => /\bjson$/
        faraday.use                         Footrest::RaiseFootrestErrors
        faraday.use                         Footrest::Pagination
        faraday.headers[:accept]          = "application/json"
        faraday.headers[:authorization]   = "Bearer #{config[:token]}" if config[:token]
        faraday.headers[:user_agent]      = "Footrest"
        if config[:basic_api_token]
          faraday.headers[:authorization] =   "Basic #{config[:basic_api_token]}"
        elsif config[:token]
          faraday.headers[:authorization] =   "Bearer #{config[:token]}"
        else
          raise 'No authorization token provided'
        end
      end
    end

  end
end

