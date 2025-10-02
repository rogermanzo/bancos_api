class NotificationService
  DISTANCE_THRESHOLD = 10.0 # km

  def self.notify_far_bank(distance, bank, coordinates)
    return unless distance > DISTANCE_THRESHOLD

    message = build_notification_message(distance, bank, coordinates)
    log_notification(message)
    # Aquí se podría integrar con servicios externos (email, Slack, etc.)
  end

  private

  def self.build_notification_message(distance, bank, coordinates)
    "ALERTA: Banco más cercano (#{bank.nombre}) está a #{distance.round(2)}km " \
    "desde coordenadas (#{coordinates[:lat]}, #{coordinates[:lng]})"
  end

  def self.log_notification(message)
    Rails.logger.warn "[BANK_DISTANCE_ALERT] #{message}"
  end
end
