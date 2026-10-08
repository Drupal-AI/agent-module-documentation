<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# migrate_upgrade — agent start

Drush front-end to core `migrate_drupal`: upgrade a legacy Drupal 6/7 site into the current
site, or export the generated migrations as `migrate_plus` config entities for customization.
**No admin UI, no permissions, no config schema** — it is entirely Drush-driven. Depends on
`migrate`, `migrate_drupal`, `migrate_plus`. Run on a fresh, empty target with only the
destination modules enabled.

- The two Drush commands, aliases, options, and examples → [drush/commands.md](drush/commands.md)
- `--configure-only` workflow + the config entities it generates (group `migrate_drupal_<v>`,
  `upgrade_`-prefixed migrations, the `migrate_drupal_ui.performed` marker) →
  [configure/configure-only.md](configure/configure-only.md)
