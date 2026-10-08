<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# migmag_rollbackable_replace — the override

`migmag_rollbackable_replace_migrate_destination_info_alter(&$definitions)` swaps the `class`
of these core destination plugins (ids kept the same):

| Core id | New class (`Drupal\migmag_rollbackable\Plugin\migrate\destination\…`) |
|---|---|
| `color` | `RollbackableColor` |
| `config` | `RollbackableConfig` |
| `default_langcode` | `RollbackableDefaultLangcode` |
| `component_entity_display` | `RollbackablePerComponentEntityDisplay` |
| `component_entity_form_display` | `RollbackablePerComponentEntityFormDisplay` |
| `shortcut_set_users` | `RollbackableShortcutSetUsers` |
| `d7_theme_settings` | `RollbackableThemeSettings` |

Only ids present in `$definitions` are altered (so `color`/`shortcut_set_users` require their
provider modules).

## Enable / disable

```bash
drush en migmag_rollbackable_replace -y     # override on (pulls in migmag_rollbackable)
drush pmu migmag_rollbackable_replace -y    # override off
```

Destination definitions are cached — run `drush cr` after toggling.

## Verify

```php
\Drupal::service('plugin.manager.migrate.destination')->getDefinition('config')['class'];
// enabled  -> Drupal\migmag_rollbackable\Plugin\migrate\destination\RollbackableConfig
// disabled -> Drupal\migrate\Plugin\migrate\destination\Config
```

No configuration. To make only specific migrations rollbackable instead of globally, don't
enable this module — set those migrations' `destination: plugin:` to the `migmag_rollbackable_*`
id directly.
