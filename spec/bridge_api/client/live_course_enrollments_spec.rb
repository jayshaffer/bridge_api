require 'test_helper'

describe BridgeAPI::Client::LiveCourseEnrollment do
  before do
    @client = BridgeAPI::Client.new(prefix: "http://test.bridge.com", token: "test_token")
  end

  it 'should get a list of live course enrollments' do
    response = @client.get_all_live_course_enrollments(1)
    expect(response.status).to eq(200)
    expect(response.members.count).to eq(1)
    expect(response.members.first['id']).to eq('3')
    expect(response.members.first['name']).to eq('jshaffer@instructure.com')
  end
end
