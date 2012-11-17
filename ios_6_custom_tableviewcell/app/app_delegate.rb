class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    tabbar = UITabBarController.alloc.init
    table_view_controller = ExampleTableViewController.alloc.init
    @window.rootViewController = UINavigationController.alloc.initWithRootViewController(table_view_controller)
    @window.makeKeyAndVisible
    true
  end
end

