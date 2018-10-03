load("//github.com/gogo/protobuf:compile.bzl",
  "gogo_proto_compile",
  "gogofast_proto_compile",
  "gogofast_grpc_compile")
load("@io_bazel_rules_go//go:def.bzl", "go_library")

def gogo_proto_library(**kwargs):
    name = kwargs.get("name")
    proto_deps = kwargs.pop("srcs")
    go_deps = kwargs.pop("deps", [])
    visibility = kwargs.get("visibility")

    name_pb = name + "_pb"

    gogo_proto_compile(
        name = name_pb,
        deps = proto_deps,
        visibility = visibility,
    )

    go_deps.append(
        "@com_github_gogo_protobuf//proto:go_default_library",
    )

    go_library(
        srcs = [name_pb],
        deps = go_deps,
        **kwargs
    )

def gogofast_proto_library(**kwargs):
    name = kwargs.get("name")
    deps = kwargs.get("deps")
    visibility = kwargs.get("visibility")

    name_pb = name + "_pb"

    gogofast_proto_compile(
        name = name_pb,
        deps = deps,
        visibility = visibility,
    )

    kwargs["deps"] = [
        "@com_github_gogo_protobuf//proto:go_default_library",
    ]

    go_library(
        srcs = [name_pb],
        **kwargs
    )


def gogofast_grpc_library(**kwargs):
    name = kwargs.get("name")
    deps = kwargs.get("deps")
    visibility = kwargs.get("visibility")

    name_pb = name + "_pb"

    gogofast_grpc_compile(
        name = name_pb,
        deps = deps,
        visibility = visibility,
    )

    kwargs["deps"] = [
        "@com_github_gogo_protobuf//proto:go_default_library",
        "@org_golang_google_grpc//:go_default_library",
        "@org_golang_x_net//context:go_default_library",
    ]

    go_library(
        srcs = [name_pb],
        **kwargs
    )
