class Character < ApplicationRecord
    has_many :appearances, dependent: :destroy
    has_many :films, through: :appearances
  
    # Validations
    validates :name, presence: true, uniqueness: true
    validates :species, presence: true
    validates :birth_year, presence: true
    validates :gender, presence: true, inclusion: { in: %w[male female other unknown] }
  end
  