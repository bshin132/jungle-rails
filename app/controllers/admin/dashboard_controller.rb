class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV['ADMIN_USER'], password: ENV['ADMIN_PW']
  def show
    @products = Product.order(id: :desc).all
    @categories = Category.all
  end
end
