module BridgeAPI
  class Client
    # WARNING: the API endpoint for program enrollments is currently undocumented
    # in the Bridge API. It's possible that it might change or be removed in the
    # future, causing this to break.

    module ProgramEnrollment
      def add_program_enrollment(program_id, params = {})
        post("#{API_PATH}#{AUTHOR_PATH}#{PROGRAM_PATH}/#{program_id}#{PROGRAM_ENROLLMENT_PATH}", params)
      end

      def delete_program_enrollment(program_id, enrollment_id, params = {})
        delete("#{API_PATH}#{AUTHOR_PATH}#{PROGRAM_PATH}/#{program_id}#{PROGRAM_ENROLLMENT_PATH}/#{enrollment_id}", params)
      end

      def get_all_program_enrollments(program_id, params = {})
        get("#{API_PATH}#{AUTHOR_PATH}#{PROGRAM_PATH}/#{program_id}#{PROGRAM_ENROLLMENT_PATH}", params)
      end
    end
  end
end
