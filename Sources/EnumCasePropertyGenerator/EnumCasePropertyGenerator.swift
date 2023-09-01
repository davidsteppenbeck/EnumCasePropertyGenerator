/// An attached macro for `enum` that provides a computed property for each case that checks whether or not the current instance is equal to that case.
/// Applying the macro to anything other than an `enum` will result in a compile time error.
///
/// Applying `@EnumCasePropertyGenerator` to an `enum`
///
///     @EnumCasePropertyGenerator
///     enum Fruit {
///         case apple, banana
///         case dragonFruit
///     }
///
/// results in the following code automatically
///
///     enum Fruit {
///         case apple, banana
///         case dragonFruit
///
///         var isApple: Bool {
///             return self == .apple
///         }
///
///         var isBanana: Bool {
///             return self == .banana
///         }
///
///         var isDragonFruit: Bool {
///             return self == .dragonFruit
///         }
///     }
@attached(member, names: arbitrary)
public macro EnumCasePropertyGenerator() = #externalMacro(module: "EnumCasePropertyGeneratorMacros", type: "EnumCasePropertyGeneratorMacro")
