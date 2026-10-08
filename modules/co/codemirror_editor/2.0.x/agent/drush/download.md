# Drush: download the CodeMirror library

The module registers one Drush command (`drush.services.yml` →
`CodeMirrorEditorCommands`).

## `codemirror:download` (alias `codemirror-download`)

Downloads the CodeMirror JS/CSS library into the site's `libraries/codemirror` directory so
the module can self-host it instead of loading from a CDN.

```bash
drush codemirror:download
```

Use it when you set `codemirror_editor.settings` `cdn` to `false` (self-hosted). The command
uses `library.discovery` to find the expected library, the HTTP client to fetch it, and the
JS/CSS collection optimizers; it writes to the file system via `@file_system`.

## When you need it

- `cdn: false` in `codemirror_editor.settings` (see `configure/settings.md`).
- The runtime requirements check (`hook_requirements`) reports the CodeMirror library missing
  — it only checks the local `libraries/codemirror` path when CDN is off.

If you keep `cdn: true` (the default) you do not need to download anything.
