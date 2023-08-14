# MeetingRooms
An app that fetches fake meeting room data and allows to book any of the rooms that have available spots. Built as a code challenge assignment for WeTransfer.

# 3 hour requirement
This repo has 2 branches: `main` and `beyond-3-hour-limit`. Whatever you see in the `main` branch is what I've accomplished approximately within the first 3 hours of work. 

There were some important parts that I couldn't finish in time, such as caching and unit testing. Instead of describing how I would have approached them, I decided to actually implement them in a separate branch so that you could have a look at them if you wish.

To review the part of the project implemented within the 3 hour limit, feel free to clone the repo and just review the `main` branch. To review the complete project, feel free either to checkout the `beyond-3-hour-limit` branch or have a look at [the PR I opened](https://github.com/armanarutiunov/MeetingRooms/pull/1).

# Technologies used
- Xcode v14.3.1
- Minimum deployment target iOS 16.4 (since it wasn't required to support older versions in the spec)
- Swift 5.8
- SPM for modularization and remote dependencies
- SwiftUI
- async / await
- Very limited usage of Combine (in the `beyond-3-hour-limit` branch)
- URLSession (since required networking was very simple, I decided not to go for Alamofire)
- Nuke for image caching

# Architecture 
The architecture I decided to go with is MVVM. Was it a bigger project, I would have gone for an MVVM-C. However, in this specific case it didn't make sense because C (coordinator) would never be used, since there is no navigation involved in the app.

# Project structure
Instead of building everything in a single Xcode target, I decided to take a modular approach with the use of Swift Package Manager.

The only Swift file the project contains in the original target is `MeetingRoomsManager.swift`. Everything else is implemented in a local SPM package called `Modules`.

`Modules` structure is specified in its `Package.swift`. A more detailed description of each component of the package:

## Modules (aka Targets)
- `Cloud` - a module that contains all the networking related logic (and additionally a networking monitoring logic that was built in `beyond-3-hour-limit` branch)
- `DesignSystem` - a module that contains all the reusable UI components and UI-related extensions
- `RoomManager` - a module that contains all the logic for room fetching and booking use cases
- `Rooms` - a module that contains all the screen logic (views and view models)
- `Utilities` - a module that contains all the non-UI extensions and utilities needed for any of the modules

### Modules built in `beyond-3-hour-limi` branch
- `Datastore` - a module that contains logic that saves/loads/deletes data on disk to meet the caching requiremenet for use case when there is no internet connection
- `RoomManagerTests` - a module that contains all the unit tests for logic in the `RoomManager` module (decoding/encoding of the Room models & RoomManager tests)
- `RoomsTests` - a module that contains unit tests for view models of the `Rooms` module
- `Datastore` - a module that contains unit tests for the Datastore logic (saving/loading/deleting of objects on and from disk)

## Libraries (aka Products)
In the `main` branch you can see that there are only 2 libraries that are necessary to start the app: 
- `Rooms` - needed to be specified as a library to make it importable by `MeetingRoomsApp` to present the `MeetingRoomsView` screen
- `DesignSystem` - needed to be specified as a library to make the Previews work when developing components

### Libraries built in `beyond-3-hour-limi` branch
- `Cloud` - needed to be specified as a library so that `MeetingRoomsApp` could trigger the network monitoring start

## Dependencies
- `Nuke` - for image caching (I decided to save time on image caching instead of building my own solution)

# What I could have improved even further the `beyond-3-hour-limit` branch
- `Datastore` could have an additional way to save/load/delete objects without a key based on their `id`s (would have to be `Identifiable`)
- `Datastore` could have more logic to not only save on disk but also on RAM for a more efficient usage of cache data throughout app's life cycle (an overkill for this project though)
- Could have utilised the logic in `NetworkingMonitor` in a richer way and not even make the first request if I know that there is no connection, showing a placeholder saying there is no connection
- Could have built a more sophisticated CloudManager that would allow to specify request headers, methods, parse errors into different types etc. (an overkill for this project)
- `RoundedButton` could have a `State` enum for `default`, `loading`, `disabled` states representing different UI and animations
- Could have a built a nicer UI for the header of the screen where title transitions into a navigation bar on scroll. Didn't go for it to save time, and also I'd have to do it in a custom way to keep using the Helvetica font. If I was using the system font I might have just used the `NavigationView` + `.navigationBarTitle()` modifier with a default `displayMode` that has that behaviour built in.
- Could have tested more logic such as CloudManager, NetworkingMonitor, RoundedButtonViewModel etc.