# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require "csv"


Product.destroy_all
Category.destroy_all


csv_file = Rails.root.join('db/products.csv')
csv_data = File.read(csv_file)
products = CSV.parse(csv_data, headers: true)

products.each do |product_row|
  category = Category.find_or_create_by(name: product_row["category"])
  
  product = Product.create!(
    title: product_row["title"],
    description: product_row["description"],
    price: product_row["price"],
    stock_quantity: product_row["stock_quantity"],
    category: category
  )
  
  puts "Created product: #{product.title} in category: #{category.name}"
end

puts "Created #{Category.count} categories"
puts "Created #{Product.count} products"

# 676.times do
#   Product.create!(
#     title: Faker::Commerce.product_name,
#     description: Faker::Lorem.paragraph(sentence_count: 3),
#     price: Faker::Commerce.price(range: 1..100.0),
#     stock_quantity: Faker::Number.between(from: 0, to: 100)
#   )
# end

# puts "Created #{Product.count} products"#