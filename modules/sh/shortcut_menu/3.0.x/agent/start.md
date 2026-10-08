<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Shortcut Menu (shortcut_menu) — agent index

Adds nesting to core's Shortcut module: shortcuts get a **parent** and a **depth**, and the
customise screen becomes a draggable, indentable tree. No routes, no config form, no permissions,
no schema, no Drush of its own — it reuses core `shortcut` entirely. Requires core `shortcut`.
Installed release **3.0.0-beta8** — beta, schema may still change.

- **Full nesting mechanism** (base fields, customize form swap, lazy-builder decorator, update
  path, how to operate it) → [api/nesting.md](api/nesting.md)

How it works (whole module is ~4 files):
- `hook_entity_base_field_info()` adds two base fields to the `shortcut` entity — **`parent`**
  (string, stores the parent shortcut's **UUID**, so a set exports cleanly) and **`depth`**
  (integer). Adding base fields triggers an entity-definition schema update on install.
- `hook_entity_type_build()` swaps the `shortcut_set` **customize** form class to
  `Drupal\shortcut_menu\Form\ShortcutMenuSetCustomize extends Drupal\shortcut\Form\SetCustomize`.
  It renders the drag-and-indent tree and, on save, writes each shortcut's `parent`/`depth`/weight.
  Route is unchanged: `entity.shortcut_set.customize_form`
  (`/admin/config/user-interface/shortcut/manage/{shortcut_set}/customize`), gated by core's
  `_entity_access: shortcut_set.update`.
- `ShortcutMenuLazyBuilder extends Drupal\shortcut\ShortcutLazyBuilders`, registered in
  `shortcut_menu.services.yml` as a **decorator** of `shortcut.lazy_builders`
  (`decorates: shortcut.lazy_builders`, priority 1). Its `lazyLinks()` reorganises the links core
  already returned into a nested `#theme => 'menu'` render array; it does not fetch links the user
  could not already see.
- `shortcut_menu.libraries.yml` (`toolbar` library) + `css/shortcut_menu.shortcut.css` style the
  nested toolbar list.
- `hook_help()` on `help.page.shortcut_menu`. `hook_update_9000()` migrates old integer-ID parents
  to UUIDs.

Notes:
- Core shortcut **permissions** (`administer shortcuts`, `customize shortcut links`,
  `access shortcuts`) govern everything; the module defines no permissions or routes of its own.
- **Uninstalling drops the `parent`/`depth` columns and their data** (the base fields come from
  `hook_entity_base_field_info`, so core removes them on uninstall — see the kernel test). Nesting
  is lost and shortcuts revert to a flat list; the shortcuts themselves survive.
- Subclass-and-swap: another module that also overrides the shortcut-set customize form class or
  decorates `shortcut.lazy_builders` may conflict.
