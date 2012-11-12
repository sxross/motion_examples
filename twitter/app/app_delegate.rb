class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    window.makeKeyAndVisible
    true
  end
  
  def window
    @window ||= begin
      w = UIWindow.alloc.initWithFrame UIScreen.mainScreen.bounds
      if false # Device.ipad?
        w.rootViewController = split_view_controller 
      else
        @controller = TweetViewController.new
        w.rootViewController = @controller
      end
      w
    end
  end
end

class TweetViewController < UITableViewController
  @@cell_identifier = nil

  def viewWillAppear(animated)
    super
    self.view.backgroundColor = UIColor.whiteColor
    @feed = []
    @deserialize = JSONDecoder.decoder
    timer_fired(self)
    @timer = NSTimer.scheduledTimerWithTimeInterval(2, target:self, selector:'timer_fired:', userInfo:nil, repeats:true)
  end
  
  def viewWillDisappear(animated)
    @timer.valid = false
    @timer = nil
  end
  
  def timer_fired(sender)
    @twitter_accounts = %w(rubymotion colinta)
    query = @twitter_accounts.map{ |account| "from:#{account}" }.join(" OR ")
    url_string = "http://search.twitter.com/search.json?q=#{query}"
    
    error_ptr = Pointer.new(:object)
    BW::HTTP.get(url_string) do |response|
      # parsed = response.body.to_str.objectFromJSONStringWithParseOptions JKParseOptionValidFlags, error: error_ptr    # <= uncomment to use JSONKit CocoaPod
      parsed = BW::JSON.parse response.body.to_str     # <= Comment to stop using bubblewrap
      if parsed.nil?
        error = error_ptr[0]
        puts error.userInfo[NSLocalizedDescriptionKey]
        @timer.setValid false
      else
        parsed.each do |item|
          next if item[0] != 'results'
          @feed = []
          item[1].each do |tweet|
            @feed << {:from => tweet['from_user'], :text => tweet['text'], :image => tweet['profile_image_url']}
            self.view.reloadData
          end
        end
      end
    end
  end
  
  def tableView(tableView, numberOfSectionsInTableView:section)
    1
  end
  
  def tableView(tableView, numberOfRowsInSection:section)
    @feed.length
  end
  
  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    cell = tableView.dequeueReusableCellWithIdentifier(cell_identifier)
    
    if not cell
      cell = UITableViewCell.alloc.initWithStyle UITableViewCellStyleSubtitle, reuseIdentifier:cell_identifier
      cell.selectionStyle = UITableViewCellSelectionStyleNone
      
      tweet = @feed[indexPath.row]
      cell.textLabel.text = tweet[:from]
      cell.detailTextLabel.text = tweet[:text]
      url = NSURL.URLWithString tweet[:image]
      data = NSData.dataWithContentsOfURL url
      image = UIImage.imageWithData data
      cell.imageView.image = image
    end

    cell
  end
  
  def cell_identifier
    @@cell_identifier ||= 'TwitterTableViewCell'
  end
end