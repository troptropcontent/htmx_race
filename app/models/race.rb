class Race < ApplicationRecord
  has_and_belongs_to_many :owners, join_table: :race_owners, class_name: "User", association_foreign_key: :user_id
  has_many :participants, dependent: :destroy
end
