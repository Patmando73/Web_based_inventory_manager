require "sinatra"
require "sinatra/reloader"
require_relative "product"
require_relative "StoreLocation"
require_relative "category"

get "/save-product" do

  Product.add(params["sku"],params["model"],params["brand"],params["quantity"],params["cost"],params["category_id"],params["location_id"])

  erb :"save-product"
end


get "/save-location" do

  StoreLocation.add(params["store_num"],params["city"])

  erb :"save-location"
end



get "/save-category" do

  Category.add(params["type"])

  erb :"save-category"
end

get "/delete-product" do
  erb :"delete-product"
end

get "/delete-product/:x" do
  @d = Product.new(params["x"].to_i)

  @d.delete
  erb :"delete-success"
end


get "/delete-location/:x" do
  @d = StoreLocation.new(params["x"].to_i)

  @d.delete_location
  erb :"delete-success"
end


get "/delete-category/:x" do
  @d = Category.new(params["x"].to_i)

  @d.delete_category
  erb :"delete-success"
end







get "/view-product" do
  erb :"view-products"
end


get "/view-location" do
  erb :"view-locations"
end


get "/view-category" do
  erb :"view-categories"
end


get "/:webpage" do
  erb :"#{params["webpage"]}"
end


