Submodule of File Replace that runs a single configurable shell command every time a file is replaced, via `hook_file_replace()`. Useful for post-replacement automation such as re-optimizing assets, syncing to another server, or invalidating an external cache.

---

`file_replace_shell_exec` implements `hook_file_replace()` and, whenever File Replace overwrites a file, reads the string in the `command` key of config object `file_replace_shell_exec.settings` and runs it through PHP's `shell_exec()`. If the command produces output it is logged at *info* level (with the command and its output) to the `file_replace_shell_exec` logger channel; if it produces no output the module logs an *error* saying the command could not be executed. The command is empty by default (`command: ''`), so nothing runs until you set it. There is **no settings form and no config schema** — you set the command with `drush config:set file_replace_shell_exec.settings command '…'` (or config import). The command is executed verbatim on the web server with the privileges of the web/PHP user and does **not** receive the replaced file as an argument, so this is a powerful, security-sensitive feature that should only be enabled on trusted sites with a carefully controlled command. Depends on `file_replace` (and therefore core `file`).

---

- Re-optimize or compress an image on disk after it is replaced (e.g. call an external optimizer).
- Sync the replaced file's directory to a remote server or backup location after each replace.
- Invalidate or purge an external/CDN cache by running a CLI purge command post-replacement.
- Trigger a deployment or rebuild hook when a managed asset changes.
- Run a virus/malware scan command over the files directory after a replacement.
- Regenerate a static export or search index that depends on the replaced file.
- Send a notification from the shell (e.g. a webhook curl call) whenever a file is replaced.
- Recompute checksums or update an external manifest after a file swap.
- Kick off a thumbnail/derivative generation pipeline handled by an external tool.
- Touch a marker file or write a timestamp so other processes know a replacement happened.
- Copy the new file into a separate public mirror directory.
- Run a `git commit`/`git push` of a version-controlled assets directory after a replace (trusted setups only).
- Restart or reload a downstream service that caches the file.
- Log replacements to an external system via a CLI client.
- Chain any custom shell automation to the File Replace workflow without writing a module.
