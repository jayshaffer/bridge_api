require 'test_helper'

describe BridgeAPI::Client::CourseTemplate do

  before do
    @client = BridgeAPI::Client.new(prefix: "http://test.bridge.com", token: "test_token")
  end

  it 'should get all course templates' do
    templates = @client.get_all_course_templates.all_pages!
    expect(templates.count).to(eq(2))
    expect(templates.first['title']).to(eq('My Test Course'))
  end

  it 'should create a course template' do
    template = @client.create_course_template
    expect(template.count).to(eq(1))
    expect(template.first['title']).to(eq('My only course'))
  end

  it 'should delete a course' do
    response = @client.delete_course_template(1)
    expect(response.status).to(eq(204))
  end

  it 'should publish a course' do
    template = @client.publish_course_template(1)
    expect(template.count).to(eq(1))
    expect(template.first['title']).to(eq('My only course'))
  end

  it 'should get a single course template' do
    template = @client.get_course_template(1)
    expect(template.count).to(eq(1))
    expect(template.first['title']).to(eq('My only course'))
  end

  it 'should update a course template' do
    template = @client.update_course_template(1)
    expect(template.count).to(eq(1))
    expect(template.first['title']).to(eq('My only course'))
  end

end
