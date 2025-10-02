module DistanceCalculatorInterface
  def calculate(lat1, lon1, lat2, lon2)
    raise NotImplementedError, "#{self.class} must implement #calculate"
  end
end
