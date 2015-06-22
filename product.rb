require 'sqlite3'
class Product

  attr_accessor :sku, :model, :brand, :quantity, :cost, :category_id, :store_location_id
  attr_reader :id


  CONNECTION = SQLite3::Database.new("inventory.db")
  def initialize(prodcut_id=nil,sku=nil,model=nil,brand=nil,quantity=nil,cost=nil,category_id=nil,store_location_id=nil)
    @id = prodcut_id
    @sku = sku
    @model = model
    @brand = brand
    @quantity = quantity
    @cost =  cost
    @category_id = category_id
    @store_location_id = store_location_id
  end

  CONNECTION.results_as_hash = true
  CONNECTION.execute("CREATE TABLE IF NOT EXISTS products (id INTEGER PRIMARY KEY, sku INTEGER, model TEXT, brand TEXT, quantity INTEGER, cost INTEGER, category_id INTEGER, store_location_id INTEGER);")

  # allows you to view all products

  def self.all
    results = CONNECTION.execute('SELECT * FROM products;')

    results_as_objects = []

    results.each do |result_hash|
      results_as_objects << Product.new(result_hash["id"],result_hash["sku"], result_hash["model"],result_hash["brand"],result_hash["quantity"], result_hash["cost"], result_hash["category_id"], result_hash["store_location_id"])
    end

    return results_as_objects
  end

  # allows you to add a product to the database after giving all information for each column
  #
  # sku - Int,
  # Model - String,
  # Brand - String,
  # Quantity - Int,
  # Cost - Float,
  # Category_id - Int,
  # Store_location_id - Int

  def self.add(sku,model,brand,quantity,cost,category_id,store_location_id)
    CONNECTION.execute("INSERT INTO products (sku, model, brand, quantity, cost, category_id, store_location_id) VALUES (#{sku},'#{model}', '#{brand}', #{quantity}, #{cost}, #{category_id}, #{store_location_id});")

    id = CONNECTION.last_insert_row_id

    Product.new(id,sku,model,brand,quantity,cost,category_id,store_location_id)
  end

  # Allows you to view all products in a given category
  #
  # Type - Int that points to the id of a category

  def self.where_all_category(type)
    results = CONNECTION.execute("SELECT * FROM products WHERE category_id = #{type};")
    results_as_objects = []

    results.each do |result_hash|
      results_as_objects << Product.new(result_hash["id"],result_hash["sku"], result_hash["model"],result_hash["brand"],result_hash["quantity"], result_hash["cost"], result_hash["category_id"], result_hash["store_location_id"])
    end

    return results_as_objects
  end

  # Allows you to view all products in a given location
  #
  # Id - Int that points to the Id of a location

  def self.where_all_location(id)
    results = CONNECTION.execute("SELECT * FROM products WHERE store_location_id = #{id};")
    results_as_objects = []

    results.each do |result_hash|
      results_as_objects << Product.new(result_hash["id"],result_hash["sku"], result_hash["model"],result_hash["brand"],result_hash["quantity"], result_hash["cost"], result_hash["category_id"], result_hash["store_location_id"])
    end

    return results_as_objects
  end

  # Allows you to change the sku of a given product.
  #
  # New_sku - Int
  def change_sku(new_sku)
    CONNECTION.execute("UPDATE products SET sku = #{new_sku} WHERE id = #{@id};")
  end

  # Allows you to change the brand of a given product.
  #
  # New_brand - String

  def change_brand(new_brand)
    CONNECTION.execute("UPDATE products SET brand = '#{new_brand}' WHERE id = #{@id};")
  end

  # Allows you to change the model of a given product.
  #
  # New_model - String

  def change_model(new_model)
    CONNECTION.execute("UPDATE products SET model = '#{new_model}' WHERE id = #{@id};")
  end

  # Allows you to change the cost of a given product.
  #
  # New_cost - Float

  def change_cost(new_cost)
    CONNECTION.execute("UPDATE products SET cost = #{new_cost} WHERE id = #{@id};")
  end

  # Allows you to change the category of a given product.
  #
  # New_category - Int

  def change_category(new_category)
    CONNECTION.execute("UPDATE products SET category_id = #{new_category} WHERE id = #{@id};")
  end

  # Allows you to change the location of a given product.
  #
  # New_location - Int

  def change_location(new_location)
    CONNECTION.execute("UPDATE products SET store_location_id = #{new_location} WHERE id = #{@id};")
  end

  # Allows you to add to the quantity of a given product.
  #
  # Added_amount - Int

  def add_quantity(added_amount)
    new_quantity = @quantity + added_amount
    CONNECTION.execute("UPDATE products SET quantity = #{new_quantity} WHERE id = #{@id};")
  end

  # Allows you to subtract from the quantity of a given product.
  #
  # Removed_amount - Int

  def remove_quantity(removed_amount)
    quantity = @quantity - removed_amount
    CONNECTION.execute("UPDATE products SET quantity = #{quantity} WHERE id = #{@id};")
  end


  def save
    CONNECTION.execute("UPDATE products SET sku = #{@sku}, model = #{@model}, brand = #{@brand}, quantity = #{@quantity}, cost = #{@cost}, category_id = #{@category_id}, store_location_id = #{@store_location_id} WHERE id = #{@id};")
    #return self
  end

  # Allows you to view all info of a given product

  def where_row
    CONNECTION.execute("SELECT * FROM products WHERE id = #{@id};")
  end

  # Allows you to delete a product

  def delete
    CONNECTION.execute("DELETE FROM products WHERE id = #{@id}")
  end
end