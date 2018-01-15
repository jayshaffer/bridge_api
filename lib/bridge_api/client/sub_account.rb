module BridgeAPI
  class Client
    module SubAccount
      def get_sub_accounts(params = {})
        get("#{API_PATH}#{ADMIN_PATH}#{SUB_ACCOUNT_PATH}", params)
      end

      def share_course_with_subaccount(course_template_id, params = {})
        put("#{API_PATH}#{AUTHOR_PATH}#{COURSE_TEMPLATE_PATH}/#{course_template_id}/#{SUB_ACCOUNT_PATH}/share", params)
      end

      def revoke_course_from_subaccount(course_template_id, params = {})
        put("#{API_PATH}#{AUTHOR_PATH}#{COURSE_TEMPLATE_PATH}/#{course_template_id}/#{SUB_ACCOUNT_PATH}/revoke", params)
      end
    end
  end
end
