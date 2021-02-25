class SearchMomentsAroundPoint < ApplicationService

  attr_reader :point, :search_radius

  def initialize(point, search_radius = 100)
    @point = point
    @search_radius = search_radius
  end
    
  def call
    Moment.where(moment_is_inside_search_radius)
  end

  private

  def moment_is_inside_search_radius
    Arel
      .spatial("POINT(#{point.x} #{point.y})")
      .st_srid(4326)
      .st_distance(Moment.arel_table[:position])
      .lt(search_radius)
  end

end