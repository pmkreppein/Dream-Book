class Dream < ActiveRecord::Base
  belongs_to :user
  has_many :karma
end
