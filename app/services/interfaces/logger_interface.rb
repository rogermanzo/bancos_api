module LoggerInterface
  def log_if_far(distance)
    raise NotImplementedError, "#{self.class} must implement #log_if_far"
  end
end
