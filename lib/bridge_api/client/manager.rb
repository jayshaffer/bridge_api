module BridgeAPI
  class Client
    module Manager

      def get_all_managers(params = {})
        get("#{API_PATH}#{AUTHOR_PATH}#{MANAGER_PATH}", params)
      end

      def get_manager_direct_reports(manager_id, params = {})
        path = "#{API_PATH}#{AUTHOR_PATH}#{MANAGER_PATH}/#{manager_id}/direct_reports"
        RESULT_MAPPING[path] = {
          primary: 'direct_reports',
          meta: ['manager_id', 'direct_reports_count']
        }
        get(path, params)
      end

    end
  end
end
