class BasicAPI < Grape::API
  format :json
  http_basic do |username, password|
    { 'test' => 'password1' }[username] == password
  end

  before do
  end

  mount UserApi

end