class BasicAPI < Grape::API
  format :json

  before do
    access_key = headers[:access_key]
    p env
  end

  mount UserApi

end