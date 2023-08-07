# test/controllers/api/v1/rentals_controller_test.rb
require 'test_helper'

class Api::V1::RentalsControllerTest < ActionController::TestCase
  fixtures :users, :movies, :copies, :rentals

  test 'should return an error if no copies available' do
    post :create, params: { user_id: users(:one).id, movie_id:  movies(:one).id, media: 'vhs' }, format: :json

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

  test 'should get rental history by user' do
    user = users(:two)
    get :history_by_user, params: { user_id: user.id }, format: :json

    assert_response :success
    rentals_response = JSON.parse(response.body)
    assert_equal user.rentals.count, rentals_response.size
    assert_equal user.rentals.pluck(:id).sort, rentals_response.map { |rental| rental['id'] }.sort
    assert_equal user.rentals.pluck(:copy_id), rentals_response.map { |rental| rental['copy']['id'] }
    assert_equal user.rentals.pluck(:bluray), rentals_response.map { |rental| rental['copy']['media'] }
  end

  test 'should get active rentals by user' do
    user = users(:two)
    get :active_by_user, params: { user_id: user.id }, format: :json

    assert_response :success
    rentals_response = JSON.parse(response.body)
    assert_equal user.rentals.active.count, rentals_response.size
    assert_equal user.rentals.active.pluck(:id).sort, rentals_response.map { |rental| rental['id'] }.sort
    assert_equal user.rentals.active.pluck(:copy_id), rentals_response.map { |rental| rental['copy']['id'] }
    assert_equal user.rentals.active.pluck(:bluray), rentals_response.map { |rental| rental['copy']['media'] }
  end
end
