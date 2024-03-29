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



class PalletMoveContext
  include Context

  def self.move_pallet pallet_number, location_id
    pallet = Pallet.find_by_number pallet_number
    return {errors: ['Invalid pallet number']} unless pallet

    location = Location.find_by_id location_id
    return {errors: ['Invalid location']} unless location

    PalletMoveContext.new(pallet, location).move
  end

  attr_reader :source, :destination, :pallet

  def initialize pallet, location
    @source = pallet.location extend Source
    @destination = location extend Destination
    @pallet = pallet
  end

  def move
    in_context do
      source.move_pallet_to_destination
      #send notifications
      {status: 'OK'}
    end
  rescue SomeObscureException
    {errors: ["Panic Mode"]}
  end

  module Source
    include Role

    def move_pallet_to_destination
      InventoryLevel.remove_inventory context.pallet.inventory, self
      decrement_number_of_pallets
      context.destination.receive_pallet
    end
  end

  module Destination
    include Role

    def receive_pallet
      p = context.pallet
      InventoryLevel.add_inventory p.inventory, self
      increment_number_of_pallets
      p.update_location self
    end
  end
end




location_a = Location.new 'A'
location_b = Location.new 'B'

inventory = Inventory.new

pallet = Pallet.new '123', location_a, inventory

PalletMoveContext.move_pallet "123", location_b.id


# all roles are explicit
# everything is isolated
# it's a facade
# from client's perspective there is no point to specify source location
# but from the code's perspective it's crucial

# pallet is a methodless role
# location i sa methodfull role