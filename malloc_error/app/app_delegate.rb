class Ansi
  ESCAPE = "\033"
  
  def self.color(color_constant)
    "#{ESCAPE}[#{color_constant}m"
  end
  
  def self.reset_color
    color 0
  end
  
  def self.yellow_color
    color 33
  end
  
  def self.green_color
    color 32
  end
  
  def self.red_color
    color 31
  end
end

class Debug
  @@silent = false
  @@colorize = true
  
  # Use silence if you want to keep messages from being echoed
  # to the console.
  def self.silence
    @@silent = true
  end
  
  def self.colorize
    @@colorize
  end
  
  def self.colorize=(value)
    @@colorize = value == true
  end
  
  # Use resume when you want messages that were silenced to
  # resume displaying.
  def self.resume
    @@silent = false
  end
  
  def self.put_message(type, message, color = Ansi.reset_color)
    open_color = @@colorize ? color : ''
    close_color = @@colorize ? Ansi.reset_color : ''
    
    ### It appears that RubyMotion does not support caller backtrace yet.
    
    NSLog("#{open_color}#{type} #{caller[1]}: #{message}#{close_color}") unless @@silent
    # NSLog("#{open_color}#{type} #{message}#{close_color}") unless @@silent
  end
  
  def self.info(msg)
    put_message 'INFO', msg, Ansi.green_color
  end
  
  def self.warning(msg)
    put_message 'WARNING', msg, Ansi.yellow_color
  end
  
  def self.error(msg)
    put_message 'ERROR', msg, Ansi.red_color
  end
  
end

class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    Debug.info "this should tell me who called me"
    true
  end
end
