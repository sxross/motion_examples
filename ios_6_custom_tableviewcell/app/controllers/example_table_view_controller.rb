class EntryTableViewCell < UITableViewCell
  attr_accessor :label_view, :input_value_frame

  def initWithStyle(style, reuseIdentifier:cell_identifier)
    super
    @label_view = UILabel.alloc.initWithFrame [[20, 10], [80, 21]]
    @label_view.font = UIFont.boldSystemFontOfSize(17)
    @label_view.backgroundColor = UIColor.clearColor

    label_view_width = Device.screen.width - 100
    label_view_width -= Device.iphone? ? 22 : 88

    @input_value_frame = UITextField.alloc.initWithFrame(
      [[100, 10], [label_view_width, 31]]
    )
    @input_value_frame.borderStyle = UITextBorderStyleNone
    @input_value_frame.adjustsFontSizeToFitWidth = true

    self.contentView.addSubview @label_view
    self.contentView.addSubview @input_value_frame

    self
  end
end

class ExampleTableViewController < UITableViewController
  @@cell_identifier = nil
  
  # Sample data for our table. Don't blame me for the data.
  # I just grabbed it off the Web :)
  CELL_DATA = [
    ['Name', 'Kim Kardashian'],
    ['Notable', 'Kim Kardashian is the daughter of O.J. Simpsons defense attorney Robert Kardashian.']
  ]
  
  def viewDidLoad
    super

    # iOS 6.0+ way to register custom class for UITableViewCell
    self.view.registerClass(EntryTableViewCell, forCellReuseIdentifier:cell_identifier)
  end

## Table view data source

  def numberOfSectionsInTableView(tableView)
    1
  end

  def tableView(tableView, numberOfRowsInSection:section)
    CELL_DATA.length
  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    cellIdentifier = self.class.name
    cell = tableView.dequeueReusableCellWithIdentifier(cell_identifier)
    cell.label_view.text = CELL_DATA[indexPath.row].first
    cell.input_value_frame.text = CELL_DATA[indexPath.row].last
    cell
  end
  
  def cell_identifier
    @@cell_identifier ||= 'example_cell'
  end
end
