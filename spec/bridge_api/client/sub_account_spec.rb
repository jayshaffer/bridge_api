require 'test_helper'

describe BridgeAPI::Client::SubAccount do

  before do
    @client = BridgeAPI::Client.new(prefix: "http://test.bridge.com", token: "test_token")
  end

  it 'should get all subaccounts' do
    response = @client.get_sub_accounts
    expect(response.first['id']).to(eq("141"))
  end

end
