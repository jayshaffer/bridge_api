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
    expect(response['direct_reports'].count).to(eq(2))
    expect(response['direct_reports'].first['id']).to(eq("3"))
  end

end

