# Enumeration(열거형)
- 연관된 상수들을 하나의 이름으로 묶은 자료형
- 열거형은 한정된 사례(case)로 만든 타입이고 switch문은 분기처리에 최적화 되어 있어서 활용에 적합
- **즉 열거형은 항상 switch문으로 분기처리 가능**

```swift
enum Rainbow: String {  // 대문자로 시작
    case red
    case orange
    case yellow
    case green
    case blue
    case indigo
    case purple
}

enum Rainbow {  // ,로 한꺼번에 정의 가능
    case red,orange,yellow,green,blue,indigo,purple
}

var color: Rainbow = Rainbow.red    // 변수에 넣어 사용할 때
var color = Rainbow.red             // 타입 생략해서 변수에 선언할 떄

color = .orange     // color안에 Rainbow라는 열거형 타입을 선언할 때 값이 들어갔으므로 다음부터 생략가능
type(of: color)     // Rainbow 타입은 Rainbow


// 열거형은 switch문으로 분기처리 가능

switch color {          // color에 Rainbow라는 열거형 타입이 선언이 되었어야 함
case Rainbow.red:       // fullName으로 사용 가능
    print("빨간색 입니다.")
case .orange:
    print("주황색 입니다.")
case .yellow:
    print("노란색 입니다.")
case .green:
    print("초록색 입니다.")
case .blue:
    print("파란색 입니다.")
case .indigo:
    print("남색 입니다.")
case .purple:
    print("보라색 입니다.")
}
```

## Default Values (열거형의 기본값)
- 원시값을 정의가능 (Hashable한 - String, Int, Double 등)
- 열거형이 선언 될 때 값이 저장됨
- 선언시에 정의된거기 때문에 case 값 변경 불가능
- 하나의 열거형에서 원시값과 연관값을 함께 사용하는 것은 불가능

```swift
enum Alignment: Int {
    case left   // 0 Int형으로 선언시 자동으로 숫자가 순서대로 값이 들어간다.
    case center // 1 고유값이 생긴다.
    case right  // 2
}
var align = Alignment(rawValue: 1)  // center


enum Alignment: String {
    case left   // left 똑같은 문자열로 생성되어 값이 들어간다.
    case center // center 
    case right  // right
}

var align = Alignment(RawValue:"left")
// 옵셔널로 반환되기 때문에 사용하려면 let 바인딩을 사용해야 한다.
```

## Accociated Values (열거형의 연관값)
- 튜플처럼 값의 이름과 타입을 선언해도 되고 타입만 선언해서 사용할수 있다.
- enum을 선언하고 **열거형 값을 생성할 때(인스턴스 생성 시) 메모리에 저장**
- 연관값은 저장을 따로 하기 때문에 유동적으로 값을 변경할 수 있음
- 하나의 열거형에서 원시값과 연관값을 함께 사용하는 것은 불가능

```swift
enum Fruit {    // 원시값을 넣지 않는다.
    case apple(color: String, price: Int)
}
// 저장
let redApple = Fruit.apple(color:"red", price: 2000)    // 메모리 저장
let greenApple = Fruit.apple(color:"green", price: 1000)
```

## 열거형과 Switch문의 활용
- 열거형은 한정된 case로 만든 타입이기 때문에 switch문 표현식에 대한 분기처리에 최적화 되어 있다
- ⭐️열거형을 사용할때는 대부분 switch문을 처리(사용)한다
```swift
enum Fruit: String {
    case apple
    case banana
    case cherry
}

var color = Fruit.apple // color에는 Fruit 타입이 들어 있다.

// case를 switch로 분기처리를 함
switch color {
case .apple:
    print("red")
case .banana:
    print("yellow")
case .cherry:
    print("red")
}
```