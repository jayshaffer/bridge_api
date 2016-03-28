
describe BridgeAPI::Client do

  it 'should set the auth header to basic auth' do
    client = BridgeAPI::Client.new(prefix: "https://www.fake.com", api_key: "fake_token", api_secret: "fake_secret")
    expect(client.connection.headers['Authorization']).to(eq("Basic ZmFrZV90b2tlbjpmYWtlX3NlY3JldA=="))
  end

  it 'should set the auth header to bearer auth' do
    client = BridgeAPI::Client.new(prefix: "https://www.fake.com", token: "test_token")
    expect(client.connection.headers['Authorization']).to(eq("Bearer test_token"))
  end

  it 'should set the meta property on client' do
    client = BridgeAPI::Client.new(prefix: "https://www.fake.com", token: "test_token")
    users = client.get_all_users
    expect(users.meta['next']).to(eq('http://bridge.bridgeapp.com/api/author/users?after=eyJ0eXAiOiJKV1QiLCJhSDiQQ'))
  end

  it 'should set the linked property on client' do
    client = BridgeAPI::Client.new(prefix: "https://www.fake.com", token: "test_token")
    users = client.get_all_users
    expect(users.linked['custom_fields'][0]['id']).to(eq('1'))
  end


end