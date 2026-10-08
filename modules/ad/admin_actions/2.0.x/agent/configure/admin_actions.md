<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring admin_actions

## What it does
Provides no actions itself. It ships a VBO-enabled view named `admin_actions` and a `hook_form_alter` that, for that view's block form (or any view tagged `admin_actions`), auto-selects the one row and hides the VBO table so only the operation buttons show.

## Steps
1. `drush en admin_actions` — installs the `admin_actions` view and tries to place its block.
2. Edit the view at `/admin/structure/views/view/admin_actions`. Under **Fields**, open **Global: Views bulk operations** and select/relabel the actions you want (core actions, `action` module actions, or contrib such as `views_bulk_edit`).
3. Place/position the block `views_block__admin_actions_admin_actions_block` (Block layout) so it appears alongside the entity pages you want (e.g. visibility pages `/node/*`).
4. Constrain access on the view (roles/permissions) — this governs who sees the buttons.

## Reusing on your own view
Give any VBO view the administrative **tag** `admin_actions`; the form_alter then applies the same auto-select + hide-table behaviour to its block form.

## Custom action
Add a plugin under `src/Plugin/Action/*.php` with an `@Action` annotation that declares a `type` (VBO ignores actions with no `type`). Implement `execute($entity)` and gate it in `access()` — the bundled `refresh_date` example returns `$object->access('update', $account, $return_as_object)`.
