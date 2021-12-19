<야곰 23강.옵셔널 체이닝과 nil 병합 연산자>
// optional chaining & nil-coalescing operator

/* 구조체나 클래스를 선언할 때 구조체 안에 또 다른 구조체 인스턴스가 들어올 수 있고, 
구조체 인스턴스안에 또다른 구조체 인스턴스가 또 연결되어서
프로퍼티를 타고타고 들어가야 되는 경우가 있는데, 이 프로퍼티 자체가 옵셔널인 경우에는
이것이 nil인지 아닌지 자꾸 체크를 해봐야하는 상황이 생기는데
이때 옵셔널 체이닝을 유용하게 사용할 수 있음. */

// 요약 : 옵셔널 체이닝; 옵셔널 요소 내부의 프로퍼티로 또다시 옵셔널이 연속적으로
//        연결되는 경우 유용하게 사용 가능.
class Person {
    var name: String
    var job: String?
    var home: Apartment?

    init(name: String) {
        self.name = name
    } // 아직은 nil로 할당된 상태.
}

class Apartment {
    var buildingName: String
    var roomNumber: String
    var gad: Person?
    var owner: Person?

    init(dong: String, ho: String) {  
        buildingName = dong
        roomNumber = ho
    } // 아직은 nil로 할당된 상태.
}

let yagom: Person? = Person(name: "yagom")
let apart: Apartment? = Apartment(dong: "101", ho: "202")
let superman: Person? = Person(name: "superman")
// 왜 다들 옵셔널 타입으로 받는거지? ////////////////////////

yagom?.home = apart
yagom?.home?.gad = superman
// yagom?.home?.gad?.name
yagom?.home?.gad?.job = "경비원"

// 옵셔널 체이닝을 사용하지 않고, 우리집 경비원의 직업이 궁금하다면?
// func guardJob(owner: Person?) {
//     if let owner = owner {
//         if let home = owner.home {
//             if let gad = home.gad {
//                 if let gadJob = gad.job {
//                     print("우리집 경비원의 직업은 \(gadJob)입니다.")
//                 }
//                 else {
//                     print("우리집 경비원은 직업이 없어요.")
//                 }
//             }
//         }
//     }
// }
/* 프로그래밍 형태 및 순서를 잘생각하자. 특히 옵셔널 프로퍼티의 경우!!!!
문제가 "우리집 경비원의 직업이 무엇인가요?"했을 때 소유주인 owner, 그 자의 집, 그 집에 경비원이 있는지 부터 차근차근 알아가야한다. 
1) 일단 너는 존재하냐? -> owner 확인. ;함수의 매개변수로 넣을 값이 첫번째 순서가 되겠지.
2) 너 집 있긴하냐? -> owner.home 확인
3) 너네 집에 경비원이 있긴하냐? -> home.gad 확인
4) 그 경비원 직업있냐? -> gad.job 확인 ㅇㅋ? */

// 옵셔널 체이닝을 사용한다면?
func gadJob(_ owner: Person?) {
    if let gJob = owner?.home?.gad?.job { // 캐간단. 근데 중간에 값없는 옵셔널이면 스탑됨.
        print("ㅇㅇ 있음. \(gJob)이거임.")
    }
    else {
        print("ㄴㄴ 어신디?")
    }
}

gadJob(yagom)
//////////////////////////////////////////////////////////////////////////////////////////
// nil 병합 연산자
var guardJob: String

guardJob = yagom?.home?.gad?.job ?? "슈퍼맨" //?? 를 붙여서 사용. .job에 값이 없다면 ?? 다음 값을 변수에 할당. 
print(guardJob)  //경비원 출력.

yagom?.home?.gad?.job = nil

guardJob = yagom?.home?.gad?.job ?? "슈퍼맨" // .job이 현재 nil 상태이니 "슈퍼맨"이 들어간 것.
print(guardJob) // 슈퍼맨 출력.


<야곰 24강. 타입캐스팅>

// 스위프트의 타입캐스팅은 인스턴스의 타입을 확인하는 용도.
// 클래스의 인스턴스를 부모 혹은 자식 클래스의 타입으로 사용할 수 있는지 확인하는 용도.
// is, as 키워드를 사용함. 

/*
기존의 다른 언어에서 타입캐스팅이라하면 아래와 같은 것을 생각해볼 수 있을 것이다. 
let someInt: Int = 100
let someDouble: Double = Double(someInt)
하지만 이런 형태는 실질적으로 스위프트에서는 타입캐스팅이 아니다. 
이것은 더블 타입의 인스턴스를 하나 더 생성하는 것일 뿐.
더블의 내장 이니셜라이저가 굉장히 많은데 그 중 Int타입의 값을 받아들여서 더블의 인스턴스를 하나 더 만들어주겠다라는 이니셜라이저일 뿐.
*/

//타입캐스팅을 위한 클래스 정의
class Person {
    var name: String = ""
    func breath() {
        print("숨을 쉽니다.")
    }
}
class Student: Person {
    var school: String = ""
    func goToSchool() {
        print("등교를 합니다.")
    }
}
class UniversityStudent: Student {
    var major: String = ""
    func goToMT() {
        print("멤버쉽 트레이닝을 갑니다. 신난다!!")
    }
}
var yagom: Person = Person()
var hana: Student = Student()
var jason: UniversityStudent = UniversityStudent()

//type check - use 'is'
// var result: Bool
// result = yagom is Person  //true  -  yagom은 사람타입니다. 
// result = yagom is Student  //false
// result = yagom is UniversityStudent  //false

// result = hana is Person //true
// result = hana is Student //true  - hana는 학생(학생은 사람이기도 하지.)입니다. 
// result - hana is UniversityStudent //false

// result = jason is Person //true
// result = jason is Student // true
// result = jason is UniversityStudent // true - jason은 대학생(학생이면서 사람이기도 하지.)입니다. 

if jason is UniversityStudent {
    print("yes Uni")
} else if yagom is Student {
    print("yes Stu")
} else if yagom is Person {
    print("yes Human")
} 

switch jason {
    case is Person:
    print("per")
    fallthrough  // 이거 안넣으면 걍 펄슨에서 끝나버림. 얘는 switch에서만 사용가능. 
    case is Student:
    print("stu")
    fallthrough
    case is UniversityStudent:
    print("uni")
    default:
    print("nonono")
}

// 아니면, 이렇게 자식클래스부터 나열하던지. 
switch jason {
    case is UniversityStudent:
    print("uni")
    case is Student:
    print("stu")
    case is Person:
    print("per")
    default:
    print("nonono")
}

// 업 캐스팅 ; as를 사용하여 부모클래스의 인스턴스로 사용할 수 있도록 컴파일러에게 타입정보를 전환해줍니다. 
// Any, AnyObject로도 타입정보를 변환 가능.; as Any는 생략해도 가능. 
var mike: Person = UniversityStudent() as Person  //사람타입으로 선언되었으나 실질적인 타입은 대학생.
var jenny: Student = Student()
var jina: Any = Person() //as Any 생략가능. 

print(type(of:mike)) // 타입검사하면 UniversityStudent로 나옴. 요렇겡.
// 사실 업캐스팅 많이 안쓴다고함. 

// 다운 캐스팅; 이게 중요. 
// as? 또는 as!를 사용하여 자식 클래스의 인스턴스로 사용할 수 있도록 컴파일러에게 인스턴스의 타입저보를 전환해줍니다. 

// 조건부 다운 캐스팅
// as?   ex) 나는 사람 클래스인데 학생인척 할 수 있느냐?? 사람타입으로 지정되있는데 실질적으로 학생이 될 수 있느냐?
// 되면 옵셔널 값으로 되는건가? 안되면 nil값 반환. 
var optionalCasted: Student?
optionalCasted = mike as? UniversityStudent
optionalCasted = jenny as? UniversityStudent //nil
optionalCasted = jina as? UniversityStudent //nil
optionalCasted = jina as? Student //nil

// 강제 다운 캐스팅
// as! ex) 타입선언이 사람인 mike에게 너 그냥 대학생해!! 하고 강제로 다운캐스팅하는 것. mike의 실질적인 타입은 uni이기에 괜찮음. 나머지는 런타임 오류 발생.
var forcedCasted: Student
forcedCasted = mike as! UniversityStudent
forcedCasted = jenny as! UniversityStudent //런타임 오류
forcedCasted = jina as! UniversityStudent //런타임 오류
forcedCasted = jina as! Student //런타임 오류

//활용. 주로 함수로 전달되는 경우에 이런거 많이 활용가능.
func doSomethingWithSwitch(someone: Person) {
    switch someone {
        case is UniversityStudent:
        (someone as! UniversityStudent).goToMT()
        case is Student:
        (someone as! Student).goToSchool()
        case is Person:
        (someone as! Person).breath()
    }
}
// 이런 switch구문은 이것을 확인만 할뿐이지 캐스티하려면 밑에서 다시 캐스팅해서 사용해야하는 상황이 발생. 뭐래누..
// 그래서 if let 구문 사용하면 캐스팅과 동시에 인스턴스를 반환받아서 언래핑할 수 있음. 
func doSomething(someone: Person) {
    if let universityStudent = someone as? UniversityStudent {  //if let 자체가 nil은 못받는 원리를 이용.
        universityStudent.goToMT()
    } else if let student = someone as? Student {
        student.goToSchool()
    } else if let person = someone as? Person {
        person.breath()
    }
}

doSomething(someone: mike)
// 멤버쉽 트레이닝을 간다 신남!!

// 타입캐스팅 함수? 나 딕셔너리 사용할 때 굉장히 많이 사용하니까 이런거 참고해두면 좋다고 하심. 


<25강. assert와 guard를 알아보자/ assertion, early exit>

// assert와 guard
/* 애플리케이션이 도작 도중에 생성하는 다양한 결과값을
동적으로 확인하고 안전하게 처리할 수 있도록 도와주는 칭구들. */

//MARK: - Assertion ; 어떠한 결과, 조건들을 갖추고 이거를 확인해보는데 사용. 
/* assert(_:_:file:line:) 함수를 사용.
assert 함수는 디버깅 모드에서만 동작. 주로 디버깅 중 조건의 검증을 위해 사용. (내가 예상했던 조건들이 맞는가.)
실제로 배포되는 애플리케이션에서 동작하진 않음. */
var someInt: Int = 0
assert(someInt == 0, "someInt != 0") //조건이 맞으면 이 함수를 pass하고, 틀리면 동작 중지. 우측값 설정해놨을 경우 우측값 실행.

someInt = 1
assert(someInt == 0, "someInt != 0") // 동작해보면 알것임. 우측값은 비워놔도됨. 

// assert()는 매개변수로 전달된 인자들을 검증할 때도 많이 사용하게 된다. 
func functionWithAssert(age: Int?) {
    assert(age != nil, "age == nil")

    assert((age! >= 0) && (age! <= 130), "나이값 입력이 잘못되었습니다. ") //엥 이런거 또 있긴했는뎅. 3일차 393행 참고.
    print("당신의 나이는 \(age!)세입니다.")
}
functionWithAssert(age: 50) // 잘 됨. 

//MARK: - Early Exit
/* guard를 사용하여 잘못된 값의 전달 시에 특정 실행구문을 빠르게 종료합니다. 
디버깅 모드 뿐만 아니라 어떤 조건에서도 동작합니다. 
guard의 else 블럭 내부에는 특정 코드블럭을 종료하는 지시어(return, break 등)가 꼭 있어야 합니다. 
타입 캐스팅, 옵셔널과도 자주 사용됩니다. 
그 외 단순 조건 판단 후 빠르게 종료할 때도 용이합니다. */
//구성 : guard (let;옵셔널 인자일때만.)     조건문    else {실행문   return or break}
func functionWithGuard(age: Int?) {

    guard let unwrappedAge = age,
            unwrappedAge < 130,
            unwrappedAge >= 0 else {
                print("나이값 입력 잘못됐음.")
                return
            }
    print("당신의 나이는 \(unwrappedAge)입니다.") //if let의 경우 그 구문안에서만 옵셔널 해제하지만, guard let의 경우 구문을 빠져나간 후에도 옵셔널 해제된 것이 유지되기에 밑에서 한 번더 옵셔널 추출할 필요가 없음. 
}
// functionWithGuard(age: 50)
functionWithGuard(age: -1) //return

// guard와 if의 비교.
func test(age: Int) {

guard age < 100 else {
    print("ㄴㄴ")
    return
}
print("통과됐나?")
}
test(age: 110)
//위아래 둘다 같은 걸 나타내고 있다. 이럴때는 guard가 편한듯. 
// 또 뭐 다른점들 있을 텐데 차차 해보자.
func test(age: Int) {
if age < 100 {
} else {
    print("ㄴㄴㄴ")
    return //return 안쓰면 else안에 들어와도 아래 프린트문으로 내려가고, 써주면 여기서 값 반환되면서 끝남. 
}
print("통과됐나???")
}
test(age: 110)

// guard는 반복문 안에서도 사용가능. 뭐.. if 쓸 수 있는 형태에선 다 쓰겄징..
var count = 1

while true {
    guard count < 3 else {
        break
    }
    print(count)
    count += 1
}
// 1
// 2
//MARK: dictionary 같은 것을 받아왔을 때 굉~장히 많이 씁니다.
func someFunction(info: [String: Any]) {
    guard let a = info["name"] as? String else{
        return
    } 
    guard let b = info["age"] as? Int, b >= 0 else{
        return
    }
    print("내 이름은 \(a)고, 나이는 \(b)살이다.")
}

someFunction(info: ["name": "hyeonsoo", "age": 25])
someFunction(info: ["name": "hyeonsoo"]) // 출력없음.
someFunction(info: ["name": "hyeonsoo", "age": "25"]) // 출력없음.


<26강. 프로토콜; protocol>

//프로토콜은 특정 역할을 수행하기 위한 
//메서드, 프로퍼티, 이니셜라이저 등을 요구하는 기능.
//쉽게말하면, 어떤 타입 그 구조체나 클래스나 열거형에다가 
//"너는 이 기능이 꼭 필요해", "이 기능을 꼭 구현해 놨어야해"이렇게 강요하는 것.

/*어떤 타입이 '아 난 이 기능을 수행할거야'하고 어떤 프로토콜을 내가 구현을 할거에요 하는 것을 '채택(Adopted)'이라함.
그 구현해놓은 것을 준수한다. */

//MARK: -정의 문법

/*
protocol 프로토콜 이름 {
    정의부
}
*/

protocol Talkable { //어떤 특정타입에 이게 채택이 되었을 때 그 타입은 아래와 같은 프로퍼티, 메서드, 이니셜라이저를 꼭 구현을 해야한다는 뜻.
    // 프로퍼티 요구
    // 프로퍼티 요구는 항상 var 키워드를 사용합니다. 
    // get은 읽기만 가능해도 상관 없다는 뜻이며
    // get과 set을 모두 명시하면
    // 읽기 쓰기 모두 가능한 프로퍼티여야 합니다. 
    var topic: String { get set }
    var language: String { get } 

    //메서드 요구
    func talk()  //구현부가 없는 이유: 프로토콜에서는 구현을 직접하는것이아니라 이런 메소드가 필요해요~라고 말만하는 것.

    //이니셜라이저 요구
    init(topic: String, language: String)
}

struct Person: Talkable {
    var topic: String
    let language: String // 읽기만 가능해도 상관없다고 했으니 let, var 둘 다 가능함.

    // 위의 저장 프로퍼티들은 연산 프로퍼티로 대체할 수 있습니다. 
    // var language: String { return "한국어"}} //get은 생략가능.

    // var subject: String = ""
    // var topic: String { // 실질적인 값은 subject에 저장된다. topic은 결과를 보여주는 인터페이스 느낌이라 이해하기.
    //     set {
    //         self.subject = newValue
    //     }
    //     get {
    //         return self.subject
    //     }
    func talk() {
        print("\(topic)에 대해 \(language)로 말합니다.")
    }
    init(topic: String, language: String) {
        self.topic = topic
        self.language = language
    }
}

//MARK: - 프로토콜 상속
// 프로토콜은 클래스와 다르게 다중상속이 가능하다. 

// protocol 프로토콜 이름: 부모 프로토콜 이름 목록 {
//     정의부
// }

protocol Readable {
    func read()
}
protocol Writeable {
    func write()
}
protocol ReadSpeakable: Readable {
    //func read() 안써줘도 상속해왔으니 자동으로 들어가있는 거임. 
    func speak()
}
protocol ReadWriteSpeakable: Readable, Writeable {
    func speak()
}

struct SomeType: ReadWriteSpeakable {
    func read() {
        print("read")
    }
    func write() {
        print("write")
    }
    func speak() {
        print("speak")
    }
}

//MARK: 클래스 상속과 프로토콜

//클래스에서 상속과 프로토콜 채택을 동시에 하려면
//상속받으려는 클래스를 먼저 명시하고
//그 뒤에 채택할 프로토콜 목록을 작성합니다. 
class SuperClass: Readable {
    func read() { print("read") }
}

class SubClass: SuperClass, Writeable, ReadSpeakable {
    func write() { print("write") }
    func speak() { print("speak") }
}

//MARK:-프로토콜 준수 확인
//인스턴스가 특정 프로토콜을 준수하는지 확인할 수 있습니다. 
// is, as 연산자 사용

let sup: SuperClass = SuperClass()
let sub: SubClass = SubClass()

var someAny: Any = sup
someAny is Readable //true

if let someReadable: Readable = someAny as? Readable { //리더블한 썸애니를 할당하는 것. 
    someReadable.read()
} // read

if let someReadSpeakable: ReadSpeakable = someAny as? ReadSpeakable { //썸애니가 리드스피커플하지 않으니까 할당이 안되는 것
    someReadSpeakable.speak()
} //동작하지 않음.



