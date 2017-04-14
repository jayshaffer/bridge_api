module BridgeAPI
  class Client
    module Group
      def add_group(params = {})
        post("#{API_PATH}#{AUTHOR_PATH}#{GROUPS_PATH}", params)
      end

      def update_group(group_id, params = {})
        put("#{API_PATH}#{AUTHOR_PATH}#{GROUPS_PATH}/#{group_id}", params)
      end
    end
  end
end
