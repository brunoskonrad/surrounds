RGeo::ActiveRecord::SpatialFactoryStore.instance.tap do |config|
  # By default, use the GEOS implementation for spatial columns.
  config.default = RGeo::Cartesian.factory(srid: 4326)

  # But use a geographic implementation for point columns.
  config.register(RGeo::Geographic.spherical_factory(srid: 4326), geo_type: "point")
end

# The following code is to overwrite `st_srid` to enable it to receive the expected
# SRID as a parameter. The original implementation does not let you do so.
# Check it here: https://github.com/rgeo/rgeo-activerecord/blob/master/lib/rgeo/active_record/spatial_expressions.rb#L44-L46
module RGeo
  module ActiveRecord
    module SpatialExpressions
      def st_srid(srid)
        SpatialNamedFunction.new("ST_SRID", [self, srid], [false, true, true])
      end
    end
  end
end