require 'sqlite3'
class Category
  CONNECTION = SQLite3::Database.new("inventory.db")

  attr_accessor :type
  attr_reader :id
  def initialize(category_id=nil, type=nil)
    @id = category_id
    @type = type

  end

  CONNECTION.results_as_hash = true
  CONNECTION.execute("CREATE TABLE IF NOT EXISTS categories (id INTEGER PRIMARY KEY, type TEXT);")




  def self.find(id)

    result = CONNECTION.execute("SELECT * FROM categories WHERE id = #{id};").first

    temp_type = result["type"]

    Category.new(id, temp_type)
  end

# Allows you to view all categories.

  def self.all
    results = CONNECTION.execute('SELECT * FROM categories;')

    results_as_objects = []

    results.each do |result_hash|
      results_as_objects << Category.new(result_hash["id"], result_hash["type"])
    end

    return results_as_objects
  end


# allows you to add a category to the table.
#
# Type - String
  def self.add(type)
    CONNECTION.execute("INSERT INTO categories (type) VALUES ('#{type}');")

    id = CONNECTION.last_insert_row_id

    Category.new(id, type)
  end


  def save
    CONNECTION.execute("UPDATE categories SET type = '#{@type}' WHERE id = #{@id};")
  end

# Allows you to change a category type
#
# Type - String

# def change_category(type)
#   CONNECTION.execute("UPDATE categories SET type = #{type} WHERE id = #{@id};")
#
# end

# Allows you to delete a category from the table

  def delete_category
    CONNECTION.execute("DELETE FROM categories WHERE id = #{@id}")
  end
end