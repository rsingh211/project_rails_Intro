class Appearance < ApplicationRecord
  belongs_to :character
  belongs_to :film

  validates :character_id, presence: true
  validates :film_id, presence: true
end
