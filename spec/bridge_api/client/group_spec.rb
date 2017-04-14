require 'test_helper'

describe BridgeAPI::Client::Group do
  before do
    @client = BridgeAPI::Client.new(prefix: "http://test.bridge.com", token: "test_token")
  end

  let(:params) {{ name: 'Test Group', smart: true }}

  it 'should create a group' do
    response = @client.add_group(groups: params)
    expect(response.status).to eq(201)
    expect(response.members.count).to eq(1)
    expect(response.members.first['id']).to eq('6')
    expect(response.members.first['type']).to eq('smart')
  end

  it 'should update a group' do
    response = @client.update_group(1, group: params)
    expect(response.status).to eq(200)
    expect(response.members.count).to eq(1)
    expect(response.members.first['id']).to eq('6')
    expect(response.members.first['type']).to eq('smart')
  end
end