load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

#------------------------------------------------------------------------------
# rules_python {

# enable python rules
http_archive(
    name = "rules_python",
    sha256 = "778197e26c5fbeb07ac2a2c5ae405b30f6cb7ad1f5510ea6fdac03bded96cc6f",
    url = "https://github.com/bazelbuild/rules_python/releases/download/0.2.0/rules_python-0.2.0.tar.gz",
)

# Create a central repo that knows about the dependencies needed for
# requirements.txt.
load("@rules_python//python:pip.bzl", "pip_install")

pip_install(
    name = "my_python_deps",
    requirements = "//third_party:requirements.txt",
)
#}

#------------------------------------------------------------------------------
# rules_docker {
http_archive(
    name = "io_bazel_rules_docker",
    sha256 = "59d5b42ac315e7eadffa944e86e90c2990110a1c8075f1cd145f487e999d22b3",
    strip_prefix = "rules_docker-0.17.0",
    urls = ["https://github.com/bazelbuild/rules_docker/releases/download/v0.17.0/rules_docker-v0.17.0.tar.gz"],
)

# OPTIONAL: Call this to override the default docker toolchain configuration.
# This call should be placed BEFORE the call to "container_repositories" below
# to actually override the default toolchain configuration.
# Note this is only required if you actually want to call
# docker_toolchain_configure with a custom attr; please read the toolchains
# docs in /toolchains/docker/ before blindly adding this to your WORKSPACE.
# BEGIN OPTIONAL segment:
# load("@io_bazel_rules_docker//toolchains/docker:toolchain.bzl",
#     docker_toolchain_configure="toolchain_configure"
# )
# docker_toolchain_configure(
#   name = "docker_config",
#   # OPTIONAL: Path to a directory which has a custom docker client config.json.
#   # See https://docs.docker.com/engine/reference/commandline/cli/#configuration-files
#   # for more details.
#   client_config="<enter absolute path to your docker config directory here>",
#   # OPTIONAL: Path to the docker binary.
#   # Should be set explicitly for remote execution.
#   docker_path="<enter absolute path to the docker binary (in the remote exec env) here>",
#   # OPTIONAL: Path to the gzip binary.
#   gzip_path="<enter absolute path to the gzip binary (in the remote exec env) here>",
#   # OPTIONAL: Bazel target for the gzip tool.
#   gzip_target="<enter absolute path (i.e., must start with repo name @...//:...) to an executable gzip target>",
#   # OPTIONAL: Path to the xz binary.
#   # Should be set explicitly for remote execution.
#   xz_path="<enter absolute path to the xz binary (in the remote exec env) here>",
#   # OPTIONAL: List of additional flags to pass to the docker command.
#   docker_flags = [
#     "--tls",
#     "--log-level=info",
#   ],

# )
# End of OPTIONAL segment.

load(
    "@io_bazel_rules_docker//repositories:repositories.bzl",
    container_repositories = "repositories",
)

container_repositories()

load("@io_bazel_rules_docker//repositories:deps.bzl", container_deps = "deps")

container_deps()

load(
    "@io_bazel_rules_docker//container:container.bzl",
    "container_pull",
)

register_toolchains(
    "//tools/toolchains:container_usr_local_py_toolchain",
    # "@io_bazel_rules_docker//toolchains:container_py_toolchain",
)

register_execution_platforms(
    "@local_config_platform//:host",
    "@io_bazel_rules_docker//platforms:local_container_platform",
)

# doc at https://github.com/bazelbuild/rules_docker#container_pull-1
# samples at https://github.com/bazelbuild/rules_docker/blob/master/testing/examples/WORKSPACE
container_pull(
    # 'tag' is supported, but digest is encouraged for reproducibility.
    name = "python3_base",
    # registry = "registry.hub.docker.com",
    registry = "index.docker.io",
    repository = "library/python",
    tag = "3.9.5-buster",
    # tag = "3.9.5-slim-buster",
    # digest = "sha256:9fa920a5e22c494e2c879fee24f72ba0bb842b8e8e7376accd46b9b94e5fb7f1"
)

# # all the distroless image: https://console.cloud.google.com/gcr/images/distroless/GLOBAL
# container_pull(
#     name = "python3_base",
#     registry = "gcr.io",
#     repository = "distroless/python3-debian10",
#     #digest = "sha256:f6c3961ea6a177c21e31449e4833904e35434ba2038757771b0a2d3dc7958a31",
#     tag = "latest",
# )

# load(
#     "@io_bazel_rules_docker//python3:image.bzl",
#     _py3_image_repos = "repositories",
# )

# _py3_image_repos()

# }
