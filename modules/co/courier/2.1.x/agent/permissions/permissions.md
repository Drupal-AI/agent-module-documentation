# Courier — permissions

From `courier.permissions.yml`:

| Permission | `restrict access` | Gates |
|---|---|---|
| `administer courier` | **TRUE** | The settings (`courier.admin.settings`) and maintenance (`courier.admin.maintenance`) forms under `/admin/config/communication/courier`. Trusted-admin permission. |
| `courier bypass queue` | (not restricted) | Lets a caller skip the message queue and send in the same request. Documented as potentially impacting performance significantly; it is a performance/behaviour toggle, not an access-control boundary. |

Additional access notes:
- The `courier_email` content entity declares `admin_permission = "administer courier_email"`, but that
  permission is **not defined** by this module — so its view/edit/delete routes are effectively locked
  down by default (only a role holding every permission, i.e. user 1, passes) unless another module
  grants access.
- Template-collection template routes use `_entity_access: courier_template_collection.templates`;
  the `courier_system` submodule grants that operation (for its own collections) to holders of core's
  `administer account settings` (a restricted permission).
