class Scan < ActiveRecord::Base
  has_many :vulnerabilities
  belongs_to :user
end
