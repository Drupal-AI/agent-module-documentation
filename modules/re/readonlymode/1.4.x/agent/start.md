# Read Only Mode — agent index

Blocks (almost) all form submissions site-wide while keeping the site readable — an alternative
to core Maintenance Mode. All state is in the `readonlymode.settings` config object; the UI is a
"Read Only Mode" section grafted onto the core Maintenance mode form
(`system.site_maintenance_mode` at `/admin/config/development/maintenance`). No Drush.

- **Turn it on, allow specific forms, set redirect/messages (config keys + how the lock works)** →
  [configure/read-only-mode.md](configure/read-only-mode.md)
- **The two permissions it defines and what they gate** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts:
- `readonlymode.settings`: `enabled` (0/1), `url` (redirect path), `messages.default`,
  `messages.not_saved`, `forms.default.edit`/`forms.default.view` (shipped allow-lists),
  `forms.additional.edit`/`forms.additional.view` (newline-separated form IDs, `*` wildcards).
- Permissions: `readonlymode access forms` (bypass the lock), `readonlymode access messages`
  (see notices/warnings).
- Also ships a block plugin `readonlymode_block`.
