<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring local-task tab icons

## Config: `micon_local_task.config`
| key | type | default | meaning |
|---|---|---|---|
| `icon_only` | boolean | `false` | `true` = tabs render icon-only; `false` = icon + label |

Form: **`/admin/structure/micon/local-task`** (route
`micon_local_task.micon_local_task_config_form`, `MiconLocalTaskConfigForm`, permission
`administer micon`). Drush:
```
drush config:get micon_local_task.config icon_only
drush config:set micon_local_task.config icon_only true -y
```

## How tabs get icons
`hook_menu_local_tasks_alter()` loops the tab groups and sets each tab title to:
```php
micon($title)->addMatchPrefix('local_task')->setIconOnly($config->get('icon_only'));
```
`addMatchPrefix('local_task')` makes Micon look up `local_task.<lowercased title>` in the
`micon_icons` definitions before matching the bare title. A tab whose title has no matching
definition renders unchanged (no icon).

## Shipped definitions (`micon_local_task.micon.icons.yml`)
~35 entries, e.g.:

| match (text/regex) | icon |
|---|---|
| `local_task.view` | `fa-eye` |
| `local_task.edit` | `fa-edit` |
| `local_task.delete` (regex `^local_task.delete`) | `fa-trash` |
| `local_task.revision` | `fa-history` |
| `local_task.translate` | `fa-language` |
| `local_task.settings` | `fa-gear` |
| `local_task.manage fields` | `fa-pencil-square` |
| `local_task.manage form display` | `fa-check-square` |
| `local_task.import` / `.export` / `.sync` (regex) | `fa-download` / `fa-upload` / `fa-refresh` |

Add or override entries with your own `<module>.micon.icons.yml` `local_task.*` definitions or
`hook_micon_icons_alter()` — see the parent `micon` `plugins/micon-icons.md`.
