require 'test_helper'

describe BridgeAPI::Client::ProgramEnrollment do
  before do
    @client = BridgeAPI::Client.new(prefix: "http://test.bridge.com", token: "test_token")
  end

  it 'should add a program enrollment' do
    response = @client.add_program_enrollment(1)
    expect(response.status).to(eq(204))
  end

  it 'should delete a program enrollment' do
    response = @client.delete_program_enrollment(1, 2)
    expect(response.status).to(eq(204))
  end

  it 'should get all program enrollments' do
    enrollments = @client.get_all_enrollments(1)
    expect(enrollments.length).to(eq(2))
  end
end
