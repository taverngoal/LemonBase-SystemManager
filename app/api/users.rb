class UsersAPI < Grape::API
  format :json
  desc 'Returns your public timeline.'
  get do
    User.all()
  end
end