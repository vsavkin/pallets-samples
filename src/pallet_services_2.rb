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
end

class Pallet
  attr_reader :number, :location, :inventory

  def initialize number, location, inventory; end

  def update_location new_location
    #...
  end
end





class MovePalletService
  def self.move_pallet pallet_number, location_id
    pallet = Pallet.find_by_number pallet_number
    return {errors: ['Invalid pallet number']} unless pallet

    location = Location.find_by_id location_id
    return {errors: ['Invalid location']} unless location

    #...
    InventoryLevel.remove_inventory pallet.inventory, pallet.location
    InventoryLevel.add_inventory pallet.inventory, new_location


    pallet.location.decrement_number_of_pallets
    location.increment_number_of_pallets

    #...
    pallet.update_location new_location
    # if new_location is a staging location do some magical stuff
    #... notifications ....

    {status: 'OK'}
  resuce SomeObscureException
    {errors: ["Panic Mode"]}
  end
end




location_a = Location.new 'A'
location_b = Location.new 'B'

inventory = Inventory.new

pallet = Pallet.new '123', location_a, inventory

PalletMoveService.move_pallet "123", location_b.id

# it's a step in a right direction
# all behaviour is localized in one file -> good
# it's procedural. It doesn't match end users mental model.
# End users don't know anything about pallet move services
# what are the roles?
# it's a huge procedure