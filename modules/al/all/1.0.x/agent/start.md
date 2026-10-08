<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# All (all) — agent index

A single admin **form page** that edits the default settings of **every node content type at once**,
instead of visiting each content type's own form. Package `Site Builder UX`. No hard dependencies
(node-aware: the table is empty without core **`node`**). Core `^8 || ^9 || ^10 || ^11`.
License GPL-2.0-or-later. Version 1.0.1.

- **The page, its route/permission, the six settings, and how a save is applied** →
  [config/settings.md](config/settings.md)

## What it actually is

- One controller/form: `AllTypesSettingsController` (extends core `ConfigFormBase`,
  form id **`all_types_settings_form`**) in
  `src/Controller/AllTypesSettingsController.php`. No entities, no plugins, no services beyond
  the ones it injects, no Drush.
- Route **`all.types`** → path `/admin/structure/types/all`, `_form` = the controller,
  requirement `_permission: 'administer content types'` (the core content-type admin permission).
- Reached via an **action link** (`all.links.action.yml`) and a **menu tab**
  (`all.links.menu.yml`), both `appears_on` / parented to `entity.node_type.collection`
  (`/admin/structure/types`).
- Declares a permission **`administer all`** in `all.permissions.yml` — but the route does NOT
  use it (it uses `administer content types`); `administer all` is currently unused.

## Mechanism (from source)

- `buildForm()` builds a `#type => table` with a row per `NodeType::loadMultiple()` entry. The six
  columns come from the `$allable` map: `display_submitted`, `new_revision`, `preview_mode`,
  `status`, `promote`, `sticky`. Five are checkboxes whose `#default_value` is read from
  `node.type.<id>` config; `preview_mode` is a `select` of DRUPAL_DISABLED / OPTIONAL / REQUIRED.
- `submitForm()` calls `config.factory->listAll('node.type')`, then for each submitted row skips
  any config name **not** in that list (`in_array($ctype, $ctypes)`), loads the editable
  `node.type.<id>` config, sets the submitted keys, `save()`s, and clears cache
  `config:<type>`. `validateForm()` is intentionally empty (admin-only).
- `getEditableConfigNames()` returns `['all.settings']`, but the form never actually writes an
  `all.settings` object — it writes the per-type `node.type.*` config entities directly.

## Notes / caveats

- `all_help()` switches on the route name `help.page.honeypot` instead of `help.page.all`, so the
  help text never displays for this module (copy/paste bug from the honeypot module it was modelled
  on). Cosmetic only.
- No `config/install/` or `config/schema/` ships; the data.json `provides_config_schema` is false.
- Only node content types are handled. `CommentType` is imported but unused; no comment/other-bundle
  rows are built.
