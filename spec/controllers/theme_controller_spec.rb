require 'rails_helper'

describe ThemeController, type: :controller do
  render_views

  before { create(:blog, theme: 'plain') }

  it 'test_stylesheets' do
    get :stylesheets, params: { filename: 'theme.css' }
    assert_response :success
    assert_equal 'text/css', @response.content_type
    assert_equal 'utf-8', @response.charset
    assert_equal 'inline; filename="theme.css"', @response.headers['Content-Disposition']
  end

  it 'test_malicious_path' do
    get :stylesheets, params: { filename: '../../../config/database.yml' }
    assert_response 404
  end
end
