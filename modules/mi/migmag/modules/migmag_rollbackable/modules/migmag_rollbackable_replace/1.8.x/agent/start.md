<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# migmag_rollbackable_replace — agent index

Glue module. One `hook_migrate_destination_info_alter()` implementation that rewrites the
`class` of core destination plugins (`config`, `color`, `default_langcode`,
`component_entity_display`, `component_entity_form_display`, `shortcut_set_users`,
`d7_theme_settings`) to the `Rollbackable*` classes from `migmag_rollbackable`. **Plugin ids
are unchanged.** No config, routes, permissions, Drush, or plugins of its own. Depends on
`migmag_rollbackable`.

- **The class-swap map & how to verify it** → [api/override.md](api/override.md)

Verify at runtime:
`\Drupal::service('plugin.manager.migrate.destination')->getDefinition('config')['class']`
→ `Drupal\migmag_rollbackable\Plugin\migrate\destination\RollbackableConfig` when enabled
(core `Drupal\migrate\Plugin\migrate\destination\Config` when not).
