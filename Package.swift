import PackageDescription

let package = Package(
    name: "overlook",
    targets: [
      Target(name: "overlook", dependencies: ["watch", "config", "cli", "task", "env"]),
      Target(name: "watch"),
      Target(name: "config", dependencies: ["json"]),
      Target(name: "json"),
      Target(name: "cli"),
      Target(name: "task"),
      Target(name: "env"),
    ],

    dependencies: [
        .Package(url: "https://github.com/kylef/PathKit.git",   majorVersion: 0, minor: 7),
    ]
)
