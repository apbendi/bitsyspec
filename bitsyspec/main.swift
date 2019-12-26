import Foundation

func main(arguments args:[String]) {
    let (bitsyBin, specPath) = process(arguments: args)

    let allSpecs = specs(atPath: specPath)

    guard allSpecs.count > 0 else {
        print("No specs found at \(specPath)")
        exit(EX_DATAERR)
    }

    allSpecs.forEach { spec in
        let result = spec.run(withBitsy: bitsyBin)
        print(result)
    }
}

func process(arguments args:[String]) -> (bitsyBin: String, specPath: String) {
    guard args.count == 3 else {
        usage()
    }

    return (args[1], args[2])
}


func usage() -> Never  {
    print("usage: bitsyspec bitsy_path spec_path")
    print("       run spec(s) at spec_path using bitsy implementation at bitsy_path")
    exit(EX_USAGE)
}

func directory(atPath path:String) -> FileManager.DirectoryEnumerator? {
    return FileManager.default.enumerator(atPath: path)
}

func specs(atPath path:String) -> [Spec] {
    if path.isValidBitsyPath {
        return [Spec(filePath: path)]
    }


    return specs(inDirectory: path)
}

func specs(inDirectory dirPath:String) -> [Spec] {
    guard let directory = directory(atPath: dirPath) else {
        print("Directory not found: \(dirPath)")
        exit(EX_DATAERR)
    }

    return directory.compactMap { element in
        guard let fileName = element as? String , fileName.isValidBitsyPath else {
            return nil
        }

        let fullPath = dirPath.hasSuffix("/") ? dirPath + fileName : dirPath + "/" + fileName
        return Spec(filePath: fullPath)
    }
}

main(arguments: CommandLine.arguments)
