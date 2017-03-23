module BridgeAPI
  class Client
    module DataDump
      def get_data_dumps(params = {})
        get("#{API_PATH}#{ADMIN_PATH}#{DATA_DUMP_PATH}", params)
      end

      def create_data_dump(params = {})
        post("#{API_PATH}#{ADMIN_PATH}#{DATA_DUMP_PATH}", params)
      end

      def download_data_dump(params = {})
        get("#{API_PATH}#{ADMIN_PATH}#{DATA_DUMP_DOWNLOAD_PATH}", params)
      end
    end
  end
end
