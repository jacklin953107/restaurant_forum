class Category < ApplicationRecord
  validates_presence_of :name
  has_many :restaurants, dependent: :restrict_with_error
  default_scope {order(id: :asc)}
end
