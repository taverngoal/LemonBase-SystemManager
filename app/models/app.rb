class App < ActiveRecord::Base
  validates :name, presence: true
  validates :permission_level, presence: true
end
