<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Micon Local Task — agent index

Automatically icons the local-task tabs (View/Edit/Delete/Revisions…) by matching each tab
title against shipped `local_task.*` icon definitions.

- **The `icon_only` config, the config form, the shipped tab-icon definitions, and how the
  matching works** → [configure/local-task.md](configure/local-task.md)

Key facts (grounded in `micon_local_task.module` + `micon_local_task.micon.icons.yml`):
- **Mechanism:** `hook_menu_local_tasks_alter()` rewrites each tab title to
  `micon($title)->addMatchPrefix('local_task')->setIconOnly($config->get('icon_only'))`.
- **Definitions:** `micon_local_task.micon.icons.yml` maps `local_task.view` → `fa-eye`,
  `local_task.edit` → `fa-edit`, `local_task.delete` (regex) → `fa-trash`, etc. (~35 entries).
- **Config:** `micon_local_task.config` → `icon_only` (bool, default `false`); form at
  `/admin/structure/micon/local-task` (permission `administer micon`).

Set programmatically:
```php
\Drupal::configFactory()->getEditable('micon_local_task.config')->set('icon_only', TRUE)->save();
```
See the parent `micon` docs for the `micon_icons` plugin type and `addMatchPrefix()`.
