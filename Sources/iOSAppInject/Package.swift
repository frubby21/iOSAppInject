// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "iOSAppInject",
    platforms: [.iOS(.v16)],
    products: [
        .executable(name: "iOSAppInject", targets: ["iOSAppInject"])
    ],
    targets: [
        .executableTarget(
            name: "iOSAppInject",
            path: "Sources/iOSAppInject"
        )
    ]
)