class Karma < ActiveRecord::Base
    belongs_to :dream
    belongs_to :user
end