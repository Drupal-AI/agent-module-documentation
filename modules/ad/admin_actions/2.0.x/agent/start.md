<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Admin actions (admin_actions) — agent index

**Renders single-entity VBO actions as one-click buttons on entity pages via a Views block.**

- **Version:** 2.0.x (2.0.1)
- **Core:** ^9.3 || ^10 || ^11
- **Depends:** node, views, block, action, views_bulk_operations
- **Submodule:** `refresh_date` (example Action plugin `node_refresh_date_action`)
- **No routes / no permissions / no services of its own.** Behaviour is a `hook_form_alter` in `admin_actions.module` that matches `views_form_*` forms whose view id is `admin_actions` or tagged `admin_actions`.
- **Provided view:** `admin_actions` (config/install/views.view.admin_actions.yml); block `views_block__admin_actions_admin_actions_block`.
- **Configure:** edit the view at `/admin/structure/views/view/admin_actions` (VBO field) and place the block.

**Security:** no custom endpoints; button availability is governed by the host view's access and each Action plugin's `access()` (the example defers to the entity's `update` access). No anonymous mutation is introduced by the module itself. The form_alter defensively catches and ignores any unexpected form/view structure.

See [configure/admin_actions.md](configure/admin_actions.md)
