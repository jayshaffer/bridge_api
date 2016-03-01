require 'footrest/client'

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

    # Override Footrest request for ApiArray support
    def request(method, &block)
      ApiArray::process_response(connection.send(method, &block), self)
    end

  end
end

