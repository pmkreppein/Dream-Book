class User < ActiveRecord::Base
    has_many :dreams
    has_many :karma, :through => :dreams


    has_secure_password

end #Class end