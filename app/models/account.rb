class Account < ActiveRecord::Base
  validates :title, presence: true
end
