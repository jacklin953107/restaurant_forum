class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, calss_name: "User"
end
