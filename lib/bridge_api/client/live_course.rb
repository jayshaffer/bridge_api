module BridgeAPI
  class Client
    module LiveCourse

      def get_all_live_courses(params = {})
        get("#{API_PATH}#{AUTHOR_PATH}/live_courses", params)
      end

    end
  end
end
