class RecommendationEngine
  def self.recommendations(favorite_movies)
    genres = Movie.where(id: favorite_movies).pluck(:genre)
    common_genres = genres.group_by{ |e| e }.sort_by{ |k, v| -v.length }.map(&:first).take(3)
    Movie.where(genre: common_genres).order(rating: :desc).limit(10)
  end
end