class Portfolio < ActiveRecord::Base
  belongs_to :clients
  has_and_belongs_to_many :stocks
end