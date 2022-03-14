require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'product will save' do
      @category = Category.new(name: "Balls")
      @product = Product.new(
        name: 'Tennis Ball',
        price: 16,
        quantity: 16,
        category: @category
      )
      @product.save
      expect(@product).to be_valid
    end

    it 'name is required' do
      @category = Category.new(name: "Balls")
      @product = Product.new(
        name: nil,
        price: 5,
        quantity: 20,
        category: @category
      )
      @product.save
      expect(@product).to be_invalid
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it 'price is required' do
      @category = Category.new(name: "Balls")
      @product = Product.new(
        name: "Soccer Ball",
        price: nil,
        quantity: 7,
        category: @category
      )
      @product.save
      expect(@product).to be_invalid
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it 'quantity is required' do
      @category = Category.new(name: "Balls")
      @product = Product.new(
        name: "Pingpong Ball",
        price: 3,
        quantity: nil,
        category: @category
      )
      @product.save
      expect(@product).to be_invalid
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'category is required' do
      @category = Category.new(name: "Balls")
      @product = Product.new(
        name: "Basketball Ball",
        price: 69,
        quantity: 23,
        category: nil
      )
      @product.save
      expect(@product).to be_invalid
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end

  end
end 