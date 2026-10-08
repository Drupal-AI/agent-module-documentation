# Diff Plus — agent index

Opinionated extensions to the contrib **Diff** module (revision comparison). Requires `diff` ^2.0 and
`caxy/php-htmldiff`. Adds two diff layout plugins, a refreshed diff header, and per-user settings. No
Drush, no new front-end route (access inherited from Diff's revision routes). Provides one permission
and a config schema.

- **Both settings forms (site default + per-user), every settings key, defaults, storage** →
  [configure/settings.md](configure/settings.md)
- **The two diff layout plugins (`raw_html`, `visual_inline_html5`): how to select them, what they do,
  the CDN assets and raw-HTML handling** → [plugins/layouts.md](plugins/layouts.md)
- **Permissions and how settings merge (default vs personalized)** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Config object `diff_plus.settings`; site-default form route `diff_plus.default_settings`
  (`/admin/config/content/diff_plus/settings/default`, perm `administer site configuration`);
  per-user form route `diff_plus.user_settings` (`/admin/config/content/diff_plus/settings`, perm
  `personalize diff plus settings`, stored in `user.data`).
- Diff layouts `raw_html` and `visual_inline_html5` are chosen in the Diff module's own settings
  (`admin/config/content/diff/settings`, "Layout plugins").
- `DiffControllerAlterSubscriber` (KernelEvents::VIEW) swaps the diff header for `#theme` `diff_plus_ui`
  when `enhance_diff_ui` is on. Two theme negotiators force the default theme on the two diff routes.
- Raw-HTML diff loads `diff2html`, `jsdiff`, `js-beautify`, `highlight.js` from external CDNs.
