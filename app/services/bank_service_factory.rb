class BankServiceFactory
  def self.create_nearest_bank_finder(latitude, longitude, options = {})
    distance_calculator = options[:distance_calculator] || DistanceCalculator.new
    logger = options[:logger] || DistanceLogger.new

    NearestBankFinder.new(latitude, longitude, 
                         distance_calculator: distance_calculator, 
                         logger: logger)
  end
end
