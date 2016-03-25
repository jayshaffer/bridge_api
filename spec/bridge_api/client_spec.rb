
describe BridgeAPI::Client do

  it 'should set the auth header to basic auth' do
    client = BridgeAPI::Client.new(prefix: "https://www.fake.com", basic_api_token: "test_token")
    expect(client.connection.headers['Authorization']).to(eq("Basic test_token"))
  end


end