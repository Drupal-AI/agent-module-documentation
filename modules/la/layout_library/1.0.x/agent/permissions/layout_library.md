# Permissions

Layout Library ships **no `layout_library.permissions.yml`**. Access is enforced through two existing
permissions:

| Permission | Source | Gates |
|---|---|---|
| `configure any layout` | `admin_permission` of the `layout` config entity (`src/Entity/Layout.php`) | Managing the library itself — the collection/list, add, and delete routes (`entity.layout.collection`, `entity.layout.add_form`, `entity.layout.delete_form`). This is the "author reusable layouts" capability. |
| `administer {entity_type} display` | core Field UI | The per-layout **Layout Builder** editing route (`layout_builder.layout_library.{entity_type}.view`) — set as `_field_ui_view_mode_access` in `Library::buildRoutes()`. Also gates the bundle's Manage-display checkbox that turns the library on. |

Notes:

- `configure any layout` is a config-entity `admin_permission`, not declared in a permissions file; grant it
  to trusted layout authors only.
- Content **authors** who merely pick a saved layout from the `layout_selection` field need only normal
  create/edit access to the content entity plus the ability to use Layout Builder overrides on that bundle —
  they do **not** need `configure any layout`.
- The `Library` section-storage plugin's own `access()` returns `AccessResult::allowed()`; the real gating
  happens on the routes above.
