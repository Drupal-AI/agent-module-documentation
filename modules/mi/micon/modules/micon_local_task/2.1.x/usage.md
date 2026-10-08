<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Micon Local Task automatically adds icons to Drupal's local-task tabs (the primary tabs like View / Edit / Delete / Revisions) by matching each tab title against a shipped set of `local_task.*` icon definitions.

---

The submodule implements `hook_menu_local_tasks_alter()`: for every primary/secondary tab it rewrites the title to `micon($title)->addMatchPrefix('local_task')->setIconOnly($config->get('icon_only'))`. The `addMatchPrefix('local_task')` makes Micon look up `local_task.<title>` in the `micon_icons` definitions, and the module ships `micon_local_task.micon.icons.yml` with ~35 mappings — e.g. `local_task.view` → `fa-eye`, `local_task.edit` → `fa-edit`, `local_task.delete` (regex) → `fa-trash`, `local_task.revision` → `fa-history`, `local_task.translate` → `fa-language`, `local_task.settings` → `fa-gear`. A single boolean config, `micon_local_task.config` → `icon_only` (default `false`), decides whether tabs show icon-only or icon+label; it is edited at `/admin/structure/micon/local-task` (permission `administer micon`). Because matching is by tab title, tabs whose title has no matching definition simply render without an icon. No field, widget, or permission of its own.

---

- Add icons to the View/Edit/Delete/Revisions tabs across the admin UI.
- Show admin tabs as icon-only to save horizontal space.
- Give the node edit tabs recognisable Font Awesome icons automatically.
- Icon-decorate entity local tasks without theming each one.
- Provide consistent tab iconography site-wide.
- Turn on compact icon-only tabs for a cleaner admin toolbar area.
- Icon the Translate / Revisions / Devel tabs via the shipped definitions.
- Extend the tab icon set by adding `local_task.*` entries in a custom `*.micon.icons.yml`.
- Override a shipped tab icon with `hook_micon_icons_alter()`.
- Match tab titles by regex for families like delete/import/export/sync.
- Keep tab labels but prepend icons (icon_only = false).
- Switch all admin tabs to icons for a dashboard-style admin theme.
- Icon the Manage fields / form display / display tabs on bundle admin pages.
- Improve scannability of long primary-tab rows.
- Apply icons to custom module tabs by naming their titles to match definitions.
- Give the Settings/Update/Uninstall tabs relevant icons.
- Reduce visual clutter on entity pages with icon-only tabs.
- Provide a themed admin experience with minimal code.
- Standardise tab iconography using the site's Micon package.
