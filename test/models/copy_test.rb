require 'test_helper'

class CopyTest < ActiveSupport::TestCase
  test 'should have many rentals' do
    copy = copies(:one)
    assert_respond_to copy, :rentals
  end

  test 'should belong to a movie' do
    copy = copies(:one)
    assert_respond_to copy, :movie
  end
end
