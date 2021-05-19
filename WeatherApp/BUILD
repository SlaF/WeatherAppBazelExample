load("@build_bazel_rules_apple//apple:ios.bzl", "ios_application")
load("@build_bazel_rules_apple//apple:apple.bzl", "apple_dynamic_framework_import")
load("@build_bazel_rules_apple//apple:versioning.bzl", "apple_bundle_version")
load("@build_bazel_rules_apple//apple:resources.bzl", "apple_resource_bundle")
load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")
load("BazelMacros/import_xcframework.bzl", "apple_dynamic_xcframework_import")

# apple_dynamic_framework_import(
#     name = "Alamofire_X86",
#     framework_imports = glob(["Carthage/Build/Alamofire.xcframework/ios-arm64_i386_x86_64-simulator/Alamofire.framework/**"])
# )

# apple_dynamic_framework_import(
#   name = "Alamofire_Arm",
#   framework_imports = glob(["Carthage/Build/Alamofire.xcframework/ios-arm64_armv7/Alamofire.framework/**"])
# )

# apple_dynamic_framework_import(
#   name = "Kingfisher_x86",
#   framework_imports = glob(["Carthage/Build/Kingfisher.xcframework/ios-arm64_i386_x86_64-simulator/Kingfisher.framework/**"])
# )

# apple_dynamic_framework_import(
#   name = "Kingfisher_arm",
#   framework_imports = glob(["Carthage/Build/Kingfisher.xcframework/ios-arm64_armv7/Kingfisher.framework/**"])
# )

filegroup(
    name = "localized_strings",
    srcs = glob(["WeatherApp/Localisation/*.lproj/*.strings"]),
)

apple_dynamic_xcframework_import(
  name = "Kingfisher"
)

apple_dynamic_xcframework_import(
  name = "Alamofire"
)

swift_library(
    name = "WeatherAppSources",
    srcs = glob(
        ["WeatherApp/**/*.swift"]
    ),
    deps = [":Kingfisher", ":Alamofire"],
    module_name = "WeatherApp"
)

ios_application(
    name = "WeatherApp",
    bundle_id = "ru.devslaf.WeatherApp",
    families = ["iphone"],
    infoplists = ["WeatherApp/Info.plist"],
    minimum_os_version = "13.0",
    launch_storyboard = "WeatherApp/Base.lproj/LaunchScreen.storyboard",
    deps = [":WeatherAppSources"],
    frameworks = ["@//NetworkKit:NetworkKit"],
    app_icons = glob(["WeatherApp/Assets.xcassets/AppIcon.appiconset/*"]),
    strings = [":localized_strings"]
)
