// swift-tools-version:5.3

import PackageDescription

let projectName = "bitsyspec"

let package = Package(
    name: projectName,
    targets: [
        .target(
            name: projectName,
            path: projectName
        ),
    ]
)
