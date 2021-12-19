/*
클로저
코드의 블럭
일급 시민(first-citizen)
변수, 상수 등으로 저장, 전달인자로 전달이 가능
함수 : 이름이 있는 클로저
*/

// 클로저 기본 구조.
{ (매개변수 목록) -> 반환타입 in
    실행 코드
}                                  // 이 하나가 코드의 블럭이 되는 것임. 

// 매개변수가 필요없을 때.
{ () -> 반환타입 in
    실행 코드
}

// + 반환타입이 없을 때.
{ () -> Void in
    실행 코드
}

// 원래 우리가 함수를 사용한다면
func sumFunction(a: Int, b: Int) -> Int {
    return a + b 
}

// var sumResult: Int = sumFunction(a: 1, b: 2)
var sumResult: (Int, Int) -> Int  = sumFunction(a:b:)
var hello = sumResult(a:2, b:3)
print(hello)
// 클로저의 사용
var sum: (Int, Int) -> Int = { (a: Int, b: Int) -> Int in
    return a + b
}
// print(sum(1,2))
sumResult = sum(1, 2)
print(sumResult)

// 함수는 클로저의 일종이므로, 클로저형태의 sum변수에는 당연히 함수도 할당할 수 있습니다. 
sum = sumFuntion(a:b:)

sumResult = sum(1,2)
print(sumResult)

/*
클로저는 주로 함수의 전달인자로 많이 쓰입니다.!!
함수에서 함수의 동작이 완료된 이후에 한 번 실행할 코드를 원한다거나,
이런 콜백의 용도로도 많이 사용됨. 
*/

var sum: (Int, Int) -> Int = { (a: Int, b: Int) -> Int in
    return a + b
} 

let add: (Int, Int) -> Int
add = { (a: Int, b: Int) -> Int in
    return a + b
}

let sub: (Int, Int) -> Int
sub = { (a: Int, b: Int) -> Int in
    return a - b
}

func calculate(_ a: Int, _ b: Int, _ method: (Int, Int) -> Int) -> Int {
    return method(a, b)
}

var calculated: Int = calculate(50, 10, add)
print(calculated)

calculated = calculate(50, 10, {(left: Int, right: Int) -> Int in
return left * right
})
print(calculated)

// var cal: Int
// cal = calculate(30, 50, add)
// print(cal)

var cal: (Int, Int) -> Int = { (a: Int, b: Int) -> Int in 
    return a * b
}
print(cal(10, 20))


// 클로저 고급
/*
후행 클로저
반환타입생략
단축 인자이름
암시적 반환 표현
*/

//주의점 : 클로저를 표현하는 방법은 너무 다양한데, 남들이 이해할 수 있는 선까지만 축약하는 것이 중요.
/* 
1) 클로저가 함수의 마지막 전달인자라면, 마지막 매개변수 이름을 생략한 후
함수 소괄호 외부에 클로저를 구현할 수가 있다. 
2) 반환타입 생략. 
함수에 이미 역할이 명시된 경우 반환타입이 생략 가능하다. 
3) 단축 인자이름 활용.
함수에 명시되있어 컴파일러가 추론가능한 상황이면 굳이 클로저에 매개변수이름:매개변수타입을 안써도됌.
단축 인자이름은 클로저의 매개변수 순서대로 $0, $1, $2, $3 ... 처럼 표현합니다. 
*/
func calculate(a: Int, b: Int, method: (Int, Int)-> Int) -> Int {
    return method(a, b)
}
// var result: Int
// result = calculate(a: 10, b:10) { (left: Int, right: Int) in //외부로 뺐고, 반환타입 생략함.
//     return left + right
// }
// print(result)
// //////////////////////////////////////////////////////////////////////////////////////////
// func calculate(a: Int, b: Int, method: (Int, Int)-> Int) -> Int {
//     return method(a, b)
// }

var result: Int
result = calculate(a: 10, b:10) {       //외부로 뺐고, 반환타입 생략함. 
    return $0 + $1 //$0은 Int타입의 매개변수left, $1은 Int타입의 매개변수right   // 단축 인자이름 활용. 이 때는 in도 생략해야함.
}
print(result)
//////////////////////////////////////////////////////////////////////////////////////////
// 외부로 뺄 때 어차피 그게 마지막 전달인자였던 method 자리인 것을 아니까 method 생략해도 되고, 
// 반환타입 함수에 적혀있으니, 클로저 불러올 땐 굳이 다시 안써도 알아서 컴파일러가 추론할 수 있으니 생략하고,
// 그 생략된 method의 매개변수가 몇개였는지 어떤 타입이였는지 함수에 명시되어있었으니 얘도 생략가능하고,
// 매개변서 소괄호가 없어졌으니 자연스럽게 in도 생략하면 된다!!! 총정리였다...

//암시적 반환 표현
// 함수의 클로저가 반환하는 값이 있다면 클로저의 마지막 줄의 결과값은 암시적으로 반환값 취급. 'return' 생략가능.
result = calculate(a:10, b:10) { $0 + $1 } // 한 줄로 써도되공.

//해보자~!

//프로퍼티 ([저장 프로퍼티, 연산 프로퍼티], [인스턴스 프로퍼티, 타입 프로퍼티])
// 연산프로퍼티는 var로만 선언 가능.
// 다만 열거형 내부에는 연산 프로퍼티만 구현할 수 있음. 

class Student {
    var name: String = ""
    var `class`: String = "Swift"
    var koreanAge: Int = 0
    var westernAge: Int {
        get {
            return koreanAge - 1
        }
        set(inputValue) {
            koreanAge = inputValue + 1
        }
    }
    var selfIntroduction: String {
        get {
            return "저는 \(self.class)반 \(name)입니다."
        }
    }
    static var typeDescription: String = "학생"
    static var selfIntroduction: String {
        return "학생타입입니다. "
    }
}
print(Student.selfIntroduction) 
var yagom: Student = Student()   
yagom.koreanAge = 10      
// yagom.westernAge = 10
yagom.name = "yagom"
print(yagom.name) 
print(yagom.selfIntroduction)  
print("제 한국나이는 \(yagom.koreanAge)살이고, 미쿡나이는 \(yagom.westernAge)살입니다. ")
// yagom.westernAge처럼 값을 가져올 때 get이 실행되는 것임. 
// koreanAge에 입력된 값을 기준으로 westernAge를 가져올 때는 get이 실행되는 거고,
// westernAge에 값을 직접 입력할 경우 set이 실행되며 koreanAge의 값을 바꿈.


//응용 - 환율에 따라서 돈을 계산하는 프로그램.
 struct Money {
     var currencyRate: Double = 1100
     var a: Int = 100
     var b: Int = 200
    // var sum: Int = a + b  -> 이런 방식 바깥에서는 되지만, 이런 구조체블록 안에서는 안됨. 
     var sum: Int {
         get{
             return a + b
         }
     }
     var dollar: Double = 0
     var won: Double {
         get {
             return dollar * currencyRate
         }
         set {
             dollar = newValue / currencyRate
         }          // set 옆에 굳이 안쓰고플 때는 newValue 쓰면된다!!!
     }
 }

var test: Money = Money()
test.dollar = 10
print(test.won)
var text: Money = Money()
text.won = 5000
print(text.dollar)


var a: Int = 100
var b: Int = 200
// var sum: Int = a + b
var sum: Int {
    get{
        return a+b
    }

}
print(sum)


//프로퍼티 감시자; 프로퍼티 값이 변경될 때 원하는 동작을 수행할 수 있도록 도와주는 것.
struct Money {
    var currencyRate: Double = 1100 {
        willSet(newRate) {
            print("환율이 \(currencyRate)에서 \(newRate)로 변경될 예정입니다.")
        }
        didSet(oldRate) {
            print("환율이 \(oldRate)에서 \(currencyRate)으로 변경되었습니다.")
        }
    }
    var dollar: Double = 0 {
        willSet {  // willset의 암시적 매개변수 newValue
            print("\(dollar)달러에서 \(newValue)달러로 변경될 예정입니다.")
        }
        didSet {
            print("\(oldValue)달러에서 \(dollar)달러로 변경되었습니다.")
        }
    }
    var won: Double {
        get {
            return dollar * currencyRate
        }
        set {
            dollar = newValue / currencyRate
        } // 프로퍼티 감시자와 연산 프로퍼티 기능을 동시에 쓸 수는 없습니다. 
    }
}

var moneyInMyPocket: Money = Money()

moneyInMyPocket.currencyRate = 1150

moneyInMyPocket.dollar = 10

print(moneyInMyPocket.won)

//상속 inheritance
// 스위프트의 상속은 클래스, 프로토콜 등에서 가능.      열거형, 구조체는 상속 불가능.
// 스위프트는 다중상속을 지원하지 않습니다. (여러 클래스를 상속받지 못함.)

//클래스의 상속과 재정의
// class 이름: 상속받을 클래스 이름 {
//     구현부
// }

class Person {
    var name: String = ""

    func selfIntroduce() {
        print("저는 \(name)입니다.")
    }
    final func sayHello() { //final키워드를 사용하여 "재정의를 방지"할 수 있습니다. -> 자식클래스에 상속줬을 때 바꿀 수 없는 함수임. 오바라이드 할 수 없단 뜻이죠.
        print("hello")
    }
    static func typeMethod() { //타입 메서드. "재정의 불가" 타입 메서드 - static
        print("type method - static")
    }
    class func classMethod() { // "재정의 가능" 타입 메서드 - class
        print("type method - class")
    }
    final class func finalCalssMethod() { //class 메서드라도 앞에 final있으면 "재정의 불가!" final class = static
        print("type method - final class")
    }
}

class Student: Person {
    //Person class에 있는 프로퍼티 및 함수는 받아들여진 것임. 같은 거 또 쓰지 않길.
    var major: String = ""

    override func selfIntroduce() { //override; 덮어씌우기. 재정의 하는 것. 
        print("저는 \(name)이고, 전공은 \(major)입니다. ")
        // super.selfIntroduce() // 부모클래스의 메소드를 호출하는 법. 
    }
    override class func classMethod() { // 재정의 가능. 
        print("overriden type method - class")
    }
    // 그 외 재정의할 수 없는 것들은 override해도 재정의 할 수 없음.
}

let yagom: Person = Person()
let hana: Student = Student()

// 인스턴스의 생성과 소멸 // init(이니셜라이저), deinit(디이니셜라이저)
// 프로퍼티 기본값
/* 스위프트의 모든 인스턴스는 초기화와 동시에 모든 프로퍼티에 유효한 값이 할당되어 있어야 합니다. 
프로퍼티에 미리 기본값을 할당한다면 인스턴스가 생성됨과 동시에 초기값을 지니게 됩니다. */
class PersonA {
    //모든 저장 프로퍼티에 기본값 할당해야 PersonA()를 받는 인스턴스(객체, 변수?)가 생성될 수 있는 것임. 
    var name: String = "unknown"
    var age: Int = 0
    var nickName: String = "nick"
}

let jason: PersonA = PersonA()
jason.name = "jason"
jason.age = 30
jason.nickName = "j"

// 이니셜라이저를 사용하게 되면 프로퍼티 기본값을 지정하지 않더라고, 실제로 인스턴스가 초기화될 때 원하는 값들을 넣어줄 수 있음. 
// init(이니셜라이저)
class PersonB {
    //모든 저장 프로퍼티에 기본값 할당해야 PersonA()를 받는 인스턴스(객체, 변수?)가 생성될 수 있는 것임. 
    var name: String = "unknown"
    var age: Int = 0
    var nickName: String = "nick"
    //이니셜라이저
    init(_ name:String, _ age: Int, _ nickName: String) {
        self.name = name  // self.name은 class 인스턴스 그 자체인 저 위의 var name의 name을 나타낸다. 
        self.age = age    //  이퀄 옆의 name은 init의 매개변수로 들어온 name이다. 
        self.nickName = nickName
    }
}
let jason: PersonB = PersonB("ha",20,"ee")
jason.name = "ho"
print(jason.age)

// 프로퍼티의 초기값이 꼭 필요없을 때는 옵셔널을 사용!!! 혹은 그 프로퍼티를 꼭 이용하는 건 아니다 싶을 때!
class Aa {
    var a: String
    var b: Int
    var c: String?

    // convenience init(a: String, b: Int, c: String) { // 이미있는거 가져올때 그게 같은 클래스 내부면 컨비니언스사용.
    //     self.init(a:a,b:b) // 이미 있는 이니셜라이즈를 가져올 때 self.init 사용.
    //     self.c = c
    // }
    init(a: String, b: Int) {
        self.a = a  // 옵셔널 선언한 c는 매개변수로 써도 안써도 됨. 
        self.b = b
    }
}
let jenny: Aa = Aa(a:"jenny", b:24)


jenny.c = "hello"
print(jenny.c!)

if let takeOff = jenny.c {   // if let 벗긴거 닮을 곳 = 벗길 것 {
    print(takeOff)           //     print(벗긴거 닮을 곳)
} else {                     // } else {
    print("nil")             //     print("nil")
}                            // }

// 암시적 추출 옵셔널은 인스턴스 사용에 꼭 필요하지만 초기값을 할당하지 않고자 할 때 사용. (그냥 ? 옵셔널은 인스턴스 사용에 그 프로퍼티가 딱히 있어도 없어도 될 때 사용.)
class Puppy {
    var name: String
    var owner: String!
    init(name: String) {
        self.name = name
    }
    func goOut() {
      print("\(name)은 \(owner)와 나가길 원함")
    }
}


let happy: Puppy = Puppy(name: "happy")
print(happy.name)
happy.owner = "hyeonsoo"
// if let sad = happy.owner {
//     print(sad)
// }
happy.goOut()

//실패가능한 이니셜라이저
// 이니셜라이저 매개변수로 전달되는 초기값이 잘못된 경우(전달받은 값들이 정상범주를 넘어간다거나, 우리가 원하는 범위가 아니라면.) 인스턴스 생성에 실패할 수 있습니다. 
// 인스턴스 생성에 실패하면 nil을 반환합니다. 
// 그래서 실패가능한 이니셜라이저의 반환타입은 옵셔널 타입입니다. 
// 한 마디로 허황된 초깃값이 들어오게 될 시에는 nil 내보내라 이거.
class Failed {
    var name: String
    var age: Int
    var nickName: String?

    init?(name: String, age: Int) {
        if (0...120).contains(age) == false {
            return nil
        }
        if name.count == 0 {
            return nil
        }
        self.name = name
        self.age = age
    }
}
// init?으로 이니셜라이저했으면 클래스밖에서 인스턴스 생성시에 타입에 옵셔널 취해야함.
let a: Failed? = Failed(name: "erer", age: 25)
print(a)
// 잘모르겠당.

// deinit 디이니셜라이저; 클래스의 인스턴스가 메모리에서 해제되는 시점에 호출됨. 인스턴스가 해제되는 시점에 해야할 일을 구현할 수 있음. 



