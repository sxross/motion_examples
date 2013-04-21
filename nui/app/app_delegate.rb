class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    NUISettings.initWithStylesheet("my_theme")
    NUIAppearance.init
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    tabbar = UITabBarController.alloc.init

    table_view_controller = ExampleTableViewController.alloc.init
    # example_view_controller = AnotherExampleController.alloc.init

    # tabbar.viewControllers = [table_view_controller, example_view_controller]

    # item1 = UITabBarItem.alloc.initWithTitle("table",image:nil,tag:1)
    # item2 = UITabBarItem.alloc.initWithTitle("label",image:nil,tag:2)

    # table_view_controller.tabBarItem = item1
    # example_view_controller.tabBarItem = item2

    @window.rootViewController = UINavigationController.alloc.initWithRootViewController(table_view_controller)

    @window.makeKeyAndVisible
    true
  end
end

class ExampleTableViewController < UITableViewController
  @@cell_identifier = nil
  
  # Sample data for our table. Don't blame me for the data.
  # I just grabbed it off the Web :)
  CELL_DATA = [
    ['John', 'Guitar'],
    ['Paul', 'Bass'],
    ['George', 'Guitar'],
    ['Ringo', 'Drums']
  ]

  def viewDidLoad
    self.title = 'Hello NUI'
  end

## Table view data source

  def numberOfSectionsInTableView(tableView)
    1
  end

  def tableView(tableView, numberOfRowsInSection:section)
    CELL_DATA.length
  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    cell = tableView.dequeueReusableCellWithIdentifier(cell_identifier)
    unless cell
      cell = UITableViewCell.alloc.initWithStyle UITableViewCellStyleSubtitle, reuseIdentifier:cell_identifier
    end
    cell.textLabel.text = CELL_DATA[indexPath.row].first
    cell.detailTextLabel.text = CELL_DATA[indexPath.row].last
    cell
  end
  
  def cell_identifier
    @@cell_identifier ||= 'example_cell'
  end

  ## Table delegate

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    @example ||= AnotherExampleController.alloc.init
    self.navigationController.pushViewController @example, animated:true
  end
end

class AnotherExampleController < UIViewController
  def viewDidLoad
    @label ||= UILabel.alloc.initWithFrame(CGRectZero)
    @label.text = 'Hello, NUI'
    @label.sizeToFit
    self.view.addSubview @label
  end
end
