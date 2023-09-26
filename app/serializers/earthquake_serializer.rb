class EarthquakeSerializer < ActiveModel::Serializer
    attributes :id, :dateTime, :Latitude, :Longitude, :Depth, :Magnitude, :MagType, :NbStations, :Gap, :Distance, :RMS, :Source, :EventID

    def dateTime 
       # puts object.DateTime
        if object.DateTime
            object.DateTime.strftime('%Y-%m-%d %H:%M:%S')
        end
        #object.DateTime.strftime('%Y-%m-%d %H:%M:%S')
    end
end