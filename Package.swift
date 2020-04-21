// swift-tools-version:5.2
import PackageDescription

let package = Package(
    name: "S3Kit",
    platforms: [
       .macOS(.v10_15)
    ],
    products: [
        .library(name: "S3Kit", targets: ["S3Kit"]),
        .library(name: "S3Signer", targets: ["S3Signer"]),
//        .library(name: "S3TestTools", targets: ["S3TestTools"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-nio.git", from: "2.5.0"),
        .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0-alpha.3"),
        .package(url: "https://github.com/vapor/open-crypto.git", from: "4.0.0-alpha.2"),
        .package(url: "https://github.com/swift-server/async-http-client.git", from: "1.0.0-alpha.2"),
        .package(url: "https://github.com/Einstore/HTTPMediaTypes.git", from: "0.0.1"),
        .package(name: "WebError", url: "https://github.com/Einstore/WebErrorKit.git", from: "0.0.1"),
        .package(url: "https://github.com/LiveUI/XMLCoding.git", from: "0.1.0")
    ],
    targets: [
        .target(
            name: "S3Kit",
            dependencies: [
                "S3Signer",
                .product(name: "AsyncHTTPClient", package: "async-http-client"),
                "HTTPMediaTypes",
                "XMLCoding"
            ]
        ),
        .target(
            name: "S3Provider",
            dependencies: [
                .product(name: "Vapor", package: "vapor"),
                "S3Kit"
            ]
        ),
        .target(
            name: "S3DemoRun",
            dependencies: [
                .product(name: "Vapor", package: "vapor"),
                "S3Provider"
            ]
        ),
        .target(
            name: "S3Signer",
            dependencies: [
                .product(name: "OpenCrypto", package: "open-crypto"),
                .product(name: "NIOHTTP1", package: "swift-nio"),
                "HTTPMediaTypes",
                .product(name: "WebErrorKit", package: "WebError")
            ]
        ),
//        .target(name: "S3TestTools", dependencies: [
//            "Vapor",
//            "S3Kit"
//            ]
//        ),
        .testTarget(name: "S3Tests", dependencies: [
            "S3Kit"
            ]
        )
    ]
)
