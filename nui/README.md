README
======

Simple example of integrating NUI Cocoapod with a RubyMotion project. Here were the steps:

## Modify Rakefile

Add NUI Cocoapod. Note that it is case-sensitive, so it's all uppercase.

```
  app.pods do
    pod 'NUI'
  end
```

* Add CoreImage and QuartzCore frameworks to Rakefile

```
  app.frameworks += ['CoreImage', 'QuartzCore']
```

Note that I also added bundler to the Rakefile so I could use a Gemfile.

## Gemfile

```
source "https://rubygems.org"

gem "rake"
gem "motion-cocoapods", "1.3.0.rc1"
gem 'bubble-wrap'
```

This brings in a couple of niceties like motion-cocoapods and bubble-wrap.

## Create Silly Test App

You can see that I stuck all this in app_delegate.rb. The first view is a `UITableView`. If you click on a cell it takes you to a `UIView` that containes one label.

## Notes

* resources/my_theme.nss is just a copy of the GooglePlex theme in the NUI sample set. The only change I made was to set `text-auto-fit` to `true` for `Label`. It seemed the labels were winding up truncated if I didn't both do this and do a `sizeToFit` in my code.
* This is the first time I've touched NUI. Please be gentle :)
