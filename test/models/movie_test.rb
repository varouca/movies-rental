require 'test_helper'

class MovieTest < ActiveSupport::TestCase
  test 'should not save movie without title' do
    movie = Movie.new
    assert_not movie.save, 'Saved movie without a title'
  end

  test 'should not save movie without year' do
    movie = Movie.new(title: 'Some Movie')
    assert_not movie.save, 'Saved movie without a year'
  end

  test 'should not save movie with invalid year' do
    movie = Movie.new(title: 'Some Movie', year: 1800)
    assert_not movie.save, 'Saved movie with an invalid year'
  end

end
