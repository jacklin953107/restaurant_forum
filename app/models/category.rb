class Category < ApplicationRecord
  validates_presence_of :name
  has_many :restaurants, dependent: :destroy
  default_scope {order(id: :asc)}
end
