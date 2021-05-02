"""Launch the python_check tool"""

def _python_check_test_impl(ctx):
    # TODO find a better way to build the command/script and to escape/enclose args
    args = ["--check"] + [f.path for f in ctx.files.srcs]
    command = "%s '%s'" % (ctx.executable.tool.short_path, "' '".join(args))

    # Write the file, it is executed by 'bazel test'.
    # ctx.outputs.executable is the default value for DefaultInfo.executable
    ctx.actions.write(
        output = ctx.outputs.executable,
        content = command,
    )

    # To ensure the files needed by the command are available, we put them in
    # the runfiles.
    runfiles = ctx.runfiles(files = ctx.files.srcs)
    runfiles = runfiles.merge(ctx.attr.tool[DefaultInfo].default_runfiles)
    return [DefaultInfo(
        runfiles = runfiles,
    )]

python_check_test = rule(
    implementation = _python_check_test_impl,
    attrs = {
        "srcs": attr.label_list(allow_files = True),
        "tool": attr.label(
            executable = True,
            cfg = "target",
            default = Label("//tools/python_check"),
        ),
    },
    test = True,
)
