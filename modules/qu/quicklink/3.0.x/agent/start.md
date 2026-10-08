<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Quicklink — agent index

Prefetches in-viewport links during browser idle time (Google Quicklink library). All
behavior lives in one config object, `quicklink.settings`; the library is attached on every
page by `hook_preprocess_html()` and configured through `drupalSettings.quicklink`.

- **Settings keys, the config UI, and drush read/write** →
  [configure/settings.md](configure/settings.md)
- **How the library loads, the load/ignore decision logic, local vs CDN** →
  [api/mechanism.md](api/mechanism.md)

Key facts: configure route `quicklink.settings` at
`admin/config/development/performance/quicklink` (permission: `administer site configuration`).
No plugins, no Drush, no permissions of its own. `user/logout` is always ignored.
