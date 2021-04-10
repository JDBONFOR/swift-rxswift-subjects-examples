# RxSwift
Rx is a generic abstraction of computation expressed through Observable<Element> interface, which lets you broadcast and subscribe to values and other events from an Observable stream.

RxSwift is the Swift-specific implementation of the Reactive Extensions standard.

## RxSwift Subjects

[![5.2 Swift](https://img.shields.io/badge/Swift-5.2-green.svg)](https://github.com/Naereen/badges)
[![14 iOS](https://img.shields.io/badge/iOS-13x+-blue.svg)](https://github.com/Naereen/badges)

Inside RxSwiftSubjects.playground file, you found the different RxSwift subjects with example code.

## Details
What is a Subject?
The subject receive an event and it send to subscribers that was subscriber to him.

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

Response on console

```swift
next(Issue 2)
next(Issue 3)
```

All that happens before that someone subscribe to subject, nothing show it.
While a subscriber are subscribe to subject, show all events that happends.
The dispose methods say to subject that the subscriber close subscription. This is why no longer see on the console the print from the last onNext("Issue 4") 

---

#### BehaviorSubject
In difference with Publish, BehaviorSubject have an inicial value and it can change before one or more subscriber exist. So, the last value it is the first on the subscriber.

```swift
import UIKit
import RxSwift
import RxCocoa

let disposeBag = DisposeBag()

let subject = BehaviorSubject(value: "Initial value")

// Changes before there is a one or more subscribers
subject.onNext("Update initial value")

subject.subscribe { event in
    print(event)
}
.disposed(by: disposeBag)

subject.onNext("Issue 1")
```
Response in console

```swift
next(Update initial value)
next(Issue 1)
```

---

#### ReplaySubject
ReplaySubject have a size buffer defined by you and will temporarily cache or buffer it for the new subscribers.
The first subscriber had in this example 3 events before it was subcribed so the buffer shows to subscriber the last elements inside Subject "Issue 2" and "Issue 3" because Us had defined 2 elements on "bufferSize" property.

```swift
import UIKit
import RxSwift
import RxCocoa

let disposeBag = DisposeBag()

let subject = ReplaySubject<String>.create(bufferSize: 2)

subject.onNext("Issue 1")
subject.onNext("Issue 2")
subject.onNext("Issue 3")

subject.subscribe {
    print($0)
}
.disposed(by: disposeBag)

subject.onNext("Issue 4")
subject.onNext("Issue 5")
subject.onNext("Issue 6")

```

Response in console

```swift
next(Issue 2)
next(Issue 3)
next(Issue 4)
next(Issue 5)
next(Issue 6)
```

What happens if we add a new subscriber?

```swift
print("<---- New subscriber ---->")
subject.subscribe{
    print($0)
}
.disposed(by: disposeBag)
```

After the first subscriber was subcribed to the Relay three new events have ocurred.
In the example, we see that a new subscriber has subscribed to Subject. What do you think the initial values will be? Of course, "Issue 5" and "Issue 6" because the new subscriber starts his subscription having passed 6 events, but the buffer indicates to start from the last 2.

```swift
<---- New subscriber ---->
next(Issue 5)
next(Issue 6)
```

---

#### BehaviorRelay
BehaviorRelay is a part of RxCocoa, so you need install and import it.
In the example, we see how to work with Strings or Arrays in BehaviorRelay.

```swift
import UIKit
import RxSwift
import RxCocoa

let disposeBag = DisposeBag()

// Inicial value
let relay = BehaviorRelay(value: "Initial Value")

relay.asObservable()
    .subscribe {
        print($0)
    }
    .disposed(by: disposeBag)
    
// Assign new value
relay.accept("Hello world!!")

```
In this case, the response in console is

```swift
next(Initial Value)
next(Hello world!!)
```

To manage values on BehaviorRelay we can't change relay.value implicity. The correct method is .accept(value: _)

But, what happens with array and when I need appends new elements? Ok, let me see you this example

```swift
import UIKit
import RxSwift
import RxCocoa

let disposeBag = DisposeBag()

// Working with Array on BehaviorRelay
let relayArray = BehaviorRelay(value: [String]())

// Assign new value
relayArray.accept(relayArray.value + ["Item 1"])
relayArray.accept(relayArray.value + ["Item 2"])
relayArray.accept(relayArray.value + ["Item 3"])

// Similar Idea to append elements to array is, duplicate value on to a variable

var values = relayArray.value
values.append("Item 4")
values.append("Item 5")
values.append("Item 6")

relayArray.accept(values)

relayArray.asObservable()
    .subscribe {
        print($0)
    }
    .disposed(by: disposeBag)
```

We can see in the example two ways to manipulate array inside BehaviorRelay.
The first one is with .accept method and concatenate the existing value in Relay and new value.
The second one is duplicating the relay.value and manage it outside how to a new simple array and then accept manipulated array.
