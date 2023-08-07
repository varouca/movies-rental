require 'test_helper'

class RentalsControllerTest < ActionController::TestCase
  test 'should update the rental returned_date' do
    rental = create(:rental, returned_date: nil)
    put :bring_back, params: { id: rental.id }
    rental.reload
    assert_equal Date.today, rental.returned_date
  end

  test 'should render JSON with success message if returned_date is before due_date' do
    rental = create(:rental, returned_date: Date.today - 1, due_date: Date.today)
    put :bring_back, params: { id: rental.id }
    assert_response :ok
    json_response = JSON.parse(response.body)
    assert_equal 'Rental returned successfully.', json_response['message']
  end

  test 'should render JSON with overdue message if returned_date is after due_date' do
    rental = create(:rental, returned_date: Date.today + 1, due_date: Date.today)
    put :bring_back, params: { id: rental.id }
    assert_response :ok
    json_response = JSON.parse(response.body)
    assert_equal 'Rental returned successfully and is overdue.', json_response['message']
  end
end