require 'test_helper'

class RentalTest < ActiveSupport::TestCase
  test 'should not save rental without checkout_date' do
    rental = Rental.new
    assert_not rental.save, 'Saved rental without checkout_date'
  end

  test 'should not save rental without due_date' do
    rental = Rental.new(checkout_date: Date.today)
    assert_not rental.save, 'Saved rental without due_date'
  end

  test 'should belong to a copy' do
    rental = rentals(:one)
    assert_respond_to rental, :copy
  end

  test 'should belong to a user' do
    rental = rentals(:one)
    assert_respond_to rental, :user
  end
end
