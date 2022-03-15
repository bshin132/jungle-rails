require 'rails_helper'

RSpec.feature "User clicks on a product to see details", type: :feature, js: true do
 
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'
    @category.products.create!(
      name:  Faker::Hipster.sentence(3),
      description: Faker::Hipster.paragraph(4),
      image: open_asset('apparel1.jpg'),
      quantity: 10,
      price: 64.99
    )
  end

  scenario "They click a product to see details page" do
    #ACT
    visit root_path
    page.find('a.btn-default').click


    #VERIFY
    expect(page).to have_content('Description')

    #DEBUG
    save_screenshot
    # puts page.html
  end
end