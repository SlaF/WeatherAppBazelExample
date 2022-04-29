""" Consume an Apple XCFramework. """

load(
    "@build_bazel_rules_apple//apple:apple.bzl",
    "apple_dynamic_framework_import"
)

def apple_dynamic_xcframework_import(name, **kwargs):
    xcframework_path = "Carthage/Build/{name}.xcframework".format(name = name)
    simulator_framework_path = "{xcframework_path}/ios-arm64_i386_x86_64-simulator/{name}.framework/**".format(name = name, xcframework_path = xcframework_path)
    device_framework_path = "{xcframework_path}/ios-arm64_armv7/{name}.framework/**".format(name = name, xcframework_path = xcframework_path)

    apple_dynamic_framework_import(
        name = name,
        framework_imports = select({
            "@build_bazel_rules_apple//apple:ios_sim_arm64": native.glob(include=[
                 simulator_framework_path
            ]),
            "@build_bazel_rules_apple//apple:ios_arm64": native.glob(include=[
                 device_framework_path
            ])
        }),
        visibility = ["//visibility:public"],
        **kwargs
    )
