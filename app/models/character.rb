class Character < ApplicationRecord
    has_many :appearances
    has_many :films, through: :appearances
    validates :name, :species, :birth_year, presence: true
  end
  