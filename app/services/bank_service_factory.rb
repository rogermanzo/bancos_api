class BankServiceFactory
  def self.create_nearest_bank_finder(latitud, longitud, options = {})
    distance_calculator = options[:distance_calculator] || DistanceCalculator.new
    logger = options[:logger] || DistanceLogger.new

    NearestBankFinder.new(latitud, longitud, 
                         distance_calculator: distance_calculator, 
                         logger: logger)
  end
end
