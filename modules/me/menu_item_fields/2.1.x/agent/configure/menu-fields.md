<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Add fields to menu links & render them

There is no settings page. You (1) enable Field UI for menu links, (2) add fields and configure
displays, (3) place the **"Menu with fields"** block and pick a view mode.

## 1. Enable the Field UI submodule

```bash
drush en menu_item_fields_ui -y
```

This makes Field UI operate on `menu_link_content` (it sets the entity's `field_ui_base_route`
to `entity.menu.collection` and defaults the bundle to `menu_link_content` on the field routes).
Like core Field UI, you can disable it in production once fields exist.

## 2. Add fields / configure displays

`menu_link_content` is a single-bundle fieldable entity (bundle id `menu_link_content`). Manage
it from the **Menus** admin area:

- Manage fields: `entity.menu_link_content.field_ui_fields`
- Manage form display: `entity.entity_form_display.menu_link_content.default`
- Manage display (view modes): the `menu_link_content` view-display routes.

The base fields **link, title, description, weight, enabled, expanded** are made
display-configurable by the module, so they appear on the Manage display screens.

Add view modes for `menu_link_content` (Structure → Display modes → View modes) to render menus
differently (e.g. a `mega` view mode).

Scripted field example:

```php
\Drupal\field\Entity\FieldStorageConfig::create([
  'field_name' => 'field_mi_icon', 'entity_type' => 'menu_link_content', 'type' => 'string',
])->save();
\Drupal\field\Entity\FieldConfig::create([
  'field_name' => 'field_mi_icon', 'entity_type' => 'menu_link_content',
  'bundle' => 'menu_link_content', 'label' => 'Icon',
])->save();
```

## 3. Place & configure the "Menu with fields" block

Block plugin id `menu_item_fields`, derived per menu (like the core system menu block), e.g.
`menu_item_fields:main` for the Main navigation. Admin label **"Menu with fields"**, category
**"Menu item Fields"**. Its two extra settings (see `FieldMenuBlock`):

- **`view_mode`** — the `menu_link_content` view mode used to render every item (default
  `default`).
- **`view_mode_override_field`** — optional; the machine name of a field on the menu link that
  stores a per-item view-mode id (e.g. a list field whose value is `mega`). Default `_none`.
  When set, each item can override the block-level view mode. You must create this field yourself.

Place it like any block (Block layout, or `block_content`/theme region) and choose the menu
derivative. The block extends core's `SystemMenuBlock`, so depth/level settings still apply.

## Per-menu form modes

`hook_entity_form_mode_alter()` swaps the edit form mode for a menu link to a form mode whose
machine name equals the **menu's machine name with dashes replaced by underscores**, *if that
form mode is enabled* (config `core.entity_form_display.menu_link_content.menu_link_content.<id>`
with `status: true`). So to edit Main-menu links with a different set of fields, create and
enable a `menu_link_content` form mode named `main`.

## Notes

- No permission is added; access follows core menu/field permissions.
- Config entities you create for menu links get an automatic `menu_item_fields` module dependency
  (so they're removed cleanly if the module is uninstalled).
- Rendering internals and templates: [../theming/templates.md](../theming/templates.md).
