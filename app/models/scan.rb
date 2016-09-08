class Scan < ActiveRecord::Base
  has_many :vulnerabilities
end
