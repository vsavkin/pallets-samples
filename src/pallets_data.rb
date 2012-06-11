class Location
  attr_reader :name, :number_of_pallets

  def initialize name, number_of_pallets
    @name = name
    @number_of_pallets = number_of_pallets
  end

  def increment_number_of_pallets
    @number_of_pallets += 1
  end

  def decrement_number_of_pallets
    @number_of_pallets -= 1
  end
end

class Inventory
end

class Pallet
  attr_reader :number, :location, :inventory

  def initialize number, location, inventory
    @number = number
    @location = location
    @inventory = inventory
  end
end

