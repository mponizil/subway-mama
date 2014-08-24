class ViewController < UIViewController
  def viewDidLoad
    super

    url = "http://datamine.mta.info/mta_esi.php?key=%s&feed_id=2" % MTA_API_KEY

    data = NSData.dataWithContentsOfURL(NSURL.URLWithString(url))
    feed = FeedMessage.parseFromData(data)
    trains = feed.entity.select { |e| e.tripUpdate.trip.routeId != "" }

    dekalb_updates = []
    trains.each do |train|
      dekalb_stops = train.tripUpdate.stopTimeUpdate.select { |u| u.stopId.start_with?('L16') }
      if dekalb_stops.length > 0
        dekalb_updates += dekalb_stops
      end
    end

    dekalb_updates.each do |update|
      notification = UILocalNotification.alloc.init
      arrival = NSDate.dateWithTimeIntervalSince1970(update.arrival.time)
      notification.fireDate = arrival.dateByAddingTimeInterval(-4 * 60)
      notification.alertBody = "Subway %s at Dekalb in 4 minutes: %s" % [update.stopId, arrival]
      notification.soundName = UILocalNotificationDefaultSoundName
      UIApplication.sharedApplication.scheduleLocalNotification(notification)
    end

  end
end
