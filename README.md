# Installation
The project has one dependency, namely Lottie for animating loading views. Theis dependency do not need you to run terminal commands like Cocoapods, as I used Swift Package manager to install it. The project should run as soon as it is downloaded.

The naming convention used aligns with the Viper naming convention, as well as the folder structure.


# Whats missing

The view shows forecasts for every 3 hours, even though the data is supposed to bring back forecasts for every day. The API I used allows for retrieving the weekly forecast, but it returns a list of 3 hour forecasts so in a day you will get 8 forecasts. https://openweathermap.org/forecast5.

Unfortunately to get daily forecasts from this API, you need to pay by adding your credit card details and I was uncomfortable with that. These are the APIs that could have achieved a more accurate daily forecast:
https://openweathermap.org/api/one-call-3#current
https://openweathermap.org/forecast16

I want to add that I also could have achieved the daily forecast by filtering through the items and getting only items if they are in the following day, but I didn't have enough time to follow that approach.

# Architecture
I used the VIPER architecture in the project. I created views, table views as well as custom views to drive the layout. The presenter and interactor are pretty straightforward in what they do. The router is responsible for creating, as well as navigating to/from view controllers.


# Testing
I tested the core functionality in the application, in the presenters, and the interactors.


# Networking
I used Async/Await for requesting forecast data, as per the requirements. On the downloading of image data, I used the traditional completion handler to demonstrate ability to use both methods.


# Design
The design of the project is inspired by a Weather app I usually use.


# Security
As a result of the disposable nature of this project, I have left the apiKey openly exposed without encrypting it, in the Constants file, Github even flagged it as a vulnerability in the project, I didn't take steps to secure/encrypt the key, but I understand the importance of doing so, one way I would have done that, is by keeping the key in the Keychain.


# My thinking
There are some items I intentionally left out, because it wasn't priority or its negligible functionality.

1. **Models:** My models do not transform every variable like for like, from response to model objects. I do this because I want the models to only consume what they use in the views, and nothing more. In a larger scale project the approach might be similar, or I would convert all the variables, depending on the needs.
2. **Extensions:** These classes are used to assist in simplifying the implementation, as well as avoid code reuse by writing once, and using at various places.
3. **Views:** I used the attributedStringForTitle: method to circumvent using two labels instead of one, for the heading and the content.
4. **Presenter:** The presenter uses a transform class, which does the heavy lifting of the transformation of data from response to view model objects
5. I implemented the background refreshing of data using the BackgroundTasks api.
