require 'test_helper'

describe BridgeAPI::Client::LiveCourse do
  before do
    @client = BridgeAPI::Client.new(prefix: "http://test.bridge.com", token: "test_token")
  end

  it 'should get a list of live courses' do
    response = @client.get_all_live_courses()
    expect(response.status).to eq(200)
    expect(response.members.count).to eq(2)
    expect(response.members.first['id']).to eq('1')
    expect(response.members.first['title']).to eq('New Rep Training')
  end
end
