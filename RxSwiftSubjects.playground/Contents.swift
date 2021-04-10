import UIKit
import RxSwift
import RxCocoa

let disposeBag = DisposeBag()

let subject = PublishSubject<String>()

subject.onNext("Issue 1")

// Subscription to PublishSubject
subject.subscribe { event in
    print(event)
}

subject.onNext("Issue 2")
subject.onNext("Issue 3")

// Dispose
subject.disposed(by: disposeBag)

subject.onNext("Issue 4")
