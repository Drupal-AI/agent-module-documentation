# Copy Prevention — agent index

Client-side deterrents against copying text/images. Settings form
`copyprevention.settings_form` at `/admin/config/user-interface/copyprevention`
(permission `administer copy prevention`). All options OFF by default. State lives entirely in the
config object `copyprevention.settings`.

- **Config keys, form options, robots.txt / header behavior, drush** →
  [configure/settings.md](configure/settings.md)
- **The two permissions** → [permissions/permissions.md](permissions/permissions.md)

Notes:
- Applied via `hook_preprocess_html()` (body attributes), `hook_page_attachments()` (JS settings,
  meta tag, HTTP header) and `hook_robotstxt()` (image Disallow rules — needs the RobotsTxt module).
- `_copyprevention_is_enabled()` returns FALSE for users with `bypass copy prevention`, and invokes
  `hook_copyprevention_enable_alter(&$enable)` so other modules can switch it off contextually.
- Deterrents only — view-source, devtools and direct image URLs still work.
