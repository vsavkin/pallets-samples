class Inventory
end

class InventoryLevel
  def self.remove_inventory inventory, location
    #...
  end

  def self.add_inventory inventory, location
    #...
  end
end

class Location
  attr_reader :name

  def initialize name; end
end

class Pallet
  attr_reader :number, :location, :inventory

  def initialize number, location, inventory; end

  def update_location new_location
    #...
  end
end





class MovePalletService
  def self.move_pallet pallet, new_location
    #...
    InventoryLevel.remove_inventory pallet.inventory, pallet.location
    InventoryLevel.add_inventory pallet.inventory, new_location


    pallet.location.decrement_number_of_pallets
    new_location.increment_number_of_pallets

    #...
    pallet.update_location new_location
    # if new_location is a staging location do some magical stuff
    #... notifications ....
  end
end




location_a = Location.new 'A'
location_b = Location.new 'B'

inventory = Inventory.new

pallet = Pallet.new '123', location_a, inventory

PalletMoveService.move_pallet pallet, location_b



# Services do all heavy-lifting
# It's a step in the right direction
# One place to go and check out the algorithm
# It's procedural. It doesn't match the end user's mental model.
# There is no MovePalletService in the warehouse
# All actors are implicit