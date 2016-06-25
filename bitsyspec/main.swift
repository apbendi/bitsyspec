import Foundation

func main(args args:[String]) {
    let (bitsyBin, specPath) = process(args: args)

    guard let directory = NSFileManager.defaultManager().enumeratorAtPath(specPath) else {
        print("Directory not found: \(specPath)")
        exit(-1)
    }

    directory.forEach { element in
        guard let fileName = element as? String where fileName.hasSuffix("bitsy") else {
            return
        }

        let fullPath = specPath.hasSuffix("/") ? specPath + fileName : specPath + "/" + fileName
        let spec = Spec(filePath: fullPath)
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