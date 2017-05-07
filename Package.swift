// swift-tools-version:3.1

import PackageDescription

let package = Package(
    name: "shed",
    dependencies: [
        .Package(url: "https://github.com/Quick/Quick", majorVersion: 1, minorVersion: 0)
    ]
)
