// swift-tools-version:3.1

import PackageDescription

let package = Package(
    name: "shed",
    dependencies: [
        .Package(url: "https://github.com/ccorn90/Spec.git", majorVersion: 0),
        .Package(url: "https://github.com/ccorn90/Swift-Language-Mods.git", majorVersion: 1)
    ]
)
