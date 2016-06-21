import Foundation

func main(args args:[String]) {
    let bitysBin = process(args: args)
}

func process(args args:[String]) -> String {
    guard args.count > 1 else {
        usage()
        exit(-1)
    }

    return args[1]
}

func usage() {
    print("Usage:\n\t$ runbitsy $PATH_TO_BITSY_BIN")
}

main(args: Process.arguments)