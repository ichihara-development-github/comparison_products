class Price < ApplicationRecord
  validates :name, presence: true, uniqueness: true
end
