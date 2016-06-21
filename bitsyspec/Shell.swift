import Foundation

struct Shell {
    func exec(cmd cmdname: String) -> String {
        var outstr = ""
        let task = NSTask()
        task.launchPath = "/bin/sh"
        task.arguments = ["-c", cmdname]

        let pipe = NSPipe()
        task.standardOutput = pipe
        task.launch()

        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        if let output = NSString(data: data, encoding: NSUTF8StringEncoding) {
            outstr = output as String
        }

        task.waitUntilExit()
        
        return outstr
    }
}