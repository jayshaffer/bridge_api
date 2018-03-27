require 'test_helper'

describe BridgeAPI::Client::Enrollment do

  before do
    @client = BridgeAPI::Client.new(prefix: "http://test.bridge.com", token: "test_token")
  end

  it 'should add an enrollment' do
    response = @client.add_enrollment(1)
    expect(response.status).to(eq(204))
  end

  it 'should delete an enrollment' do
    response = @client.delete_enrollment(1)
    expect(response.status).to(eq(204))

  end

  it 'should update an enrollment' do
    enrollment = @client.update_enrollment(1)
    expect(enrollment.first['id']).to(eq("3"))
  end

  it 'should get all enrollments' do
    enrollments = @client.get_all_enrollments(1)
    expect(enrollments.length).to(eq(2))
  end

  it 'should update due date for enrollments' do
    enrollment = [{end_at: nil}]
    response = @client.update_enrollment_due_date(1, enrollment)
    expect(response.status).to(eq 200)
  end

end

