class User < ApplicationRecord
  validates_presence_of :username
  validates :username, uniqueness: true
  has_many :reviews, :dependent => :destroy
end
