require "CSV"
class StatTracker
 attr_reader  :locations

  def self.from_csv(locations)
    StatTracker.new(locations)
    @game = CSV.read(locations[:games])

    require "pry"; binding.pry
    self.new
  end

  def initialize(locations)
    @locations = locations
  end

end
