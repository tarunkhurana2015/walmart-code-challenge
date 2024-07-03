# walmart-iOS-code-challenge

## Problem Statement

1. Fetch a list of countries in JSON format from this URL: https://gist.githubusercontent.com/peymano-wmt/32dcb892b06648910ddd40406e37fdab/raw/db25946fd77c5873b0303b858e861ce724e0dcd0/countries.json 
2. Display all the countries in a UITableView ordered by the position they appear in the JSON. In each table cell, show the country's "name", "region", "code" and "capital" in this format: 
 <img width="299" alt="image" src="https://github.com/tarunkhurana2015/walmart-ios-code-challenge/assets/9640541/dcb59441-7087-4c4e-b98e-aea4e5f48654">
     
3. The user should be able to scroll thru the entire list of countries. 

4. Use a `UISearchController` to enable filtering by `"name"` or `"capital"` as the user types each character of their search. 

5. The implementation should be robust (i.e.,   `handle errors and edge cases`), support `Dynamic Type`  ,support `iPhone and iPad`, and support `device rotation`. 

6. Please use `UIKit`, not SwiftUI, for this exercise. 


## Solution 

The solution was build for both the `UIKit` and `SwiftUI`
```swift
// UIKit
window.rootViewController = UINavigationController(rootViewController: CountryViewController(viewModel: CountryViewModel()))
// SwiftUI
//let contentView = UIHostingController(rootView: CountryView(viewModel: CountryViewModel()))
//window.rootViewController = contentView
```

## Package `Country` - `Clean Architecture` with `MVVM` and `UIKit`

Clean architecture pattern emphasizes the sepration of concertns between different layers to create an application structure that is isolated, testable and easy to maintain.

###  iOS Tech stack

| Development Aspect | Tech |
| ------------- |:-------------:|
| Modularity      | `Swift Package Manager`       |
| Multi Threading      |`swift async-await` | `Task` & `Combine`     |
| Design Pattern      | `MVVM`   |
| Depedency Injection      | `Dependencies` https://github.com/pointfreeco/swift-dependencies - `@Dependency`    |
| Networking      | `URLSession`   |
| Json Mapping | `Decodable` |
| View | `UIKit` - `UITableView` | `UISearchController` |
| Tests | `XCTest` |

### Overview

In this propject i have used the `Modular`, `Clean Architecture`, with `MVVM` design patterns. The app supports `iPhone - Portrait and Landscape`, `iPad - All orientation` | `Dynamic Type` | `Light and Dark mode`

### Reference

I have done a detailed explanation of this architecture in my `personal` github link [Clean Architecture](https://github.com/tarunkhurana2015/cleanarchitecture-ios)
