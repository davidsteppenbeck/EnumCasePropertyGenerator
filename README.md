# EnumCasePropertyGenerator

`EnumCasePropertyGenerator` is a Swift macro for `enum` that provides automatic generation of computed properties for its cases.

## Usage

```swift
import EnumCasePropertyGenerator

@EnumCasePropertyGenerator
enum Fruit {
    case apple, banana
    case dragonFruit
}
```

This will automatically generate the following code:

```swift
enum Fruit {
    case apple, banana
    case dragonFruit
    
    var isApple: Bool {
        return self == .apple
    }
    
    var isBanana: Bool {
        return self == .banana
    }
    
    var isDragonFruit: Bool {
        return self == .dragonFruit
    }
}
```

## Installation

The package can be installed using [Swift Package Manager](https://swift.org/package-manager/). To add EnumIdentifiable to your Xcode project, select *File > Add Package Dependancies...* and search for the repository URL: `https://github.com/davidsteppenbeck/EnumCasePropertyGenerator`.

## License

EnumCasePropertyGenerator is available under the MIT license. See the LICENSE file for more info.
