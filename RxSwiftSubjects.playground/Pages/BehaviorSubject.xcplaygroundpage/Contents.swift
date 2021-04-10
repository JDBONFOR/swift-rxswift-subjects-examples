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

subject.onNext("Issue 1")
