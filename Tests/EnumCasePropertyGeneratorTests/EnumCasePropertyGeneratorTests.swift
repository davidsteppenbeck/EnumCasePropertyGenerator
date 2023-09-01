import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

// Macro implementations build for the host, so the corresponding module is not available when cross-compiling. Cross-compiled tests may still make use of the macro itself in end-to-end tests.
#if canImport(EnumCasePropertyGeneratorMacros)
import EnumCasePropertyGeneratorMacros

let testMacros: [String: Macro.Type] = [
    "EnumCasePropertyGenerator": EnumCasePropertyGeneratorMacro.self,
]
#endif

final class EnumCasePropertyGeneratorTests: XCTestCase {
    
    func testEnumCasePropertyGenerator() throws {
        #if canImport(EnumCasePropertyGeneratorMacros)
        assertMacroExpansion(
            """
            @EnumCasePropertyGenerator
            enum Fruit {
                case apple, banana
                case dragonFruit
            }
            """,
            expandedSource:
            """
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
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    
    func testEnumIdentifiableOnStruct() throws {
        #if canImport(EnumCasePropertyGeneratorMacros)
        assertMacroExpansion(
            """
            @EnumCasePropertyGenerator
            struct Fruit {
            }
            """,
            expandedSource:
            """
            struct Fruit {
            }
            """,
            diagnostics: [
                DiagnosticSpec(message: "'@EnumCasePropertyGenerator' can only be applied to an 'enum'", line: 1, column: 1)
            ],
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    
}
