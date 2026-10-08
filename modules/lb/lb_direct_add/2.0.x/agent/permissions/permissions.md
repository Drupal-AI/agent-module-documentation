<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Defined in `lb_direct_add.permissions.yml`:

| Permission | Gates |
|---|---|
| `administer layout builder direct add settings` | Access to the settings form (`lb_direct_add.settings_form`, `/admin/config/content/layout-builder-direct-add`). |
| `access layout builder direct add more options` | Whether the **"More…"** link (back to the core `layout_builder.choose_block` off-canvas chooser) is shown in the direct-add widget. |

Notes:

- Neither permission is `restrict access`-flagged.
- Users **without** `access layout builder direct add more options` still get the direct-add
  dropbutton/popover of inline block types; they just lose the fallback link to the full block
  chooser. Use this to limit certain roles to the pre-approved inline block types only.
- Granting/checking in code: `\Drupal::currentUser()->hasPermission('access layout builder direct add more options')` (this is exactly what `LayoutBuilder::preRender` calls).
