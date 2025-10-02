class MetricsService
  def self.record_distance_metric(distance, bank_id, coordinates)
    # En un entorno real, esto se enviaría a un sistema de métricas
    # como Prometheus, DataDog, o New Relic
    
    Rails.logger.info "[METRICS] Distance: #{distance.round(2)}km, " \
                      "Bank: #{bank_id}, " \
                      "Location: (#{coordinates[:lat]}, #{coordinates[:lng]})"
    
    # Aquí se podría almacenar en Redis o base de datos para análisis
    store_metric(distance, bank_id, coordinates)
  end

  private

  def self.store_metric(distance, bank_id, coordinates)
    # Implementación para almacenar métricas
    # En producción, usar un sistema de métricas real
    Rails.cache.write("distance_metric_#{Time.current.to_i}", {
      distance: distance,
      bank_id: bank_id,
      coordinates: coordinates,
      timestamp: Time.current
    }, expires_in: 1.hour)
  end
end
