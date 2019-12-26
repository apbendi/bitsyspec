import Foundation

private typealias ValidSpec = (path: String, description: String, expected: String)

private enum SpecData {
    case warning(String)
    case valid(ValidSpec)
}

struct Spec {
    fileprivate let metadata: SpecData

    init(filePath: String) {
        guard filePath.isValidBitsyPath else {
            metadata = .warning("Not a bitsy file: \(filePath)")
            return
        }

        guard let bitsyCode = contents(ofFile: filePath) else {
            metadata = .warning("File not found: \(filePath)")
            return
        }

        guard let (description, expected) = Spec.extractExpected(fromCode: bitsyCode) else {
            metadata = .warning("Malformed spec definition comment in: \(filePath)")
            return
        }

        metadata = .valid((path: filePath, description: description, expected: expected))
    }

    func run(withBitsy bitsyBin: String) -> String {
        switch metadata {
        case .warning(let message):
            return "⚠️  \(message)"
        case .valid(let path, let description, let expected):
            let output = Shell.exec(cmd: "\(bitsyBin) \(path)")

            if output != expected {
                return "❌  \(description) -> Expected '\(expected)' got '\(output)'".replacing("\n", with: "\\n")
            }

            return "✅  \(description)"
        }
    }
}

private extension Spec {

    static let CommentLabel = "{ Description: \""

    static func extractExpected(fromCode code: String) -> (description: String, expected: String)? {
        var index = code.startIndex

        while index < CommentLabel.endIndex {
            guard index < code.endIndex && code[index] == CommentLabel[index] else {
                return nil
            }

            index = code.index(after: index)
        }

        var description = ""

        while code[index] != "\"" {
            description += String(code[index])
            index = code.index(after: index)
        }

        index = code.index(after: index)
        guard code[index] == "\n" else {
            return nil
        }
        index = code.index(after: index)

        var expected = ""

        while code[index] != "}" {
            expected += String(code[index])
            index = code.index(after: index)
        }
        
        return (description, expected)
    }
}

extension String {
    var isValidBitsyPath: Bool {
        guard let regExp = try? NSRegularExpression(pattern: "^.+\\.bitsy$", options: .caseInsensitive),
            let _ = regExp.firstMatch(in: self, options: [], range: NSMakeRange(0, characters.count)) else {
                return false
        }

        return true
    }
}

private extension String {
    func replacing(_ char: Character, with replacement: String) -> String {
        var index = self.startIndex
        var new = ""

        while index < self.endIndex {
            if self[index] == char {
                new += replacement
            } else {
                new += String(self[index])
            }

            index = self.index(after: index)
        }

        return new
    }
}

private func contents(ofFile filePath: String) -> String? {
    return try? NSString(contentsOfFile: filePath, encoding: String.Encoding.utf8.rawValue) as String
}
