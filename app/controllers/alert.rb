class AlertViewController < UIViewController

  attr_accessor :notification

  def initWithNotification(notification)
    initWithNibName(nil, bundle: nil)
    self.notification = notification
    self
  end

  def viewDidLoad
    super

    view.backgroundColor = UIColor.redColor

    @alert = UILabel.alloc.initWithFrame(CGRectMake(0, 114, view.frame.size.width, 100))
    @alert.text = notification.alertBody
    @alert.numberOfLines = 0
    @alert.textAlignment = NSTextAlignmentCenter
    view.addSubview(@alert)

    @confirm = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    @confirm.setTitle("OK IM RUNNIN!", forState:UIControlStateNormal)
    @confirm.frame = CGRectMake(0, 0, view.frame.size.width, 30)
    @confirm.center = CGPointMake(view.frame.size.width / 2, @alert.frame.origin.y + @alert.frame.size.height + 20)
    view.addSubview(@confirm)

    @confirm.addTarget(self, action: 'confirm', forControlEvents: UIControlEventTouchUpInside)
  end

  def confirm
    dismissViewControllerAnimated(true, completion: nil)
  end

end
