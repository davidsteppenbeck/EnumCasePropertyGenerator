import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct EnumCasePropertyGeneratorMacro: MemberMacro {
    
    public static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        guard let enumDecl = declaration.as(EnumDeclSyntax.self) else {
            throw EnumCasePropertyGeneratorError.notAnEnum
        }
        
        let cases = enumDecl.memberBlock.members.compactMap {
            $0.decl.as(EnumCaseDeclSyntax.self)
        }
        
        return try cases.flatMap(\.elements).map {
            let name = $0.name
            let text = name.text
            
            guard let firstLetterCap = text.capitalized.first else {
                throw EnumCasePropertyGeneratorError.caseNameMustContainAtLeastOneLetter
            }
            
            return """
            var \(raw: "is\(firstLetterCap)\(text.dropFirst())"): Bool {
                return self == .\(name)
            }
            """
        }
    }
    
}

enum EnumCasePropertyGeneratorError: Error, CustomStringConvertible {
    case notAnEnum
    case caseNameMustContainAtLeastOneLetter
    
    var description: String {
        switch self {
        case .notAnEnum:
            return "'@EnumCasePropertyGenerator' can only be applied to an 'enum'"
        case .caseNameMustContainAtLeastOneLetter:
            return "'enum' case names must contain at least one letter"
        }
    }
}

@main
struct EnumCasePropertyGeneratorPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        EnumCasePropertyGeneratorMacro.self,
    ]
}
