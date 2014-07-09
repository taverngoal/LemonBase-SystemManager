class Account < ActiveRecord::Base
  validates :title, presence: true
  validates :creator, presence: true
  validates :officer, presence: true

  belongs_to :creator, class_name: 'User', foreign_key: :creator
  belongs_to :officer, class_name: 'User', foreign_key: :officer
end
