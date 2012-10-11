ad_test
=======

This is a port to RubyMotion of Apple's [BasicBanner](http://developer.apple.com/library/ios/#samplecode/iAdSuite/Introduction/Intro.html) demonstration of using iAd.

Things to Note
==============

1. This is my first attempt to do anything with iAd.
2. It's not as stupid-simple as it looked (duh).
3. When you do this with views pushed onto a Navigation Controller,
   this example will help you, but you should also look at the other
   examples in the Xcode project referenced above.
   
When You Run This
=================

Apple almost always serves up errors as the first ads. They want to be sure your app handles network or configuration errors properly. It's not unusual to
see a number of these errors in succession. That's why implementing and testing iAds takes so long. A complete cycle involves watching the error, waiting
out the first successful banner load, and then waiting out the next error to see the ad disappear. Maybe there's a better way, but I feel like I have the
Apple test banner ad burned into my retina right now.

Anyhow, don't be disappointed if you see a number of errors. They are generated deliberately by Apple.