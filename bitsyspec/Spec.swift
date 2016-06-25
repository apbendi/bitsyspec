import Foundation

struct Spec {
    let specPath: String
    let expected: String
    let description: String
    let warning: String?

    init(filePath: String) {
        guard let regExp = try? NSRegularExpression(pattern: "^.+\\.bitsy$", options: .CaseInsensitive),
            _ = regExp.firstMatchInString(filePath, options: [], range: NSMakeRange(0, filePath.characters.count)) else {

            self.warning = "Not a bitsy file: \(filePath)"
            self.specPath = ""
            self.expected = ""
            self.description = ""

            return
        }

        guard let bitsyCode = try? NSString(contentsOfFile: filePath, encoding: NSUTF8StringEncoding) as String,
            (description, expected) = Spec.extractExpected(fromCode: bitsyCode) else {
                self.warning = "Malformed spec definition comment in: \(filePath)"
                self.specPath = ""
                self.expected = ""
                self.description = ""

                return
        }

        self.specPath = filePath
        self.expected = expected
        self.description = description
        self.warning = nil
    }

    func run(withBitsy bitsyBin: String) -> String {
        if let warning = warning {
            return "⚠️  \(warning)"
        }

        let output = Shell.exec(cmd: "\(bitsyBin) \(specPath)")

        if output == expected {
            return "✅  \(description)"
        } else {
            return "❌  \(description) -> Expected '\(expected)' got '\(output)'".replacing(char: "\n", with: "\\n")
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

            index = index.successor()
        }

        var description = ""

        while code[index] != "\"" {
            description += String(code[index])
            index = index.successor()
        }

        index = index.successor()
        guard code[index] == "\n" else {
            return nil
        }
        index = index.successor()

        var expected = ""

        while code[index] != "}" {
            expected += String(code[index])
            index = index.successor()
        }
        
        return (description, expected)
    }
}

private extension String {
    func replacing(char char: Character, with replacement: String) -> String {
        var index = self.startIndex
        var new = ""

        while index < self.endIndex {
            if self[index] == char {
                new += replacement
            } else {
                new += String(self[index])
            }

            index = index.successor()
        }

        return new
    }
}