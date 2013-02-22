iOS-LocalizationsChecker
========================

Did your localizations suck first time you changed languag in your iOS App? Is it a hell to know where you miss localized strings? This utility is for you!

##Motivation:
When you write an iOS app, you need some things for localized strings to show in languages other than default:
- Code calling NSLocalizedString (or other API) to read a different string using a key
- A file in correct directory in bundle
- A string matching the key in the file!

This breaks. A LOT. When sources, UI, strings change, in multiplatform projects. 
When a string is not found, system replaces with default language one, or with programmer-supplied default.

We want to ease the pain of finding where you forgot to add your strings.

##Objective:
Write a small component which can be added to any iOS Project, allowing:
1. Change UI component at runtime with color or different background showing that string is not localized.
2. Generate a log file (or just log to console) where a text was set and not localized, which view, which component, what string.
3. Ideas can be added to this, to ease on debugging that kind of problem...

##Initial implementation idea:
Thinking about method swizzling to catch when app talks with string loading API, also to catch when user modifies any text UI component property.