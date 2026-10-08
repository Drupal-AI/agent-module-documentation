<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Content Draggable (content_draggable) — agent index

**Ships a single DraggableViews-based admin content view plus an admin menu link for manual click-and-drag ordering of nodes. Contains no PHP.**

- **Version:** 1.0.x (1.0.2)
- **info.yml name/description:** "Content Draggable" — "Enables users to click and drag elements on a screen."
- **Core:** ^9 || ^10 || ^11
- **Depends:** `draggableviews` (provides the drag handles, the save endpoint, and the weight storage)
- **Provides:**
  - Bundled view `config/optional/views.view.content_draggable.yml` — a node table (base table `node_field_data`) with a DraggableViews field/weight, bulk form, title, author, changed, status and operations columns; page display `page_1` at path `/admin/admin-content-draggable`.
  - Admin menu link `content_drabbable.admin_content_draggable` (note the typo in the key) → route `view.content_draggable.page_1`, parent `system.admin`.
  - `hook_uninstall()` in `content_draggable.install` deletes the `views.view.content_draggable` config on uninstall.
- **No PHP classes, no custom routes, no services, no permissions file, no `.module` file, no JS, no templates, no `.api.php`.** All drag-and-drop behavior and persistence come from `draggableviews`.

## Mechanism
The whole feature is a Views configuration. The bundled view's access is the Views `perm` plugin requiring the core **`access content overview`** permission, and its page runs on the admin theme. Rows are rendered by standard Views field handlers (title via the string field plugin with `link_to_entity`), so output escaping is the core Views default. Dragging a row and saving posts to DraggableViews' own endpoint, which writes the per-row weight to the `draggableviews_structure` table; other views can then sort by that weight.

## Security
Access to the listing is gated by the core `access content overview` permission via the view's access plugin — it is not anonymous and not `_access: TRUE`. This module ships no executable code (no controller, route, query, or template), so it introduces no request handling, SQL, or output rendering of its own; reordering is performed and persisted by the `draggableviews` dependency. No TLS or credential handling.
