module BridgeAPI
  class Client
    module Enrollment

      def add_enrollment(course_template_id, params = {})
        post("#{API_PATH}#{AUTHOR_PATH}#{COURSE_TEMPLATE_PATH}/#{course_template_id}#{ENROLLMENT_PATH}", params)
      end

      def delete_enrollment(enrollment_id, params = {})
        delete("#{API_PATH}#{AUTHOR_PATH}#{ENROLLMENT_PATH}/#{enrollment_id}", params)
      end

      def update_enrollment(enrollment_id, params = {})
        put("#{API_PATH}#{AUTHOR_PATH}#{ENROLLMENT_PATH}/#{enrollment_id}", params)
      end

      def get_all_enrollments(course_template_id, params = {})
        get("#{API_PATH}#{AUTHOR_PATH}#{COURSE_TEMPLATE_PATH}/#{course_template_id}#{ENROLLMENT_PATH}", params)
      end

    end
  end
end
