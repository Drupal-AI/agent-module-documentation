<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enabling grids — Content Autogrid

1. Enable the module.
2. Go to `/admin/config/content/autogrid/settings` (requires `administer autogrid settings`).
3. Tick the entity types that should have an auto-generated grid and save. For bundled entity types the grid is attached at the bundle level (via the bundle entity type).
4. Grant the `view autogrid` permission to roles that should see the grids.

## Where the grid appears
A route subscriber adds a `.../grid` route based on each enabled type's `edit-form` (falling back to `canonical`) link template, registered as `entity.<type>.autogrid` and marked as a Field UI (`_field_ui`) task. For example a node type gets `…/manage/<type>/grid`.

## What renders
- A column per field from the bundle's field definitions, each cell rendered with the field's display formatter (default view mode, labels hidden).
- An ID column and an Operations column (edit/delete links from the entity list builder).
- Table header sorting and a core pager.

## Notes
- Only the entity types you explicitly enable get grids.
- Access is enforced twice: `administer autogrid settings` to configure and `view autogrid` to view — both `restrict access: true`.
