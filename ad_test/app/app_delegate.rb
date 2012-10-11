class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @tvc = TextViewController.new
    @tvc.title = "Original"
    @tvc.text = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."

    @window = UIWindow.alloc.initWithFrame UIScreen.mainScreen.bounds
    @window.rootViewController = @tvc
    
    @window.makeKeyAndVisible
    
    true
  end
end

# These are C macros in iOS SDK. Not workable for Ruby.
def UIInterfaceOrientationIsLandscape(orientation)
  orientation == UIInterfaceOrientationLandscapeLeft ||
     orientation == UIInterfaceOrientationLandscapeRight
end

def UIInterfaceOrientationIsPortrait(orientation)
  orientation == UIInterfaceOrientationPortrait ||
     orientation == UIInterfaceOrientationPortraitUpsideDown
end
