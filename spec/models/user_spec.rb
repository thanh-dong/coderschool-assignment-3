require 'rails_helper'

RSpec.describe User, type: :model do
  it 'should validate name presence'  do
    user = User.new(email: 'email@email.com', password:'12344')
    user.save

    error_message = "Name can't be blank"
    expect(user.errors.full_messages).to include error_message
  end

  it 'should validate email presence'  do
    user = User.new(name: 'Users name', password:'12344')
    user.save

    error_message = "Email can't be blank"
    expect(user.errors.full_messages).to include error_message
  end

  it 'should validate name presence'  do
    user = User.new(email: 'email@email.com', name: 'User name')
    user.save

    error_message = "Password can't be blank"
    expect(user.errors.full_messages).to include error_message
  end
end
