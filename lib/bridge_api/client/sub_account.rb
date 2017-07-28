module BridgeAPI
  class Client
    module SubAccount
      def get_sub_accounts(params = {})
        get("#{API_PATH}#{ADMIN_PATH}#{SUB_ACCOUNT_PATH}", params)
      end
    end
  end
end
