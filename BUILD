cc_library(
    name = "lib",
    srcs = ["lib.cpp"],
    hdrs = ["lib.hpp"],
)

cc_shared_library(
    name = "lib_shared",
    deps = [":lib"],
)

# This library declares a dependency on the cc_shared_library
cc_binary(
    name = "test",
    srcs = ["test.cpp"],
    deps = [":lib"],
    dynamic_deps = [":lib_shared"],
)

# Whereas this one doesn't
cc_binary(
    name = "test2",
    srcs = ["test.cpp"],
    deps = [":lib"],
)

