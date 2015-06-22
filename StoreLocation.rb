require 'sqlite3'
class StoreLocation
attr_accessor :city
attr_reader :id, :store_num
CONNECTION = SQLite3::Database.new("inventory.db")
def initialize(location_id=nil, store_num=nil, city=nil)
@id = location_id
@city = city
@store_num = store_num
end

CONNECTION.results_as_hash = true
CONNECTION.execute("CREATE TABLE IF NOT EXISTS store_locations (id INTEGER PRIMARY KEY, store_num INTEGER, city TEXT);")
#CONNECTION.execute('INSERT INTO store_locations (store_num, city) VALUES (1093, "Papillion");')
#CONNECTION.execute('INSERT INTO store_locations (store_num, city) VALUES (206, "Omaha");')

# Finds an existing location in the table and creates an object for it.
#
# id - Integer
#
# Returns a new object.

def self.find(id)
@id = id

result = CONNECTION.execute("SELECT * FROM store_locations WHERE id = #{@id};").first

temp_name = result["city"]
temp_num = result["store_num"]

StoreLocation.new(id,temp_num, temp_name)
end


# Allows you to view all locations.

  def self.all
    results = CONNECTION.execute('SELECT * FROM store_locations;')

    results_as_objects = []

    results.each do |result_hash|
    results_as_objects << StoreLocation.new(result_hash["id"], result_hash["store_num"], result_hash["city"])
  end

return results_as_objects
end


# allows you to add a location to the table.
#
# Store_num - Int
# City - String

  def self.add(store_num, city)
    CONNECTION.execute("INSERT INTO store_locations (store_num, city) VALUES (#{store_num}, '#{city}');")

    id = CONNECTION.last_insert_row_id

    StoreLocation.new(id, store_num, city)
  end


def save
CONNECTION.execute("UPDATE store_locations SET city = '#{@city}', store_num = #{@store_num} WHERE id = #{@id};")
end


# Allows you to change a location in the table
#
#

def change_location_num(store_num)
CONNECTION.execute("UPDATE store_locations SET store_num = #{store_num} WHERE id = #{@id};")
end

# Allows you to change a location in the table
#
# City - String

def change_location_city(city)
CONNECTION.execute("UPDATE store_locations SET city = '#{city}' WHERE id = #{@id};")
end

# Allows you to delete a location from the table

def delete_location
CONNECTION.execute("DELETE FROM store_locations WHERE id = #{@id};")
end
end