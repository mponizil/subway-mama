class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.makeKeyAndVisible

    @viewController = ViewController.alloc.init
    @window.rootViewController = @viewController

    true
  end

  def application(application, didReceiveLocalNotification:notification)
    puts 'got a notification', notification
  end
end
