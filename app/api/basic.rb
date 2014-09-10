class BasicAPI < Grape::API
  format :json
  http_basic do |username, password|
    App.authorize! username, password
  end

  module GeneralHelpers
    extend Grape::API::Helpers
    params :pagination do
      optional :page, type: Integer, default: 0, desc: '第几页'
      optional :count, type: Integer, default: 20, desc: '获取多少条数据'
    end

    def pagination!(obj)
      page, count= params[:page], params[:count]
      obj.limit(count).offset(page*count)
    end
  end

  mount UserApi
  mount AccountApi

end