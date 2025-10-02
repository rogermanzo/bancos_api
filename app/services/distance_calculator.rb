class DistanceCalculator
  include DistanceCalculatorInterface

  # Radio de la Tierra en kilómetros
  EARTH_RADIUS = 6371.0

  def calculate(lat1, lon1, lat2, lon2)
    return 0.0 if lat1 == lat2 && lon1 == lon2

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
    EARTH_RADIUS * c
  end
end
