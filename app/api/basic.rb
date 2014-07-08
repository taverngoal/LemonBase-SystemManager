class BasicAPI < Grape::API
  format :json

  resource :users do
    # get do
    #   User.all().select(:email, :name, :nick, :birth, :address, :phone)
    # end


    params do
      requires :email, type: String, regexp: /^(\w)+(\.\w+)*@(\w)+((\.\w+)+)$/
      requires :password, type: String
      optional :name, type: String
      optional :nick, type: String
      optional :birth, type: Date
      optional :address, type: String
      optional :phone, type: String
    end
    get do
      user = User.new email: params[:email], password: params[:password], password_confirmation: params[:password],
                      name: params[:name], nick: params[:nick], birth: params[:birth],
                      address: params[:address], phone: params[:phone]
      if user.save
        true
      else
        user.errors
      end
    end
  end
end