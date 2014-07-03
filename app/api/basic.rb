class BasicAPI < Grape::API
  format :json

  resource :users do
    get do
      User.all().select(:email, :name, :nick)
    end


    post do

    end
  end
end