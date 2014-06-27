class Admin::BaseController < ApplicationController
  add_breadcrumb :index, controller: '/admin'
  layout 'admin'
end