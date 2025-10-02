class DistanceLogger
  include LoggerInterface

  WARNING_THRESHOLD = 10.0 # km

  def log_if_far(distance)
    return unless distance > WARNING_THRESHOLD

    Rails.logger.warn "Banco más cercano está a #{distance.round(2)} km - puede ser muy lejos"
  end
end
