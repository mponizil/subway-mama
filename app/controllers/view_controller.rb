class ViewController < UIViewController
  def viewDidLoad
    super

    alarm = EKAlarm.alarmWithRelativeOffset(5)
    puts alarm

    url = "http://datamine.mta.info/mta_esi.php?key=%s&feed_id=2" % MTA_API_KEY

    data = NSData.dataWithContentsOfURL(NSURL.URLWithString(url))
    feed = FeedMessage.parseFromData(data)
    puts feed.entity.map { |e| e.vehicle.trip }
  end
end
