<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Jump Menu (entity_jump_menu) — agent index

A small admin-navigation helper. It renders one form (entity-type select + entity-ID textfield + "Go")
that shows the current page's entity and redirects to another node/user/term by type and ID. Exposed two
ways: an admin **toolbar** tab and a placeable **block**. Package `Utility`. Core `^9.3 || ^10 || ^11`.
License GPL-2.0-or-later. Installed release **8.x-1.3**. No composer deps, no config schema, no routes,
no services, no Drush.

- **The form, block, toolbar hook, permission, and redirect path** → [blocks/jump-menu.md](blocks/jump-menu.md)

## What it actually is (from source)

- `EntityJumpMenuForm` (`src/Form/EntityJumpMenuForm.php`, `FormBase`, form id `entity_jump_menu_form`):
  builds the `entity_type` select, `entity_id` textfield, and `Go` submit; validates the entity exists;
  on submit redirects to `$entity->toUrl()`.
- `EntityJumpMenuBlock` (`src/Plugin/Block/EntityJumpMenuBlock.php`, `@Block` id `entity_jump_menu`,
  category *Forms*): `build()` returns the form; `getCacheMaxAge()` = 0.
- `entity_jump_menu_toolbar()` (`entity_jump_menu.module`): adds a `toolbar_item` rendering the same form,
  gated by permission `access entity jump menu toolbar`.
- Permission: `access entity jump menu toolbar` (`entity_jump_menu.permissions.yml`).
- Libraries: `entity_jump_menu.form` (jQuery + `js/entity_jump_menu.form.js`, form CSS) and
  `entity_jump_menu.toolbar` (toolbar CSS) — `entity_jump_menu.libraries.yml`.
- Supported entity types: `node`, `user`, and `taxonomy_term` (only when the Taxonomy module is enabled).
