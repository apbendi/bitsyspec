import Foundation

struct Spec {

    let expected: String
    let specPath: String

    init?(filePath: String) {
        guard let regExp = try? NSRegularExpression(pattern: "^.+\\.bitsy$", options: .CaseInsensitive),
            _ = regExp.firstMatchInString(filePath, options: [], range: NSMakeRange(0, filePath.characters.count)) else {

            print("Not a bitsy file: \(filePath)")
            return nil
        }

        guard let bitsyCode = try? NSString(contentsOfFile: filePath, encoding: NSUTF8StringEncoding) as String,
            expectedOutput = Spec.extractExpected(fromCode: bitsyCode) else {
                print("Could not determine expected output for spec at: \(filePath)")
                return nil
        }


        self.specPath = filePath
        self.expected = expectedOutput
    }

    func run(withBitsy bitsyBin: String) -> String {
        let output = Shell.exec(cmd: "\(bitsyBin) \(specPath)")

        if output == expected {
            return "SUCCESS"
        } else {
            return "FAILURE"
        }
    }
}

private extension Spec {

    static let CommentLabel = "{Expected Output:\n"

    static func extractExpected(fromCode code: String) -> String? {
        var index = code.startIndex

        while index < CommentLabel.endIndex {
            guard index < code.endIndex && code[index] == CommentLabel[index] else {
                return nil
            }

            index = index.successor()
        }

        var expected = ""

        while code[index] != "}" {
            expected += String(code[index])
            index = index.successor()
        }
        
        return expected
    }
}