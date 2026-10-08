<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Using the Rendered Menu formatter

## Field setup
1. Add an **Entity reference** field to your entity that targets **Menu** config entities (target type = "Menu").
2. Populate content by referencing one or more menus (autocomplete or select).
3. On the entity's **Manage display**, set that field's format to **Rendered Menu**.

## Settings
- **Menu Min Depth** (`menu_min_depth`, default 1) — first level to render; set 1 to include the root level, 2 to skip it.
- **Menu Max Depth** (`menu_max_depth`, default 2) — deepest level to render.

Both are applied through `MenuTreeParameters::setMinDepth()/setMaxDepth()` and only when non-empty.

## Rendering pipeline
For each referenced menu, `viewElements()` calls `menu.link_tree->load($menu_name, $params)`, transforms the tree with `checkNodeAccess`, `checkAccess`, `generateIndexAndSort`, then `build()`. Output is a standard menu render array, so it uses your theme's menu templates and honors access.

## Notes
- The referenced value is read from `target_id` (the menu machine name).
- Multi-value fields render one menu per delta.
- No caching or permission configuration is required beyond core.
