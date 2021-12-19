//문자열 보간법
let hiHs: String = "Hi, Hyenosoo-Kim"
print("Hi bc haha \(hiHs)")

//상수, 변수
//기본형 ->  let intTest: Int = 10  &  let stringTest: String = "Test!!!"
let intTest = 10
let stringTest = "Test!!!"
print(intTest, stringTest)
print(type(of:intTest), type(of:stringTest))  //알아서 자료형이 추론된다. intTest - Int형, stringTest - String형.

let nilTest: Int?
nilTest = 7
print(nilTest!)  // 값이 없기에 에러 발생



var nullTest: Int? // 엥 이것도 nil이라 안나오네 왜지??????????
print(nullTest) // ! 해서 강제 언래핑 해도 nil이 안나오네 왜지?

//Bool type
var someBool: Bool = true
print(someBool)
someBool = false
print(someBool)

//Int type
//보통 요새 컴은 자동 64bit Int 임. UInt하면 음수 빼고 0~양의 정수.
//Int랑 UInt도 서로 호환안되서 형변환해줘야할걸??

//Float type, Double type

//Character, String type

//Any, AnyObject, nil

//Array
var integer: Array<Int> = Array<Int>()
integer.append(1)
integer.contains(1)
print(integer)
integer.remove(at:0)
print(integer.count)

//Array 생성 방법
var integer1: Array<Int> = Array<Int>() //가장 기본형
var integer2: Array<Int> = [Int]()
var integer3: [Int] = [Int]()
var integer4: [Int] = []
var integer5 = [1,2,3]

integer4.append(135)
print(integer4, integer5)

//Dictionary
var dict: Dictionary<String, Int> = [String:Int]()  // 가장 기본형
dict["um"] = 3  // 썼던 key값 또 쓰면 value값이 변경됨.
print(dict)
dict["a"] = 1; dict["b"] = 2; dict["um"] = 5
dict.removeValue(forKey: "b")
dict["a"] = nil
print(dict)

//Dictionary 생성 방법.
var dict1: Dictionary<String, Int> = [String:Int]()
var dict2: [String:Int] = [:]
var dict3: [String:Int] = ["q":3,"w":5,"e":7]

값 생성(썼던 키 다시 쓰면 value값이 수정됌.)
anyDictionary[key] = value //어떤 key와 value를 생성.

값 제거
anyDictionary.removeValue(forkey: "~")
anyDictionary[key] = nil



//잘못된 예시 : let someValue: String = dict3["q"]   -> 이렇게 해도 못가져옴. "q"라는 키에 값이 있을수도 없을수도 있으니!! 옵셔널 개념에서 다시 배움.


//Set
var integerSet: Set<Int> = Set<Int>()  // 얘는 생성방법 이거 하나임.
integerSet.insert(1)
integerSet.insert(100)
integerSet.insert(99)
print(integerSet)
//contain, remove, count 사용. Array와 동일.

//집합(Set)에 리스트(Array)를 바로 넣기
let setList: Set<Int> = [1,2,3,4,5] // Set에 List 값을 순서대로 바로 넣어도, 결국 Set 타입이 되는 거라서, 출력시 순서 뒤죽박죽.
print(setList.contains(1))
print(type(of:setList))
print(setList)

//집합별 구하기 : union합집합, intersection교집합, subtracting 차집합.
let union: Set<Int> = integerSet.union(setList)
print(union)
print(union.sorted()) //sorted 정렬.
let sortedUnion: [Int] = union.sorted()


//함수
//기본형태
func sum(a: Int, b: Int) -> Int {
    return a + b
}
print(sum(a:1, b:3) ) // 이게 왜 오류뜨지?(매개변수 안쓴 상태) -> 이제 되네.. 매개변수 일일이 써주기 귀찮은디..?.. 안에 어떤 매개변수가 있는지 알고..?

//반환값이 없는 함수
func printMyname(name: String) -> Void { // 이거 그냥 보이드 안쓰고 ) { 이렇게 해도 알아서 되긴 함. 반환값 없을 때!
    print(name)
}
printMyname(name: "ㅎㅇ")

//매개변수가 없는 함수
func maxIntValue() -> Int {
    //함수구현부
    return Int.max
}
print(maxIntValue()) // 이게 뭐누..

//그냥 해본것.
func test(a: Int, b:Int...) {
    print("hello \(a),\(b)")
}
print(test(a:1))

// 기본값 설정. 매개변수 안불러도 기본값으로 나옴. 그 매개변수에 다른 값 넣으면 다른 값으로 나오고.
func a(b: String, c: String = "yagom") {
    print("Hello \(b) ! I'm \(c)")
}
print(a(b: "jason"))
print(a(b: "jason", c: "swiftist"))

// 전달인자 레이블
func a(b bbb: String, c ccc: String) {
    print("Hello \(bbb) ! I'm \(ccc)")
}
print(a(b: "wewewe", c: "qwqwqw"))

func a(_ bbb: String, _ ccc: String) {
    print("Hello \(bbb) ! I'm \(ccc)")
}
print(a("wewewe", "qwqwqw"))

// 가변 매개변수 - 반환값(return)없이 단순 print문일 경우 반환값 명시 안해줘도 됨.
func a(b: String, c: String...) {  // ...을 해주면 이 c라는 매개변수에 값을 안 넣을수도 여러개 넣을 수도 있어짐.
    print("Hello \(b) ! I'm \(c)")
}
print(a(b: "bam"))
print(a(b: "bam", c:"kick", "kicker"))

// 가변 매개변수 - 반환값(return) 있는 경우 : 반환값을 말해주어야 함. 귀찮아도 이게 깔끔한 듯?
func a(b: String, c: String...) -> String {  // ...을 해주면 이 c라는 매개변수에 값을 안 넣을수도 여러개 넣을 수도 있어짐.
    return "Hello \(b) ! I'm \(c)"
}
print(a(b: "bam"))
print(a(b: "bam", c:"kick", "kicker"))

// 위의 요소들을 종합적으로 사용도 가능. 
// 가변 매개변수 + 전달인자 레이블 + 기본값 설정 등등.

func a(b bbb: String, c ccc: String = "cc") -> String {  // ...을 해주면 이 c라는 매개변수에 값을 안 넣을수도 여러개 넣을 수도 있어짐.
    return "Hello \(bbb) ! I'm \(ccc)"
}
print(a(b: "bam"))
print(a(b: "baa", c:"kick"))

func a(b bbb: String, c ccc: String = "cc"...) -> String {  // ...이랑 기본값 설정은 같이 못쓰나보다...
    return "Hello \(bbb) ! I'm \(ccc)"
}
print(a(b: "bam"))
print(a(b: "baa", c:"kick", "kicker")) //error

func a(b bbb: String = "hi", c ccc: String...) -> String {  // ... 없는 곳에서는 기본값 되네.
    return "Hello \(bbb) ! I'm \(ccc)"
}
print(a(b: "bam"))
print(a(c:"kick"))
print(a()) // -> 이렇게 쓰면, 기본 반환값 틀에다가 기본값인 hi는 붙여서 나온다. 

func a(b bbb: String..., c: String...) -> String {  // 
    return "Hello \(bbb) ! I'm \(c)"
}
print(a(b: "bam","bi", c:"kick","er"))

func a(b bbb: String..., c ccc: String...) -> String {  // 가변매개변수는 함수당 하나라더니 두개도 되네 뭐. 전달인자 레이블 때문도 아님. 위에꺼도 돌아감.
    return "Hello \(bbb) ! I'm \(ccc)"
}
print(a(b: "bam","bi", c:"kick","er"))


// swift는 함수형 프로그래밍 패러다임을 포함하는 다중 패러다임 언어임.
// 스위프트 함수는 변수, 상수 등에 저장이 가능하고, 매개변수를 통해 전달할 수도 있다. 
// 변수, 상수 등에 저장하기.
func a(b bbb: String, c ccc: String) -> String {  
    return "Hello \(bbb) ! I'm \(ccc)"
}
// var someFunction: String = a(b: "eric", c: "yagom") //이런식으로도 가능!!
// print(someFunction)
var someFunction: (String, String) -> String = a(b:c:) //선언 변수이름: (매개변수타입, 매개변수타입...) -> 반환값타입 = 함수이름(레이블이름:레이블이름:)
print(type(of:someFunction))
print(someFunction("eric", "yagom"))
// [   (String, String) -> String   ]  -> 이런 표현이 클로저의 타입 표현임!
/////////////////////////////////////////왜 위에껀 에러걸리고, 아래꺼는 될까...?///////////////////////////////////////////////
func a(b bbb: String, c ccc: String) {  
    print("Hello \(bbb) ! I'm \(ccc)")
}

var someFunction: (String, String) -> Void = a(b:c:) //선언 변수이름: (매개변수타입, 매개변수타입...) -> 반환값타입 = 함수이름(레이블이름:레이블이름:)
print(type(of:someFunction))
someFunction("eric", "yagom")

//타입이 다른 함수는 할당할 수 없음.
//가변매개변수도 일반적인 매개변수랑은 다른 타입인 것이라서 할당이 불가능. 

// 함수를 매개변수로 전달하가.
func kicker(megebeonsoo: (String, String) -> Void) {
    megebeonsoo("mike", "roy")
}
kicker(megebeonsoo: a(b:c:))  // 함수 자체를 호출한 것.
kicker(megebeonsoo: someFunction) // 함수가 저장된 변수를 호출한 것.

//조건문
//if 문은 파이썬이랑 너무 같아서 생략. 중괄호 넣는거 빼고 같음. 조건문에는 항상 bool 타입.
// 아 그거는 다름. 그 뭐냐 if 옆에 아무거나 쓰고 0이 아닌 값이면 트루로 인식되겠지. 이런 건 다름. 아 근데 그건 파이썬도 안될건딩..?


//switch
var someInteger = 100 
switch someInteger {
    case 0:            //이거 들여써도 오류 안난다.
        print("zero")
    case 100:
        print("100!!!")
    default:
        print("shit")
}

var someInteger = 100 
switch someInteger {
case 0:            //이거 들여써도 오류 안난다.
    print("zero")
case 100:
    print("100!!!")
default:
    print("shit")
}
// switch 는 break 안써줘도 알아서 break 걸림. 안 걸고 싶을 때 혹은 바로 다음 패턴으로 내리고 싶으면 fallthrough

var someInteger = 12
switch someInteger {
case 0:            //이거 들여써도 오류 안난다.
    print("zero")
case 100 , 12:  // 이렇게 패턴 묶어도 된다. 
    print("100!!!")
default:
    print("shit")
}

var someInteger = 100
switch someInteger {
case 0:           
    print("zero")
case 100:
    print("100!!!")
default:
    print("shit")
}

var someInteger = 100   // 중괄호 불편하네 레알
if someInteger > 100 {
    print("no")
}   else if someInteger == 100 {
        print("fdfdfd")
    }

var someInteger = 100 
if someInteger > 100 {
    print("no")
} else if someInteger == 100 {
print("fdfdfd")
}

// 반복문
// while 옆 condition은 무조건 bool 타입이 와야함. 다른 언어는 0이 아닌 거 넣으면 쭉 내려가는데 이거는 다르밍.!!!
// for문이나 while문도 비슷해서 생략. 걍 중괄호만 다름.

//repeat while 구문. 기존 do while과 거의 같음. 스윕에서는 do라는 용어를 오류처리에서 써서 이름바꿈.
//리핏 구문 안에가 먼저 실행된 후에 와일에서 조건을 체크하고 와일문 나아가는 것임. 걍 파이썬 while 속 while이랑 같은 거 아닌가...?

//Optional
var a: Int?

print(a)

// var로는 장난질해도됌. 하지만 let으로 ? 쓸거면 바로 값 넣어야함.


if condition
statements

while condition

switch value
case pattern
code
pattern
code

let a: Int? = nil
let a: Int = nil // error 발생. 

// 옵셔널 바인딩 : nil 체크 + 안전한 값 추출


func printName(_ name: String) {
    print(name)
}
var myName: String? = nil
a(myName)  //  -> error! 전달되는 값의 타입이 다르기에! 옵셔널 변수와 일반 변수는 다른 타입임.


func printName(_ name: String) {
    print(name)
}
var myName: String? = nil
if let name: String = myName {
    printName(name)
} else {
    print("myName == nil")
}

var myName: String? = nil
if let name = myName {
    print(name)
} else {
    print("dd")
}

var myName: String? = "hello"
if let name = myName {
    print(name)
} else {
    print("dd")
}



// 강제 추출 방식은 ! 를 씀. 추천하진 않음.

!의 경우 nil값이면 런타임 오류...?


// struct  : data들을 저장하는 공간.? class랑 비슷한 느낌이지만 다름. class는 참조느낌. 얘는 값 느낌. 
// class의 경우 
// a = someclass()
// b = a
// c = a
// 이런 후 c를 변경하면, a와 b까지 함께 변한다. 메모리를 공유하는 느낌.

// struct의 경우, c를 변경해도 a와 b에는 영향 주지 않는다. 그 때그때 변수를 생성할 때 새로운 메모리에 값을 할당하기 때문.!!
struct Sample {
    var mutableProperty: Int = 100  // 가변 프로퍼티(프로퍼티; 구조체(어떤 타입) 안에 있는 인스턴스 변수) - 인스턴스 프로퍼티; 이 구조체를 할당한 객체(인스턴스)에서 사용하는 구조체 속 변수.
    let immutableProperty: Int = 100 // 불변 프로퍼티                                                 - 인스턴스 프로퍼티


    // static : 외부 변수에 초기화 못함. 할당을 못함. 인스턴스가 아님. 밖에서 얘 값 덮어쓰기로 바꿀수도 없음!!.
    static var typeProperty: Int = 100 // 타입 프로퍼티

    //인스턴스 메서드(구조체 속 함수)
    func instanceMethod() {
        print("instance method")
    }

    // 타입 메서드
    static func typeMethod() {
        print("type method")
    }
}

Sample.typeProperty = 200
print(Sample.typeProperty) //타입프로퍼티는 구조체 타입? 그 자체임. 외부 변수에 할당 안됨. 통째로 그 자체로 불러올 수 있는 느낌. 그냥 하나의 타입임 얘도.

//가변 인스턴스
var a: Sample = Sample()
//var b = a
a.mutableProperty = 200  // var라서 바꿀 수 있음. 
var b = a
print(b.mutableProperty)
// 위에꺼 보면 어느정도 이해들 되지? 될거라 믿을게!

// 자 그럼 하나 더!
struct Student {
    var name: String = "unknown"
    var `class`: String = "Swift"  //`` -> 백틱? 백커틱? 이거 쓰면 기존 내장된 언어들과 겹쳐도 변수로 인식할 수 있음.

    static func selfIntroduce() {
        print("im student")
    }
    func selfIntroduce() {
        print("저는 \(self.class)반 \(name)입니다.")
    }
}

Student.selfIntroduce()

var yagom: Student = Student()  //구조체 Student를 타입으로 선언하고, Student()라는 구조체를 할당. ??... 앞에 Student는 안써도됨.
yagom.name = "yagom"
yagom.class = "스위프트"
yagom.selfIntroduce()

// class ; 구조체와 유사하나 다름. 얘는 참조타입. 다중 상속이 불가능함. 

class Sample {
    var mutableProperty: Int = 100  
    let immutableProperty: Int = 100                                              

    static var typeProperty: Int = 100 

    func instanceMethod() {
        print("instance method")
    }
// 여기까지는 struct와 동일하게 씀. 사용방식? 쓰는방법이 비슷.
// 이제부터 좀 다른 기능 있나봐.
    static func typeMethod() { // (나중에 상속을 받았을 때)재정의가 불가능한 타입 메서드
        print("type method - static")
    }
    class func classMethod() { // 재정의가 가능한 타입 메서드
        print("type method - class")
    }
}

// 클래스 사용.
var mutableReference: Sample = Sample()
let immutableReference: Sample = Sample() // 구조체와는 다르게 이 변수 안에서 mutableproperty의 값을 만질 수 있음. 구조체에서는 let으로 인스턴스객체 만든 순간 아예 못 건드림.
// 물론 immutableProperty는 못건드림. 뮤터블 건드리는 것도 천 선언 시만 건드리는 거겠지???
immutableReference.mutableProperty = 200
print(immutableReference.mutableProperty)
immutableReference.mutableProperty = 300
print(immutableReference.mutableProperty) // 엥 되네? 흠. 저 클래스 속 값을 임시로 바꾼것일 뿐이고, let이 Sample()을 가져왔다는 값은 변하지 않아서 인가부다.

//열거형 
// enum은 타입이므로 대문자 카멜케이스를 사용하여 이름을 정의.
// 각 case는 소문자 카멜케이스로 정의.
// 각 case는 그 자체가 고유의 값임.
enum Weekday {
    case mon
    case tue
    case wed
    case thu, fri, sat, sun
}

var day: Weekday = Weekday.mon 
day = .tue  //Weekday가 day의 type으로 선언되었기 때문에, .tue 처럼 점만 찍어줘도 사용이 가능하다. 

print(day)

// 열거형은 switch 구문에서도 많이 사용됨. 
switch day {
case .mon, .tue, .wed, .thu:  // 이미 위에서 day의 자료형타입이 Weekday라는 열거형임을 나타냈기 때문에 .(점)만 찍어되는 거임. 
    print("평일입니다.")
case Weekday.fri:
    print("불금 파티!!!")
case .sat, .sun:
    print("신나는 주말!!!")
}

// switch를 제대로 공부했다면? 의문이 생겨야지. 왜 default를 안 넣었을 까?
// 해답!! : 열거형 자료 속 값들을 모두 사용한 경우 나머지가 없기 때문에 안 넣는 것!!! day에 있는 모든 값을 썼으니 오류가 뜰 수 없으니.


// C언어의 enum처럼 정수값을 가질 수도 있음. 
// rawValue(원시값)을 사용하면 됩니다. 
// case별로 각각 다른 값을 가져야합니다. 
enum Fruit: Int {  // 원시값을 가질 타입을 명시. Int
    case apple = 0 // 여기 0 넣으면 그 이후 알아서 12345~ 올라감. 
    case grape
    case peach
}
print(Fruit.peach.rawValue)

enum Fruit: Int {  
    case a
    case g
    case p
}
print(Fruit.g.rawValue) // 흠 그냥 Int를 enum에 타입 선언한 순간 원시값인 0123456...이 순서대로 나옴.


enum Fruit: Int {  
    case a = 1   // 시작순서 바꿀 수 있음. 
    case g
    case p
}
print(Fruit.g.rawValue) // 2로 나옴.

// String 열거의 경우 원시값(rawValue)을 예측할 수 없기 때문에 값 안 적어줄 경우 원시값 불러도, 그냥 case 고대로 나옴.

enum Fruit: Int {  // 원시값을 가질 타입을 명시. Int
    case apple = 0 // 여기 0 넣으면 그 이후 알아서 12345~ 올라감. 
    case grape
    case peach
}
let apple: Fruit? = Fruit(rawValue: 0) //?를 통해 옵셔널 선언안할 시 error 발생함. 0번째 rawValue가 있을수도 없을수도 있으니!!

if let _: Fruit = Fruit(rawValue: 5) { //immutable value 'orange' was never used; consider replacing with '_' or removing it
    print("울랄라세션")
} else {
    print("해당 케이스 놉")
}

// 열거형 메서드
enum Month {
    case dec, jap, feb
    case mar, apr, may
    case jun, jul, aug
    case sep, oct, nov

    func printMessage() {
        switch self {
            case .mar, .apr, .may:
                print("따스한 봄")
            case .jun, .jul, .aug:
                print("더운 여름")
            default:
                print("귀찮아")
        }
    }
} 

Month.dec.printMessage()

