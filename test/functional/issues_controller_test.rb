require File.expand_path('../../test_helper', __FILE__)
require 'issues_controller'

class IssuesControllerTest < ActionController::TestCase
  fixtures :projects,
           :users,
           :roles,
           :members,
           :member_roles,
           :issues,
           :issue_statuses,
           :versions,
           :trackers,
           :projects_trackers,
           :issue_categories,
           :enabled_modules,
           :enumerations

  include Redmine::I18n

  def setup
    @controller = IssuesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    @user = User.find(2)
    @project = Project.find(1)
    User.current = @user
    @request.session[:user_id] = 2
  end

  def test_simple_new_issue
    get :new, :project_id => @project.id
    assert_response :success
  end

  def test_show_simplify_on
    get :new, :project_id => @project.id
    assert_response :success
  end

  if Redmine::VERSION.to_s >= '2.3.0'

    def test_update_form_simplify_on
      simplify_off!(@user)
      post :update_form, :project_id => @project.id, :format => 'js', :simplify => 'on'
      assert_response :success
      assert_equal true, RedmineSimple.on?
      assert_match /simple-hidden/, @response.body
    end

    def test_update_form_simplify_off
      simplify_on!(@user)
      post :update_form, :project_id => @project.id, :format => 'js', :simplify => 'off'
      assert_response :success
      assert_equal false, RedmineSimple.on?
      assert_no_match /simple-hidden/, @response.body
    end

  end
end
