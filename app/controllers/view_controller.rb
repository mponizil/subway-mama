class ViewController < UIViewController
  def viewDidLoad
    super

    target_station = 'L16'
    target_direction = 'S'
    target_stop = "#{target_station}#{target_direction}"

    url = "http://datamine.mta.info/mta_esi.php?key=%s&feed_id=2" % MTA_API_KEY

    data = NSData.dataWithContentsOfURL(NSURL.URLWithString(url))
    feed = FeedMessage.parseFromData(data)
    trains = feed.entity.select { |e| e.tripUpdate.trip.routeId != "" }

    target_updates = []
    trains.each do |train|
      target_updates += train.tripUpdate.stopTimeUpdate.select { |u| u.stopId == target_stop }
    end

    target_updates.each do |update|
      notification = UILocalNotification.alloc.init
      arrival = NSDate.dateWithTimeIntervalSince1970(update.arrival.time)
      notification.fireDate = arrival.dateByAddingTimeInterval(-4 * 60)
      puts "Alert at #{notification.fireDate}: Subway #{update.stopId} at Dekalb in 4 minutes: #{arrival}"
      notification.alertBody = "RUN BOY!! Subway #{update.stopId} at Dekalb in 4 minutes: #{arrival}"
      notification.soundName = UILocalNotificationDefaultSoundName
      UIApplication.sharedApplication.scheduleLocalNotification(notification)
    end

    # For debugging, illustrate a notification 10 seconds after launching
    notification = UILocalNotification.alloc.init
    notification.alertBody = "RUN BOY"
    notification.fireDate = NSDate.dateWithTimeIntervalSinceNow(10)
    notification.soundName = UILocalNotificationDefaultSoundName
    UIApplication.sharedApplication.scheduleLocalNotification(notification)

  end

  def buzz(notification)
    @alertViewController = AlertViewController.alloc.initWithNotification(notification)
    presentViewController(@alertViewController, animated: true, completion: nil)
    AudioServicesPlayAlertSound(KSystemSoundID_Vibrate)
  end
end
