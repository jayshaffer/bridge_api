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

  ## Program enrollments

  get %r{/api/author/programs/\d+/learners} do
    get_json_data 200, 'program_enrollments.json'
  end

  post %r{/api/author/programs/\d+/learners} do
    get_json_data 204, nil
  end

  delete %r{/api/author/programs/\d+/learners} do
    get_json_data 204, nil
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

  ## Managers
  get %r{/api/author/managers$} do
    get_json_data 200, 'managers.json'
  end

  get %r{/api/author/managers/\d+/direct_reports$} do
    get_json_data 200, 'direct_reports.json'
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

  post %r{/api/author/enrollments/\d+/due_date$} do
    get_json_data 200, 'enrollment.json'
  end

  #Custom Fields

  get %r{/api/author/custom_fields} do
    get_json_data 200, 'custom_fields.json'
  end

  get %r{/api/author/custom_fields/\d+$} do
    get_json_data 200, 'custom_fields.json'
  end

  put %r{/api/author/custom_fields/\d+$} do
    get_json_data 200, 'custom_fields.json'
  end

  post %r{/api/author/custom_fields} do
    get_json_data 200, 'custom_fields.json'
  end

  delete %r{/api/author/custom_fields/\d+$} do
    get_json_data 204, nil
  end

  # Data Dumps

  get %r{/api/admin/data_dumps} do
    get_json_data 200, 'data_dumps.json'
  end

  post %r{/api/admin/data_dumps} do
    get_json_data 200, 'data_dump.json'
  end

  get %r{/api/admin/data_dumps/download} do
    get_json_data 200, nil
  end

  # Groups

  post %r{/api/author/groups} do
    get_json_data 201, 'group.json'
  end

  put %r{/api/author/groups/\d+$} do
    get_json_data 200, 'group.json'
  end

  #Live Courses
  get %r{/api/author/live_courses$} do
    get_json_data 200, 'live_courses.json'
  end

  #Live Course Enrollments
  get %r{/api/author/live_courses/\d+/learners} do
    get_json_data 200, 'live_course_enrollments.json'
  end

  #Sub Accounts
  get %r{/api/admin/sub_accounts} do
    get_json_data 200, 'sub_accounts.json'
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
