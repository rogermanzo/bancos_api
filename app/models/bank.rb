class Bank < ApplicationRecord
  validates :nombre, presence: true
  validates :direccion, presence: true
  validates :latitud, presence: true, numericality: { greater_than_or_equal_to: -90, less_than_or_equal_to: 90 }
  validates :longitud, presence: true, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }

  # Método de clase para encontrar el banco más cercano
  def self.banco_mas_cercano(latitud, longitud, options = {})
    finder = BankServiceFactory.create_nearest_bank_finder(latitud, longitud, options)
    finder.find
  end
end
