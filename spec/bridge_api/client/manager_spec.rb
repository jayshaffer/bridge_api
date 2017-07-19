require 'test_helper'

describe BridgeAPI::Client::User do

  before do
    @client = BridgeAPI::Client.new(prefix: "http://test.bridge.com", token: "test_token")
  end

  it 'should get all managers' do
    response = @client.get_all_managers
    expect(response.first['id']).to(eq("17"))
  end

  it 'should get all the people who report to a manager' do
    response = @client.get_manager_direct_reports(17)
    expect(response.members.count).to(eq(2))
    expect(response.members.first['id']).to(eq("3"))
    expect(response.meta['direct_reports_count']).to(eq(2))
    expect(response.meta['manager_id']).to(eq("17"))
  end

end
