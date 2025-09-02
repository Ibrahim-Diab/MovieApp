
# 🎬 MovieApp
A modern iOS application for browsing and viewing movie details, built with Clean MVVM Architecture and Combine for reactive programming. The app supports offline behavior for favorites using UserDefaults.
---

## 🚀 Technologies Used
- Swift 5.10+: Modern, type-safe programming language
- iOS 15+: Minimum deployment target
- UIKit: UI building and navigation
- Combine: Reactive programming for state management and bindings
- UserDefaults: Lightweight persistence for favorite caching
- Alamofire: Networking layer for API requests
- Dependency Injection: Decoupled, testable components
---

## 🏗️ Architecture

The app follows **Clean MVVM** principles to ensure modularity, testability, and maintainability:

- **Domain Layer**:
  - **Entities**: Core business models (`MovieDetailsDataModel`) representing pure data.
  - **Use Cases**: Business logic encapsulation (e.g., `MovieListUseCase`) for reusable application logic.
- **Data Layer**:
  - **Repository**: Implements `HomeRepository` to coordinate data from remote sources.
  - **Data Sources**:
    - `HomeRepositoryProtocol`: Handles API requests.

- **Presentation Layer**:
  - **ViewModels**: `MoviesListViewModel`, `MovieDetailsViewModel` manage state, side effects, and data binding.
  - **ViewControllers**: `MovieListViewController`, `MovieDetailsViewController` use UIKit and subscribe to ViewModel state publishers.

---

## 🔄 UI State Management

Each ViewModel exposes a single `Publisher<ViewState>` as the source of truth for its screen's UI state. The state is represented as an `enum`:

```swift
enum ViewState {
    case content
    case showMessage(message)
    case error(message)
    case loading
}
```

- **ViewController Behavior**:
  - `.loading`: Displays an loader .
  - `.showMessage`: show  Message to user .
  - `.error`: Shows an error UI .

**Benefits**:
- Single source of truth per screen.
- Unidirectional Data Flow (UDF) for predictable state changes.
- Loosely coupled, testable ViewModels.

---

## 💾 Offline-Favorites

- Favorites are cached using UserDefaults:
- Marking a movie as favorite stores its ID locally
- Favorite state is restored automatically on next app launch

---


## Favorites Persistence
- Used UserDefaults to store favorite movies instead of Core Data.
✅ Pros: Lightweight, simple API, fast for small data.
❌ Cons: Not scalable for complex data, no advanced querying support.
🎯 Decision: Since favorites are a small dataset, UserDefaults was sufficient.


## Reactive Programming
- Chose Combine (native framework) instead of RxSwift.
✅ Pros: First-party Apple solution, no external dependency, integrates well with Swift.
❌ Cons: Requires iOS 13+, smaller community compared to RxSwift.
🎯 Decision: Combine fits the app’s requirements and keeps dependencies minimal.
