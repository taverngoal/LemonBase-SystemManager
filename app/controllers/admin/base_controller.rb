class Admin::BaseController < ApplicationController
  before_filter :require_login
  add_breadcrumb :index, controller: '/admin'
  layout 'admin'

end