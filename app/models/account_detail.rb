class AccountDetail < ActiveRecord::Base
  validates :title, :sum, :user, :account_id, :amount, presence: true


  belongs_to :user
  belongs_to :account
end
