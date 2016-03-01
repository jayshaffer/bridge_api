module BridgeAPI
  class Client
    module CourseTemplate

      def get_all_course_templates(params = {})
        get("#{API_PATH}#{AUTHOR_PATH}#{COURSE_TEMPLATE_PATH}", params)
      end

      def create_course_template(params = {})
        post("#{API_PATH}#{AUTHOR_PATH}#{COURSE_TEMPLATE_PATH}", params)
      end

      def delete_course_template(course_template_id, params = {})
        delete("#{API_PATH}#{AUTHOR_PATH}#{COURSE_TEMPLATE_PATH}/#{course_template_id}", params)
      end

      def publish_course_template(course_template_id, params = {})
        post("#{API_PATH}#{AUTHOR_PATH}#{COURSE_TEMPLATE_PATH}/#{course_template_id}/publish", params)
      end

      def get_course_template(course_template_id, params = {})
        get("#{API_PATH}#{AUTHOR_PATH}#{COURSE_TEMPLATE_PATH}/#{course_template_id}", params)
      end

      def update_course_template(course_template_id, params = {})
        put("#{API_PATH}#{AUTHOR_PATH}#{COURSE_TEMPLATE_PATH}/#{course_template_id}", params)
      end

    end
  end
end
