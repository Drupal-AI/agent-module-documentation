# file_replace — agent start

Replaces the **contents** of an existing managed file (`file_managed`) with a new upload while
keeping the file URI, filename, and file entity ID unchanged, so existing links/embeds keep
working. Adds a "Replace" form at `/admin/content/files/replace/{file}` (route
`entity.file.replace_form`). No settings form and no config entities — depends only on core `file`.
Ships one submodule, `file_replace_shell_exec`.

- Who may replace files and the permanent-file constraint → [permissions/file_replace.md](permissions/file_replace.md)
- How to expose the replace link (route, entity operation, Views field, manual link) → [configure/file_replace.md](configure/file_replace.md)
- The invited `hook_file_replace()` extension point and replace behavior → [api/file_replace.md](api/file_replace.md)
- Submodule that runs a shell command on replace → ../../modules/file_replace_shell_exec/1.5.x/agent/start.md
