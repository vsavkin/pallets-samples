class Inventory
end

class InventoryLevel
  def remove_inventory inventory, location
    #...
  end

  def add_inventory inventory, location
    #...
  end
end

class Location
  attr_reader :name, :number_of_pallets

  def initialize name, number_of_pallet; end

  def inventory_moved inventory, from_location
    InventoryLevel.remove_inventory inventory, from_location
    InventoryLevel.add_inventory inventory, self
    #...

    from_location.decrement_number_of_pallets
    self.increment_number_of_pallets
  end
end

class Pallet
  attr_reader :number, :location, :inventory

  def initialize number, location, inventory; end

  def move_to new_location
    new_location.inventory_moved inventory, location
    self.location = new_location
    #... notifications ....
  end
end






location_a = Location.new 'A', 1
location_b = Location.new 'B', 0

inventory = Inventory.new

p = Pallet.new '123', location_a, inventory

p.move_to location_b

# It's a traditional OO approach
# Entities do all heavy-lifting

# It's easy to end up with GOD objects
# It's hard to reason about the algorithm as it's scattered across so many objects.
# There is no 1 place where you can go to understand the algorithm
# Too many dependencies between entities