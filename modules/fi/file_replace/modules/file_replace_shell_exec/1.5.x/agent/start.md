# file_replace_shell_exec — agent start

Submodule of **file_replace**. Implements `hook_file_replace()` to run one configurable shell command
(via PHP `shell_exec()`) every time a file is replaced. Output is logged to the
`file_replace_shell_exec` channel (info if there is output, error if none). No settings form, no
config schema, no permissions — the command lives in config `file_replace_shell_exec.settings:command`
(empty by default). Requires `file_replace`. Part of project: `file_replace`.

- Set the command, logging behavior, and the security caveats → [configure/file_replace_shell_exec.md](configure/file_replace_shell_exec.md)
