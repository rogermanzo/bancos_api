class NearestBankFinder
  def initialize(latitude, longitude, distance_calculator: DistanceCalculator.new, logger: DistanceLogger.new)
    @latitude = latitude
    @longitude = longitude
    @distance_calculator = distance_calculator
    @logger = logger
  end

  def find
    return [nil, nil] if invalid_coordinates?

    banks = Bank.all
    return [nil, nil] if banks.empty?

    find_nearest_bank(banks)
  end

  private

  def invalid_coordinates?
    @latitude.zero? && @longitude.zero?
  end

  def find_nearest_bank(banks)
    nearest_bank = nil
    min_distance = Float::INFINITY

    banks.each do |bank|
      distance = @distance_calculator.calculate(@latitude, @longitude, bank.latitud, bank.longitud)
      
      if distance < min_distance
        min_distance = distance
        nearest_bank = bank
      end
    end

    @logger.log_if_far(min_distance)
    [nearest_bank, min_distance]
  end
end
