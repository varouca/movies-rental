require 'test_helper'

class Api::V1::RentalsControllerTest < ActionController::TestCase
  fixtures :users, :movies, :copies, :rentals

  test 'should return an error if no copies available' do
    post :rent, params: { user_id: users(:one).id, movie_id:  movies(:one).id, media: 'vhs' }, format: :json

    assert_response :not_found
    error_response = JSON.parse(response.body)
    assert_equal 'Sorry, no copies available at the moment', error_response['error']
  end

  test 'should update rental when returning a copy' do
    rental = rentals(:one)
    put :bring_back, params: { id: rental.id }, format: :json

    assert_response :success
    rental_response = JSON.parse(response.body)
    assert_equal 'Rental returned successfully.', rental_response['message']
    assert_equal rental.id, rental_response['rental']['id']
    assert_equal Date.today.to_s, rental_response['rental']['returned_date']
  end

  test 'should include overdue message when rental is overdue' do
    rental = rentals(:overdue)
    put :bring_back, params: { id: rental.id }, format: :json

    assert_response :success
    rental_response = JSON.parse(response.body)
    assert_equal 'Rental returned successfully and is overdue.', rental_response['message']
    assert_equal rental.id, rental_response['rental']['id']
    assert_equal Date.today.to_s, rental_response['rental']['returned_date']
  end
end
