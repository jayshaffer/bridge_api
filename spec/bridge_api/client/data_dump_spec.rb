require 'test_helper'

describe BridgeAPI::Client::DataDump do
  before do
    @client = BridgeAPI::Client.new(prefix: "http://test.bridge.com", token: "test_token")
  end

  it 'should get all data dumps' do
    response = @client.get_data_dumps
    expect(response.status).to eq(200)
    expect(response.members.count).to eq(1)
    expect(response.members.first['status']).to eq('complete')
  end

  it 'should create a data dump' do
    response = @client.create_data_dump
    expect(response.status).to eq(200)
    expect(response.members.count).to eq(1)
    expect(response.members.first['status']).to eq('pending')
  end

  it 'should download a data dump' do
    response = @client.download_data_dump
    expect(response.status).to eq(200)
  end
end
