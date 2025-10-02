class SimpleDistanceCalculator
  include DistanceCalculatorInterface

  # Calculador simple usando distancia euclidiana (para pruebas o casos específicos)
  def calculate(lat1, lon1, lat2, lon2)
    return 0.0 if lat1 == lat2 && lon1 == lon2

    # Distancia euclidiana simple (aproximada)
    Math.sqrt((lat2 - lat1)**2 + (lon2 - lon1)**2) * 111.32 # Aproximación km por grado
  end
end
