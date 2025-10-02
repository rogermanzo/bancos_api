class Bank < ApplicationRecord
  validates :nombre, presence: true
  validates :direccion, presence: true
  validates :latitud, presence: true, numericality: { greater_than_or_equal_to: -90, less_than_or_equal_to: 90 }
  validates :longitud, presence: true, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }

  # Método de clase para encontrar el banco más cercano
  def self.banco_mas_cercano(latitud, longitud)
    return [nil, nil] if latitud.zero? && longitud.zero?

    bancos = Bank.all
    return [nil, nil] if bancos.empty?

    banco_mas_cercano = nil
    distancia_minima = Float::INFINITY

    bancos.each do |banco|
      distancia = calcular_distancia(latitud, longitud, banco.latitud, banco.longitud)
      
      if distancia < distancia_minima
        distancia_minima = distancia
        banco_mas_cercano = banco
      end
    end

    # Log warning si la distancia es mayor a 10 km
    if distancia_minima > 10
      Rails.logger.warn "Banco más cercano está a #{distancia_minima.round(2)} km - puede ser muy lejos"
    end

    [banco_mas_cercano, distancia_minima]
  end

  private

  # Calcula la distancia entre dos puntos usando la fórmula de Haversine
  def self.calcular_distancia(lat1, lon1, lat2, lon2)
    # Radio de la Tierra en kilómetros
    radio_tierra = 6371.0

    # Convertir grados a radianes
    lat1_rad = lat1 * Math::PI / 180
    lon1_rad = lon1 * Math::PI / 180
    lat2_rad = lat2 * Math::PI / 180
    lon2_rad = lon2 * Math::PI / 180

    # Diferencias
    dlat = lat2_rad - lat1_rad
    dlon = lon2_rad - lon1_rad

    # Fórmula de Haversine
    a = Math.sin(dlat/2)**2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin(dlon/2)**2
    c = 2 * Math.asin(Math.sqrt(a))

    # Distancia en kilómetros
    radio_tierra * c
  end
end
