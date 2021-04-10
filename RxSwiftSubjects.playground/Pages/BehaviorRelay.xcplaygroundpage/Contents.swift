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
