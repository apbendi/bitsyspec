import Foundation

func main(args args:[String]) {
    let (bitsyBin, specPath) = process(args: args)
    if let spec = Spec(filePath: specPath) {
        let result = spec.run(withBitsy: bitsyBin)
        print(result)
    }
}

func process(args args:[String]) -> (String, String) {
    guard args.count == 3 else {
        usage()
        exit(-1)
    }

    return (args[1], args[2])
}

func usage() {
    print("Usage:\n\t$ runbitsy $PATH_TO_BITSY_BIN $SPEC")
}

main(args: Process.arguments)