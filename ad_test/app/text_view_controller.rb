class Screen
  def self.width
    UIScreen.mainScreen.bounds.size.width
  end
  
  def self.height
    UIScreen.mainScreen.bounds.size.height
  end
end

class TextViewController < UIViewController
  attr_accessor :text
  
  
  def dealloc
    @timer.invalidate
    # When running on iOS 5.0 and later, ADBannerView's delegate property acts as a weak reference, making this unnecessary.
    # However since this sample supports iOS 4.2 and later, we do this here to ensure correct behavior on all systems.
    @bannerView.delegate = nil
    @textView = nil
  end

  def layoutAnimated(animated)
    if UIInterfaceOrientationIsPortrait(self.interfaceOrientation)
      @bannerView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait
    else
      @bannerView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierLandscape
    end

    contentFrame = self.view.bounds
    bannerFrame = @bannerView.frame
    
    if @bannerView.bannerLoaded?
      contentFrame.size.height -= @bannerView.frame.size.height
      bannerFrame.origin.y = contentFrame.size.height
    else
      bannerFrame.origin.y = contentFrame.size.height
    end

    UIView.animateWithDuration(animated ? 0.5 : 0.0, animations:lambda {
        @contentView.frame = contentFrame
        @contentView.layoutIfNeeded
        @bannerView.frame = bannerFrame
    })
  end

  def setText(text)
    @textView.text = @text.dup
  end

  def timerTick(timer)
      # Timers are not guaranteed to tick at the nominal rate specified, so this isn't technically accurate.
      # However, this is just an example to demonstrate how to stop some ongoing activity, so we can live with that inaccuracy.
      @ticks += 0.1
      seconds = @ticks % 60.0
      minutes = ((@ticks / 60.0) % 60.0).to_i
      hours = (@ticks / 3600.0).to_i
      @timerLabel.text = '%02d:%02d:%04.1f' % [hours, minutes, seconds]
  end

  def viewDidLoad
      super
      
      self.view.backgroundColor = UIColor.colorWithRed(142, green:167, blue:219, alpha:1.0)
      
      # Was in init but that's not called here
      NSLog "and initializing"
      @bannerView = ADBannerView.alloc.init
      @bannerView.delegate = self
      @ticks = 0.0
      @timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target:self, selector:'timerTick:', userInfo:nil, repeats:true)
      
      # Not using IB, so create manually
      @contentView = UIView.alloc.initWithFrame [[0, 0], [Screen.width, Screen.height]]
      
      @timerLabel = UILabel.alloc.initWithFrame [[0, 0], [Screen.width, 44]]
      @timerLabel.textAlignment = NSTextAlignmentCenter
      @contentView.addSubview @timerLabel
      
      bounds = self.view.bounds
      bounds.origin.y += 44
      bounds.size.height -= 44
      @textView = UITextView.alloc.initWithFrame(bounds)
      @contentView.addSubview @textView
      
      self.view.addSubview @contentView
      
      self.view.addSubview @bannerView
      @textView.text = @text
  end
  
  def viewDidUnload
      super
      self.contentView = nil
      @textView = nil
      @timerLabel = nil
  end

  def viewDidAppear(animated)
      layoutAnimated(false)
  end

  def shouldAutorotateToInterfaceOrientation(interfaceOrientation)
    true
  end

  def willAnimateRotationToInterfaceOrientation(toInterfaceOrientation, duration:duration)
      if UIInterfaceOrientationIsPortrait(toInterfaceOrientation)
          @bannerView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait
      else
          @bannerView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierLandscape
      end
      layoutAnimated(duration > 0.0)
  end

  def bannerViewDidLoadAd(banner)
      NSLog("DidLoadAd")
      layoutAnimated true
  end

  def bannerView(banner, didFailToReceiveAdWithError:error)
      NSLog("DidFailToReceiveAdWithError")
      layoutAnimated true
  end

  def bannerViewActionShouldBegin(banner, willLeaveApplication:willLeave)
      @timer.invalidate
      @timer = nil;
      true
  end

  def bannerViewActionDidFinish(banner)
      @timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target:self, selector:'timerTick:', userInfo:nil, repeats:true)
  end
end