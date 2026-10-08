<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API: services & programmatic access

## Services

| Service id | Class | Use |
|---|---|---|
| `plugin.manager.workbench_access.scheme` | `WorkbenchAccessManager` | Plugin manager for AccessControlHierarchy plugins; also helper access logic. |
| `workbench_access.user_section_storage` | `UserSectionStorage` | Read/assign the sections a **user** belongs to (per-scheme). |
| `workbench_access.role_section_storage` | `RoleSectionStorage` | Read/assign the sections a **role** belongs to (stored in state). |
| `workbench_access.tokens` | `WorkbenchAccessTokens` | Token integration for sections. |

## Access schemes & their plugin

```php
$schemes = \Drupal::entityTypeManager()->getStorage('access_scheme')->loadMultiple();
$scheme  = \Drupal::entityTypeManager()->getStorage('access_scheme')->load('editorial');
$plugin  = $scheme->getAccessScheme();     // the instantiated AccessControlHierarchy plugin
$id      = $scheme->get('scheme');          // 'taxonomy' | 'menu' | custom
$tree    = $plugin->getTree();              // the section hierarchy
```

## Section assignments

Per-user assignments are the `section_association` content entity
(`Drupal\workbench_access\Entity\SectionAssociation`); deleting a scheme cascades and
deletes its associations. Work with them through the storage services rather than by hand:

```php
$uss = \Drupal::service('workbench_access.user_section_storage');
$sections = $uss->getUserSections($scheme, $account);   // section ids for a user
$uss->addUser($scheme, $account, ['section_id']);       // assign
$uss->removeUser($scheme, $account, ['section_id']);

$rss = \Drupal::service('workbench_access.role_section_storage');
$rss->getRoleSections($scheme, $account);               // sections a user gets via roles
$rss->addRole($scheme, 'editor', ['section_id']);
```

## Drush commands

- `drush workbench_access:installTest` — scaffold a demo Taxonomy hierarchy + field to try the module (you still create a taxonomy scheme afterwards).
- `drush workbench_access:flush` — flush all section assignments (useful in testing).

Command file: `Drupal\workbench_access\Commands\WorkbenchAccessCommands`
(`drush.services.yml` service `workbench_access.commands`).

## Altering scheme settings

`hook_workbench_access_scheme_update_alter(array &$settings, \Drupal\Core\Config\Config $config)`
lets a module rewrite a scheme's stored `scheme_settings` (typically during migration/update).
See `workbench_access.api.php`.
