class UserApi < Grape::API
  helpers BasicAPI::GeneralHelpers

  before do
    @user = User.find params[:id] if params[:id]
  end

  resource :users do
    params do
      use :pagination
    end
    get do
      pagination! User.all().select(:email, :name, :nick, :birth, :address, :phone, :id)
    end



    params do
      requires :email, type: String, regexp: /^(\w)+(\.\w+)*@(\w)+((\.\w+)+)$/
      requires :password, type: String
      optional :name, type: String
      optional :nick, type: String
      optional :birth, type: Date
      optional :address, type: String
      optional :phone, type: String
    end
    post do
      user = User.new email: params[:email], password: params[:password], password_confirmation: params[:password],
                      name: params[:name], nick: params[:nick], birth: params[:birth],
                      address: params[:address], phone: params[:phone]
      (user.errors unless user.save) || user
    end

    params do
      requires :id, type: Integer
    end
    namespace ':id' do
      get do
        @user
      end

      delete do
        @user.errors unless @user.destroy
      end

      params do
        requires :email, type: String, regexp: /^(\w)+(\.\w+)*@(\w)+((\.\w+)+)$/
        optional :password, type: String
        optional :name, type: String
        optional :nick, type: String
        optional :birth, type: Date
        optional :address, type: String
        optional :phone, type: String
      end
      put do
        @user.update_attributes email: params[:email], password: params[:password], password_confirmation: params[:password],
                                name: params[:name], nick: params[:nick], birth: params[:birth],
                                address: params[:address], phone: params[:phone]
      end
    end
  end
end