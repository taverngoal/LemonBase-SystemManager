require 'grape'
require 'cancan'
class BasicAPI < Grape::API
  # format :json
  before do
    error!('401 Unauthorized', 401) unless headers['Lemon-Auth'] and
        (@current_user=User.auth_with_basic headers['Lemon-Auth'])
  end

  module GeneralHelpers
    extend Grape::API::Helpers
    params :pagination do
      optional :page, type: Integer, default: 0, desc: '第几页'
      optional :count, type: Integer, default: 10, desc: '获取多少条数据'
    end

    def pagination!(obj)
      page, count= params[:page], params[:count]
      obj.limit(count).offset(page*count)
    end
  end

  helpers do
    def current_user
      @current_user
    end

    def authenticate! *args
      ::Ability.new(@current_user).authorize!(*args)
    end

  end

  rescue_from CanCan::AccessDenied do |e|
    error_response status: 403, message: '403 Forbidden!'
  end


  require File.expand_path('../account_api', __FILE__)
  require File.expand_path('../user_api', __FILE__)
  mount UserApi
  mount AccountApi

end