# BasicShib permissions

From `basicshib.permissions.yml` — all `restrict access: true` (trusted-admin only):

| Permission | Gates |
|---|---|
| `administer basicshib` | Core settings form and Grouper settings form (`/admin/config/basicshib/coresettings`, `/groupersettings`). Controls attribute map, handlers, messages, plugin selection, Grouper enable, redirect path. |
| `administer authorization` | Authorization config entities (`/admin/config/basicshib/authorization…`): map Drupal roles → Grouper Policies. Collection route additionally requires Grouper enabled. |
| `administer policies` | Policies config entities (`/admin/config/basicshib/policies…`): define Grouper group-path policies. Collection route additionally requires Grouper enabled. |
| `administer auth_filter` | Defined for the auth-filter (user provisioning / role-removal) settings. |

There is also `administer authentication`, declared but a general label (not bound to a
BasicShib route in `basicshib.routing.yml`).

Notes:
- The Authorization/Policies **collection** routes add a custom access check
  `MenuGrouperController::grouperEnabled` (hidden unless Grouper is on); the add/edit/delete
  routes rely on the permission only.
- These are powerful admin permissions: whoever holds `administer basicshib` /
  `administer authorization` controls how SSO identities map to roles (including which Grouper
  policies grant the administrator role). Grant only to fully trusted operators.
