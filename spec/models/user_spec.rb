require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'is invalid if password is empty' do
      @user = User.new(
        first_name: "Brian",
        last_name: "Shin",
        email: "test@test.com",
        password: nil,
        password_confirmation: "1234"
      )
      expect(@user).to be_invalid
      expect(@user.errors.full_messages).to include("Password cannot be blank.")
    end

    it 'is invalid if password and confirmation do not match' do
      @user = User.new(
        first_name: "Brian",
        last_name: "Shin",
        email: "test@test.com",
        password: "1234",
        password_confirmation: "5678"
      )
      expect(@user).to be_invalid
      expect(@user.errors.full_messages).to include("Password confirmation does not match with Password.")
    end

    it 'is invalid if email already exists' do
      @user = User.new(
        first_name: "Brian",
        last_name: "Shin",
        email: "test@test.com",
        password: "1234",
        password_confirmation: "1234"
      )
      @user2 = User.new(
        first_name: "Brian",
        last_name: "Shin",
        email: "test@test.com",
        password: "1234",
        password_confirmation: "1234"
      )
      expect(@user).to be_invalid
      expect(@user.errors.full_messages).to include("Email already exists.")
    end

    it 'is invalid if first name is empty' do
      @user = User.new(
        first_name: nil,
        last_name: "Shin",
        email: "test@test.com",
        password: "1234",
        password_confirmation: "1234"
      )
      expect(@user).to be_invalid
      expect(@user.errors.full_messages).to include("First name cannot be blank.")
    end

    it 'is invalid if last name is empty' do
      @user = User.new(
        first_name: "Brian",
        last_name: nil,
        email: "test@test.com",
        password: "1234",
        password_confirmation: "1234"
      )
      expect(@user).to be_invalid
      expect(@user.errors.full_messages).to include("Last name cannot be blank.")
    end

    it 'is invalid if password is too short' do
      @user = User.new(
        first_name: "Brian",
        last_name: "Shin",
        email: "test@test.com",
        password: "123",
        password_confirmation: "123"
      )
      expect(@user).to be_invalid
      expect(@user.errors.full_messages).to include("Password needs to be longer than 4 characters.")
    end
  end

  describe '.authenticate_with_credentials' do
    it 'returns nil if email and password are nil' do
      expect(User.authenticate_with_credentials(nil, nil)).to eq(nil)
    end

    it 'returns nil if email is invalid' do
      expect(User.authenticate_with_credentials('hello', 'nil')).to eq(nil)
    end

    it 'returns nil if email is nil' do
      expect(User.authenticate_with_credentials(nil, 'nil')).to eq(nil)
    end

    it 'returns nil if password is nil' do
      expect(User.authenticate_with_credentials("Bob@bob.com", nil)).to eq(nil)
    end

    it 'returns a user if email and password are correct' do
      User.new(
        first_name: "Brian",
        last_name: "Shin",
        email: "test@test.com",
        password: "1234",
        password_confirmation: "1234"
      ).save
      @user = User.authenticate_with_credentials("test@test.com", "1234")
      expect(@user.email).to eq("test@test.com")
    end

    it 'returns a user if email has trailing spaces' do
      User.new(
        first_name: "Brian",
        last_name: "Shin",
        email: "test@test.com",
        password: "1234",
        password_confirmation: "1234"
      ).save
      @user = User.authenticate_with_credentials("  test@test.com  ", "1234")
      expect(@user.email).to eq("test@test.com")
    end

    it 'returns a user if email is ramdonly capitalized' do
      User.new(
        first_name: "Brian",
        last_name: "Shin",
        email: "test@test.com",
        password: "1234",
        password_confirmation: "1234"
      ).save
      @user = User.authenticate_with_credentials("teSt@TeST.cOM", "1234")
      expect(@user.email).to eq("test@test.com")
    end

  end


end