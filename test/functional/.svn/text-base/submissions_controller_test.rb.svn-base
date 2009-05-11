require 'test_helper'

class SubmissionsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:submissions)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_submission
    assert_difference('Submission.count') do
      post :create, :submission => { }
    end

    assert_redirected_to submission_path(assigns(:submission))
  end

  def test_should_show_submission
    get :show, :id => submissions(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => submissions(:one).id
    assert_response :success
  end

  def test_should_update_submission
    put :update, :id => submissions(:one).id, :submission => { }
    assert_redirected_to submission_path(assigns(:submission))
  end

  def test_should_destroy_submission
    assert_difference('Submission.count', -1) do
      delete :destroy, :id => submissions(:one).id
    end

    assert_redirected_to submissions_path
  end
end
