module BridgeAPI
  class Client
    module LiveCourseEnrollment

      def get_all_live_course_enrollments(live_course, params = {})
        get("#{API_PATH}#{AUTHOR_PATH}/live_courses/#{live_course}/learners", params)
      end

    end
  end
end
