# Hotjar — agent index

Injects the Hotjar analytics JS snippet into every page (subject to page/role visibility).
Config UI at `/admin/config/system/hotjar`, config object `hotjar.settings`, permission
`administer hotjar`. Three services, four alter/access hooks. No plugins, no Drush.

- **Settings form, every `hotjar.settings` key, page & role visibility rules, attachment
  modes, the permission** → [configure/settings.md](configure/settings.md)
- **The services (`hotjar.settings`, `hotjar.snippet`, `hotjar.access`) and how the snippet
  is built and attached** → [api/services.md](api/services.md)
- **Hooks to veto tracking, alter settings/ID, or wrap the script** →
  [hooks/hooks.md](hooks/hooks.md)

Key facts:
- Config UI route: `hotjar.admin_settings_form` (`/admin/config/system/hotjar`).
- Permission: `administer hotjar`.
- No output until `hotjar.settings.account` (the Hotjar ID / `hjid`) is set.
- `visibility_pages`: `0` = all pages except `pages`, `1` = only `pages`, `2` = none.
- `attachment_mode`: `build` (default, file at `snippet_path`) or `drupal_settings`.
- Snippet emitted from `hook_page_attachments()`; access decided by `hotjar.access`.
