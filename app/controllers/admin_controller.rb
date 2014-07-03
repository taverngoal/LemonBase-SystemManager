class AdminController < ApplicationController
  layout 'admin'

  def index
  end

  def sign_in
    if @user = login(params[:email], params[:password])
      redirect_back_or_to(admin_index_path, notice: 'Login successful')
    else
      flash[:alert] = 'Login failed'
      redirect_to home_login_path
    end
  end
end
