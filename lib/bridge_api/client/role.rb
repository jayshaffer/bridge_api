module BridgeAPI
  class Client
    module Role

      def get_all_roles(params = {})
        get("#{API_PATH}#{AUTHOR_PATH}#{ROLE_PATH}", params)
      end

      def get_role(role_id, params = {})
        get("#{API_PATH}#{AUTHOR_PATH}#{ROLE_PATH}/#{role_id}", params)
      end

    end
  end
end