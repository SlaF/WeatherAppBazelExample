# load(
#     "@build_bazel_rules_apple//apple:apple.bzl",
#     "apple_dynamic_framework_import"
# )

load("@build_bazel_rules_apple//apple:ios.bzl", "ios_dynamic_framework")
load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")

swift_library(
    name = "NetworkKitLib",
    srcs = glob(
        ["NetworkKit/*.swift"]
    ),
    generates_header = True,
    module_name = "NetworkKit"
)

ios_dynamic_framework(
    name = "NetworkKit",
    deps = [":NetworkKitLib"],
    bundle_id = "ru.devslaf.NetworkKit",
    bundle_name = "NetworkKit",
    infoplists = ["NetworkKit/Info.plist"],
    minimum_os_version = "13.0",
    families = ["iphone"],
    visibility = ["//visibility:public"]
)