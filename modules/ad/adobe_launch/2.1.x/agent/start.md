# Adobe Launch Snippet Manager — agent index

Injects an Adobe Launch (Adobe Experience Platform tag management) `<script>` into the page `<head>` via
`hook_preprocess_html`, with per-environment URLs and path include/exclude rules.

- **Settings keys, path rules, the data-layer library, the alter hook** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Config UI route is **`adobe_launch.config`** → `/admin/config/services/adobe_launch/configure`
  (permission `administer site configuration`). NOTE: `info.yml`'s `configure:` value
  (`adobe_dtm.settings_form`) is stale and does not resolve — use the route above.
- Config `adobe_launch.settings`: `adobe-launch-enable`, `target-adobe-launch-environment`
  (`dev|staging|prod`), `adobe-launch-async`, `init-js-array`, `adobe-launch-{prod,staging,dev}-url`,
  `adobe-launch-registrant`, `paths`, `paths_negate` (1=exclude, 0=include).
- Default `paths` excludes `/admin`, `/admin/*`, `/node/*/edit`.
- Library `adobe_launch/adobe_launch` loads `js/adobe_launch_dtm_init.js` (data-layer initializer) when
  `init-js-array` is on. Alter hook: `hook_adobe_launch_path_check_alter(&$result)`.
- No permissions, plugins, or Drush of its own.
