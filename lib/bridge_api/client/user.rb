module BridgeAPI
  class Client
    module User

      def add_user(params = {})
        post("#{API_PATH}#{ADMIN_PATH}#{USER_PATH}", params)
      end

      def get_user(user_id, params = {})
        get("#{API_PATH}#{AUTHOR_PATH}#{USER_PATH}/#{user_id}", params)
      end

      def delete_user(user_id, params = {})
        delete("#{API_PATH}#{ADMIN_PATH}#{USER_PATH}/#{user_id}", params)
      end

      def update_user(user_id, params = {})
        put("#{API_PATH}#{AUTHOR_PATH}#{USER_PATH}/#{user_id}", params)
      end

      def get_all_users(params = {})
        get("#{API_PATH}#{AUTHOR_PATH}#{USER_PATH}", params)
      end

    end
  end
end