# Cars-Test-App
Test app

Avoid hard-coded stuff
Use some architecture to split code into separate parts (e.g. Clean Architecture)

Task is divided on 3 levels, do your best!


LEVEL 1 
Show some error alert if user clicks on “Sign In” button and fields are empty. 

After opening the app show “Main screen” if user has already logged in.

Display stream of two videos.
Videos must be autoplayed.

Use public test video urls from here:
https://gist.github.com/jsturgis/3b19447b304616f18657
Each video widget must have different url.


LEVEL 2 
Store username from login screen and display it here. (username must be async result).

Use this API to fetch data for list:
http://filehost.feelsoftware.com/jsonplaceholder/cars-api.php

Call that API each 10 seconds and refresh UI.

Display dialog with detailed info. 

LEVEL 3 
Change background card color based on status from API:
available - green
hidden - blue
disabled - yellow
Show dropdown to filter which status need to be displayed (hide other cards). Also add possibility to show all statuses.

Display time when API was called (some seconds ago).

Video widgets have the same rules as from previous screen.


What is done:
-All three levels
-App for iPhone and iPad
  Application for iPad - according to the graphic task
  The application for iPhone is made in its own way
-Custom filter in iPad-version, using Cocoapods 'DropDown'

What we used:
-UserDefaults for save login and password
-HTTP Request
-JSON Parsing
-AVPlayer to show video
-TableView to show car list
-Cocoapods

What needs to be done:
-Refactor



