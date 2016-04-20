require 'test_helper'
require 'byebug'
describe BridgeAPI::Client::CustomField do

  before do
    @client = BridgeAPI::Client.new(prefix: "http://test.bridge.com", token: "test_token")
  end

  it 'should add an custom field' do
    response = @client.add_custom_field
    expect(response.first['id']).to(eq("30"))
  end

  it 'should get a custom field' do
    response = @client.get_custom_field(1)
    expect(response.first['id']).to(eq("30"))
  end

  it 'should delete an custom field' do
    response = @client.delete_custom_field(1)
    expect(response.status).to(eq(204))
  end

  it 'should update a custom field' do
    response = @client.update_custom_field(1)
    expect(response.first['id']).to(eq("30"))
  end

  it 'should get all custom field' do
    response = @client.get_all_custom_fields
    expect(response.length).to(eq(1))
  end

end

