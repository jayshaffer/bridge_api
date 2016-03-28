
describe BridgeAPI::Client do

  it 'should set the auth header to basic auth' do
    client = BridgeAPI::Client.new(prefix: "https://www.fake.com", api_key: "fake_token", api_secret: "fake_secret")
    expect(client.connection.headers['Authorization']).to(eq("Basic ZmFrZV90b2tlbjpmYWtlX3NlY3JldA=="))
  end

  it 'should set the auth header to bearer auth' do
    client = BridgeAPI::Client.new(prefix: "https://www.fake.com", token: "test_token")
    expect(client.connection.headers['Authorization']).to(eq("Bearer test_token"))
  end


end