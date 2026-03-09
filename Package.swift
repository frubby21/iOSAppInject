// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "iOSAppInject",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(name: "iOSAppInject", targets: ["iOSAppInject"])
    ],
    targets: [
        .target(
            name: "iOSAppInject",
            path: "."  // This tells the computer to look EVERYWHERE in the folder
        )
    ]
)