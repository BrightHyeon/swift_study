<27강. 익스텐션 extension>

/* struct, class, enum, protocol 타입에 새로운 기능을 추가할 수 있는 기능.
기능을 추가하려는 타입에 구현된 소스 코드를
알지 못하거나 볼 수 없다 해도, 타입만 알고 있다면 그 타입의 기능을 확장할 수도 있음.

익스텐션으로 추가할 수 있는 기능
: 연산 타입 프로퍼티, 연산 인스턴스 프로퍼티
: 타입 메서드, 인스턴스 메서드
: 이니셜라이저
: 서브스크립트?
: 중첩 타입
: 특정 프로토콜을 준수할 수 있도록 기능 추가

: 기존에 존재하는 기능을 재정의할 수는 없음!! */
//MARK: - 정의 문법
extension 확장할 타입 이름 {
    타입에 추가될 새로운 기능 구현
}

//익스텐션은 기존에 존재하는 타입이 추가적으로 다른 프로토콜을 채택할 수 있도록 확장도 가능.

extension 확장할 타입 이름: 프로토콜1, 프로토콜2, 프로토콜3... {
    프로토콜 요구사항 구현
}

//MARK: -익스텐션 구현

//MARK: 연산 프로퍼티 추가
extension Int { // Int 타입에 기능 추가한것.
    var isEven: Bool { //get 생략된듯??
        return self % 2 == 0
    }
    var isOdd: Bool { // bool타입 선언했으니 참, 거짓으로만 값 나옴. 
        return self % 2 == 1 // return값이 되면 참, 안되면 거짓.
    }
} // Int값을 받아 참, 거짓으로 출력하는 연산 프로퍼티 생성.
print(3.isEven)

var number: Int = 3
print(number.isOdd)

number = 2
print(number.isOdd)

//MARK: 메서드 추가
extension Int {
    func multiply(by n: Int) -> Int {
        return self * n //self는 Int타입의 인스턴스를 말함. 
    }
}
print(3.multiply(by:2))
number = 3
print(number.multiply(by: 3))
// Int타입 인스턴스를 받아 연산 후 Int타입 값을 출력하는 기능 추가.

//MARK: 이니셜라이저 추가

extension String {
    init(intTypeNumber: Int) {
        self = "\(intTypeNumber)"
    }
    init(doubleTypeNumber: Double) {
        self = "\(doubleTypeNumber)"
    }
}

let stringFromInt: String = String(intTypeNumber: 100)
print(stringFromInt + "hello")
// Int나 Double 타입을 받아서 String타입으로 초기화하는 이니셜라이저 생성.

// 프로토콜 중심 프로그래밍, 프로토콜 오리엔트 프로그래밍 나중에 공부해보라하심. 

<28강. 오류처리; error handling>

//MARK: - 오류표현
//Error 프로토콜을 사용해서 (주로) 열거형을 통해서 오류를 표현합니다. 

/*
enum 오류종류이름: Error {
    case 종류1
    case 종류2
    case 종류3
    ...
}
*/

//자판기 동작 오류의 종류를 표현한 VendingMachineError 열거형
enum VendingMachineError: Error {
    case invalidInput  //입력값이 잘못되었다.~
    case insufficientFunds(moneyNeeded: Int) // 금액이 모자라다!(얼마가 모자라냐~)
    case outOfStock //지금 물건이 다떨어졌습니다.
}
//MARK: 함수에서 발생한 오류 던지기

/* 자판기 동작 도중 발생한 오류 던지기
오류 발생의 여지가 있는 메서드는 throws를 사용하여
오류를 내포하는 함수임을 표시합니다. */
class VendingMachine {
    let itemPrice: Int = 100
    var itemCount: Int = 5
    var deposited: Int = 0

    //돈 받기 메서드
    func receiveMoney(_ money: Int) throws { // 오류를 내포.
        guard money > 0 else {
            throw VendingMachineError.invalidInput // 오류 던지기
        }
        self.deposited += money
        print("\(money)원 받음")
    }
    //물건 팔기 메서드
    func vend(numberOfItems numberOfItemsToVend: Int) throws -> String {
        //수량 이상하게 입력했을 때.
        guard numberOfItemsToVend > 0 else {
            throw VendingMachineError.invalidInput
        }
        guard numberOfItemsToVend * itemPrice <= deposited else {
            let moneyNeeded: Int
            moneyNeeded = numberOfItemsToVend * itemPrice - deposited
            throw VendingMachineError.insufficientFunds(moneyNeeded: moneyNeeded) }
        guard itemCount >= numberOfItemsToVend else {
            throw VendingMachineError.outOfStock
        }
        let totalPrice = numberOfItemsToVend * itemPrice
        self.deposited -= totalPrice
        self.itemCount -= numberOfItemsToVend

        return "\(numberOfItemsToVend)개 제공함"
    }
}
// 자판기 인스턴스
let machine: VendingMachine = VendingMachine()

// print(machine.receiveMoney(500)) -> 이런식으로는 안된다. throws함수(메서드)를 이용할 때는 
// try, do-catch이용하여 오류대비하며 호출해야한다. 

//MARK: - 오류처리
/* 오류발생의 여지가 있는 throws 함수(메서드)는 
try 를 사용하여 호출해야함.
try, try?, try! */

//MARK: do-catch
/*오류발생의 여지가 있는 throws 함수(메서드)는
do-catch 구문을 활용하여 오류발생에 대비함.*/

// throws함수(메서드)의 오류발생대비하는 do-catch 구문과 throws 함수(메서드)를 호출하는 try를 같이 사용.
do {
    try machine.receiveMoney(0)
} catch VendingMachineError.invalidInput {
    print("입력이 잘못되었습니다.")
} catch VendingMachineError.insufficientFunds(let moneyNeeded) {
    print("\(moneyNeeded)원이 부족합니다.")
} catch VendingMachineError.outOfStock {
    print("수량이 부족합니다.")
} //입력이 잘못되었습니다.

do {
    try machine.receiveMoney(300)
} catch /*(let error)*/ {

    switch error {
        case VendingMachineError.invalidInput:
        print("dd")
        case VendingMachineError.insufficientFunds(let moneyNeeded):
        print("ee")
        case VendingMachineError.outOfStock:
        print("ww")
        default:
        print("qq")
    }
}
// 위 방식은 좀 많이 번거로움.
// 굳이 하나하나 핸들링할 필요없다면 아래와같이 할수도있음.

// 판매결과를 전달받을 변수
var result: String?
do {
    result = try machine.vend(numberOfItems: 4)
} catch {
    print(error)
} //insufficientFunds(100)

// 아니면 아 난 에러발생해도 신경안쓸래. 하면 더 간단히.
var result: String?
do {
    result = try machine.vend(numberOfItems: 4)
}

//MARK: try? 와 try!
//try?
/* 별도의 오류처리 결과를 통보받지 않고
오류가 발생했으면 결과값을 nil로 돌려받을 수 있습니다. 
정상동작 후에는 옵셔널 타입으로 정상 반환값을 돌려 받습니다.*/

result = try? machine.vend(numberOfItems: 2)
result // Optional("2개 제공함")

result = try? machine.vend(numberOfItems: 2)
result //nil
// 오류를 nil로 반환하니까 do-catch구문이 필요없는 것임. 

//try!
/* 오류가 발생하지 않을 것이라는 강력한 확신을 가질 때 사용하면
정상동작 후에 바로 결과값을 돌려받습니다. 
오류 발새하면 런타임 오류가 발생하여 애플리케이션 동작이 중지됩니다. */

result = try! machine.vend(numberOfItems: 1)
result //1개 제공함


<29강. 고차함수 higher-order function>

//전달인자로 함수를 전달받거나
//함수실행의 결과를 함수로 반환하는 함수.

//map, filter, reduce   // 클로저 형식으로 잘 사용함.

//MARK:- map
//컨테이너 내부의 기존 데이터를 변형(transform)하여 새로운 컨테이너 생성
let numbers: [Int] = [0,1,2,3,4]
var doubledNumbers: [Int]
var strings: [String]

//MARK: for 구문 사용.
// doubledNumbers = [Int]()
// strings = [String]()

// for number in numbers {
//     doubledNumbers.append(number * 2)
//     strings.append("\(number)")
// }
// print(doubledNumbers)
// print(strings)

//MARK: map 메서드 사용
// numbers의 각 요소를 2배하여 새로운 배열 반환.
doubledNumbers = numbers.map({(number: Int) -> Int in
        return number * 2
}) // [0, 2, 4, 6, 8]

strings = numbers.map({(number: Int) -> String in  // 여기서 넘버는 그냥 매개변수임. numbers의 각 요소를 가르키는.
return "\(number)"
}) //["0", "1", "2", "3", "4"]

// 매개변수, 반환타입, 반환 키워드(return) 생략, 후행 클로저.
doubledNumbers = numbers.map { $0 * 2 }
print(doubledNumbers)

//MARK: - filter
// 컨테이너 내부의 값을 걸러서 새로운 컨테이너로 추출

//MARK: for 구문 사용.
// 변수 사용에 주목하세요.
var filtered: [Int] = [Int]()

for number in numbers {
    if number % 2 == 0 {
        filtered.append(number)
    }
}

print(filtered)

//MARK: filter 메서드 사용.
// numbers의 요소 중 짝수를 걸러내어 새로운 배열로 반환.
// let evenNumbers: [Int] = numbers.filter {
//     (number: Int) -> Bool in // Bool타입 반환해서 참인 것만 담아라라는 뜻.
//     return number % 2 == 0
// }

// 매개변수, 반환 타입, 반환 키워드(return)생략, 후행 클로저.
let evenNumbers: [Int] = numbers.filter {$0 % 2 == 0}
print(evenNumbers)

//MARK: - reduce
// 컨테이너 내부의 콘텐츠를 하나로 통합.
let someNumbers: [Int] = [2, 8, 15]

//MARK: for 구문 사용.
// 변수 사용에 주목하세요.
var result: Int = 0

//someNumbers의 모든 요소를 더합니다. 
for number in someNumbers {
    result += number
}
// print(result) //25

//MARK: reduce 메서드 사용.
//초깃값이 0이고, someNumbers 내부의 모든 값을 더합니다. 
let subtract: Int = someNumbers.reduce(0, {  //reduce 메서드 자체가 초깃값 + 어떤변수니까 클로저 매개변수 2개인 것임가?..
    (first: Int, second: Int) -> Int in
    return first - second
})
//print(subtract) // -25

let sumFromThree: Int = someNumbers.reduce(3) { $0 + $1 }
print(sumFromThree) // 28

print(someNumbers.reduce(1) { $0 * $1 })
