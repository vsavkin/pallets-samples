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
  attr_reader :name

  def initialize name; end

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

# does not scale, God objects
# the more objects are parts of an interaction the harder it's to reason about it
# what if you need to create a pallet shipment each time you move a pallet? Putting it here as well?