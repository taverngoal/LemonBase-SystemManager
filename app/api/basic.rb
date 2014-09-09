class BasicAPI < Grape::API
  format :json
  http_basic do |username, password|
    App.authorize! username, password

  end

  http_digest do

  end

  before do
  end

  mount UserApi

end