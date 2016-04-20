module BridgeAPI
  class Client
    module CustomField

      def add_custom_field(params = {})
        post("#{API_PATH}#{AUTHOR_PATH}#{CUSTOM_FIELD_PATH}", params)
      end

      def get_custom_field(custom_field_id, params = {})
        get("#{API_PATH}#{AUTHOR_PATH}#{CUSTOM_FIELD_PATH}/#{custom_field_id}", params)
      end

      def delete_custom_field(custom_field_id, params = {})
        delete("#{API_PATH}#{AUTHOR_PATH}#{CUSTOM_FIELD_PATH}/#{custom_field_id}", params)
      end

      def update_custom_field(custom_field_id, params = {})
        put("#{API_PATH}#{AUTHOR_PATH}#{CUSTOM_FIELD_PATH}/#{custom_field_id}", params)
      end

      def get_all_custom_fields(params = {})
        get("#{API_PATH}#{AUTHOR_PATH}#{CUSTOM_FIELD_PATH}", params)
      end

    end
  end
end
