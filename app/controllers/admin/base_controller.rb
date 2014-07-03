class Admin::BaseController < ApplicationController
  before_filter :require_login
  add_breadcrumb :index, controller: '/admin'
  layout 'admin'

  private
  def not_authenticated
    redirect_to home_login_path, alert: "Please login first"
  end
end