import Foundation

struct Shell {
    static func exec(cmd cmdname: String) -> String {
        var outstr = ""
        let task = Process()
        task.launchPath = "/bin/sh"
        task.arguments = ["-c", cmdname]

        let pipe = Pipe()
        task.standardOutput = pipe
        task.launch()

        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        if let output = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
            outstr = output as String
        }

        task.waitUntilExit()
        
        return outstr
    }
}
