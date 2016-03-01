require 'test_helper'

describe BridgeAPI::Client::User do

  before do
    @client = BridgeAPI::Client.new(prefix: "http://test.bridge.com", token: "test_token")
  end

  it 'should add an user' do
    response = @client.add_user
    expect(response.first['id']).to(eq("10"))
  end

  it 'should get a user' do
    response = @client.get_user(1)
    expect(response.first['id']).to(eq("10"))
  end

  it 'should delete an user' do
    response = @client.delete_user(1)
    expect(response.status).to(eq(204))
  end

  it 'should update a user' do
    response = @client.update_user(1)
    expect(response.first['id']).to(eq("10"))
  end

  it 'should get all users' do
    response = @client.get_all_users
    expect(response.length).to(eq(2))
  end

end

