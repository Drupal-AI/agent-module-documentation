# TacJS — agent index

Integrates the tarteaucitron.js cookie-consent library into Drupal. Renders a consent banner on
non-admin pages and blocks third-party services until the visitor opts in. All state is the
`tacjs.settings` config object. Requires the `tarteaucitronjs` JS library in
`web/libraries/tarteaucitronjs` (checked by `hook_requirements`).

- **Config: the three admin forms, `tacjs.settings` structure, drush config, library install** →
  [configure/settings.md](configure/settings.md)
- **Add custom tarteaucitron services / service content from a module** →
  [hooks/alter.md](hooks/alter.md)
- **The `administer tacjs` permission** →
  [permissions/permissions.md](permissions/permissions.md)

Submodules (documented separately, nested under this project):
- `tacjs_log` — stores proof of consent to a DB table and shows an overview report.
- `tacjs_media` — consent-aware oEmbed field formatter (`tacjs_oembed`) for remote video.

Key facts:
- Configure route (default): `tacjs.manage_dialog` → `/admin/config/system/tacjs/manage-dialog`.
- Config object `tacjs.settings`: `enabled` (bool), `dialog` (mapping of banner options),
  `services` (sequence keyed by service name, each with a `status` bool), `texts` (mapping of
  banner strings), `active` (generate + suffix), `expire`, `user`.
- `tacjs_page_attachments()` only fires on non-admin routes and only when `enabled` is TRUE; it
  pushes `dialog`, active `services`, `texts`, `user`, `expire` into `drupalSettings.tacjs`.
