class Film < ApplicationRecord
    has_many :appearances, dependent: :destroy
    has_many :characters, through: :appearances
  
    # Validations
    validates :title, presence: true, uniqueness: true
    validates :episode, presence: true, numericality: { only_integer: true, greater_than: 0 }
    validates :release_date, presence: true
  end
  