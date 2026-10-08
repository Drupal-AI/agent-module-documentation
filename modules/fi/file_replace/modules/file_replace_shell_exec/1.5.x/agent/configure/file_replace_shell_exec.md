# file_replace_shell_exec — configure

No settings form and no config schema ship with this submodule. Configuration is a single key in the
config object `file_replace_shell_exec.settings`:

| Key | Default | Meaning |
|---|---|---|
| `command` | `''` (empty) | Shell command string run verbatim through PHP `shell_exec()` after every file replacement. Empty = do nothing. |

## Set the command

```bash
drush config:set file_replace_shell_exec.settings command 'your-command --here'
```

Or via `drush config:edit file_replace_shell_exec.settings`, or a config-import YAML:

```yaml
# file_replace_shell_exec.settings.yml
command: 'your-command --here'
```

## Behavior on replace

- On each replacement, `hook_file_replace()` reads `command`; if empty it returns and does nothing.
- Otherwise it runs `shell_exec($command)`:
  - **Output present** → logged at *info* to the `file_replace_shell_exec` logger channel, including
    the command and its output (in a `<pre>`).
  - **No output** → logged at *error*: "The command %command could not be executed."
- The command is **not** passed the replaced file or its URI as an argument.

## Security

The command runs on the web server as the PHP/web user with whatever privileges that account has, and
is stored in plain config. Treat this as a remote-code-execution surface: only enable on trusted
sites, restrict who can edit configuration, and keep the command fixed and audited.
