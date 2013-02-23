iOS-LocalizationsChecker
========================

Did your localizations suck first time you changed language in your iOS App? Is it a hell to know where you miss localized strings? This utility is for you!

##Motivation:
When you write an iOS app, you need some things for localized strings to show in languages other than default:
- Code calling NSLocalizedString (or other API) to read a different string using a key
- A file in correct directory in bundle
- A string matching the key in the file!

This breaks. **A LOT**. When sources, UI, strings, wireframes, and requirements change, in multiplatform projects. 
When a string is not found, system replaces with default language one, or with programmer-supplied default.

We want to ease the pain of finding where you forgot to add your strings.

##Usage
Just add the 'checker' files to your project compile phase. All else will work automatically! 

The library will monitor calls to load strings from NSBundle, and all text setters in your UI. If there is a mismatch between them, it means string is hardcoded, or there was no translation! 

##Result
This is how your UI will look with the pluging working, for **ALL** the UI:

![](https://github.com/DarthMike/iOS-LocalizationsChecker/raw/master/sample.png")

Also wher strings were not translated, a log is thrown into console.

##Development and first implementation idea:
This component was developed initially as a 4 hour fast hacking for [Name Collision Hackaton](www.namecollision.pl).

Write a small component which can be added to any iOS App, allowing:

- Change UI component at runtime with color or different background showing that string is not localized.
- Generate a log file (or just log to console) where a text was set and not localized, which view, which component, what string.
- Ideas can be added to this, to ease on debugging that kind of problem...

###How it's solved:
- Method swizzling to catch when app talks with string loading API
- Catch when user modifies any text UI component property
- All using Objective-C dynamism (categories, method swizzling, object introspection) to achieve the goal

##Further work
- Could customize a set of strings (for example km/h), which are not translated
- Could check other things, like text doesn't fit the label frame.
- Could generate a full report telling you which class/code files loaded strings without localization.