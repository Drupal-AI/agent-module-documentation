<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Actions UI (action) — agent index

Contrib continuation of core's removed `action` module. Supplies the admin UI for the
core `action` config entity (`Drupal\system\Entity\Action`) plus three configurable
"advanced action" plugins. UI lives at `/admin/config/system/actions`, gated by the core
`administer actions` permission. No services, Drush commands, or permissions of its own.

- **Configure / manage actions** (routes, the `action` config entity, the three shipped
  advanced-action plugins + their config keys, create via drush/PHP) →
  [configure/advanced-actions.md](configure/advanced-actions.md)
- **Write your own configurable Action plugin** (the pattern these plugins use) →
  [plugins/action-plugins.md](plugins/action-plugins.md)
