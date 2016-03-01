require 'sinatra/base'
require 'tilt'

class FakeBridge < Sinatra::Base

  ## Course Templates

  get %r{/api/author/course_templates$} do
    get_json_data 200, 'courses.json'
  end

  get %r{/api/author/course_templates/\d+$} do
    get_json_data 200, 'course.json'
  end

  post %r{/api/author/course_templates$} do
    get_json_data 200, 'course.json'
  end

  post %r{/api/author/course_templates/\d+/publish$} do
    get_json_data 200, 'course.json'
  end

  put %r{/api/author/course_templates/\d+$} do
    get_json_data 200, 'course.json'
  end

  delete %r{/api/author/course_templates/\d+$} do
    get_json_data 204, nil
  end

  ## Programs

  get %r{/api/author/programs.*$} do
    get_json_data 200, 'programs.json'
  end

  ## Users

  get %r{/api/author/users$} do
    get_json_data 200, 'users.json'
  end

  get %r{/api/author/users/\d+$} do
    get_json_data 200, 'user.json'
  end

  put %r{/api/author/users/\d+$} do
    get_json_data 200, 'user.json'
  end

  post %r{/api/admin/users$} do
    get_json_data 200, 'user.json'
  end

  delete %r{/api/admin/users/\d+$} do
    get_json_data 204, nil
  end

  ## Enrollments

  post %r{/api/author/course_templates/\d+/enrollments$} do
    get_json_data 204, nil
  end

  get %r{/api/author/course_templates/\d+/enrollments$} do
    get_json_data 200, 'enrollments.json'
  end

  delete %r{/api/author/enrollments.*$} do
    get_json_data 204, nil
  end

  put %r{/api/author/enrollments.*$} do
    get_json_data 200, 'enrollment.json'
  end

  private

  def get_json_data(response_code, file_name)
    content_type :json
    status response_code
    unless file_name.nil?
      File.open(File.dirname(__FILE__) + '/../fixtures/' + file_name).read
    else
      {}
    end
  end

end
