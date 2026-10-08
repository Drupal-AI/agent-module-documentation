<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Node Access Rebuild Progressive — agent index

Rebuilds the node access grants table in chunks (default 500) instead of all at once, via a
resumable Drush command or on cron. Interruptible; tracks position in Drupal `state`.

- **Settings (`cron`, `chunk`), the settings form, and the disabled core rebuild form** →
  [configure/settings.md](configure/settings.md)
- **The Drush command and its `--force` / `--resume` / `--bundle` options** →
  [drush/rebuild.md](drush/rebuild.md)
- **Programmatic trigger, the `state` keys, and the processing functions** →
  [api/trigger.md](api/trigger.md)

Key facts:
- Config object `node_access_rebuild_progressive.settings`: `cron` (bool, default **false**),
  `chunk` (int, default **500**). Settings form: `/admin/config/development/node-access-rebuild-progressive`
  (route `node_access_rebuild_progressive.settings`, permission `administer site configuration`).
  Note: `configure` is **not** declared in info.yml, so `data.json.configure` is `null`.
- Drush: `drush node-access-rebuild-progressive` (command `node-access-rebuild-progressive:rebuild`).
- `state` keys: `node_access_rebuild_progressive.current` (position), `.processed` (count),
  `.bundles` (content-type filter). A completed/cleared rebuild has `.current == 0` and no `.bundles`.
- Disables core's `node_configure_rebuild_confirm` form (the "Rebuild permissions" button).
