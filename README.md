# RxSwift
Rx is a generic abstraction of computation expressed through Observable<Element> interface, which lets you broadcast and subscribe to values and other events from an Observable stream.

RxSwift is the Swift-specific implementation of the Reactive Extensions standard.

## RxSwift Subjects

[![5.2 Swift](https://img.shields.io/badge/Swift-5.2-green.svg)](https://github.com/Naereen/badges)
[![14 iOS](https://img.shields.io/badge/iOS-13x+-blue.svg)](https://github.com/Naereen/badges)

Inside RxSwiftSubjects.playground file, you found the diferents RxSwift subjects with example code.

## Details
What is a Subject?
The subject receive an event and it send to subcribers that was subcriber to him.

### Types of Subject
- PublishSubject
- BehavierSubject
- ReplaySubject
- Variable (Deprecated)
- BehaviorRelay

#### PublicSubject

```swift

import RxSwift
import RxCocoa

let disposeBag = DisposeBag()

let subject = PublishSubject<String>()

// Event that happens before there is a subscriber
subject.onNext("Issue 1")

// Someone subscribe to PublishSubject
subject.subscribe { event in
    print(event)
}

// New events
subject.onNext("Issue 2")
subject.onNext("Issue 3")

// Dispose
subject.disposed(by: disposeBag)

subject.onNext("Issue 4")

```

Ressponse on console

```swift
next(Issue 2)
next(Issue 3)
```

All that happens before that someone subscribe to subject, nothing show it.
While a subscriber are subscribe to subject, show all events that happends.
The dispose methods say to subject that the subscriber close subscription. This is why no longer see on the console the print from the last onNext("Issue 4") 
