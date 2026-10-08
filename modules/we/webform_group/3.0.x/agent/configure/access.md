# Group-role access rules

Webform Group extends Webform's access-rules system so each rule can additionally list **group
roles**. Access is granted if the current user's group roles (for the group the webform's source
node belongs to) intersect the rule's `group_roles`.

## Where it's configured
- **Webform Settings → Access** (`webform_settings_access_form`): every access permission row
  (create, view/update/delete/purge *any*/*own*, administer) gets a "Group (node) roles"
  selector (`webform_group_roles` element). The `administer` rule is shown as a dedicated
  "Administer submissions (Groups only)" details section. See
  `webform_group_form_webform_settings_access_form_alter()`.
- **Webform UI element form** (`webform_ui_element_form`): per-element `access_create`,
  `access_update`, `access_view` each get a "Group roles" selector
  (`access_{op}_group_roles` custom property). A warning message appears if the element's
  user-role access already grants anonymous/authenticated (which makes group roles moot).

## Storage
Group roles are stored on the **webform's own `access` config**, not in `webform_group.settings`.
`webform_group_config_schema_info_alter()` adds a `group_roles` sequence under
`webform.webform.*:access.*`. Element group roles are stored as the element custom property
`access_{op}_group_roles`.

## Runtime enforcement (hooks in `webform_group.module`)
| Hook | What it allows |
|---|---|
| `hook_webform_access` (`webform_group_webform_access`) | Access to the webform when user group roles intersect the `administer` or the operation's rule `group_roles`. Skips when the request is a `webform` source entity (recursion guard). |
| `hook_webform_submission_access` (`..._webform_submission_access`) | view/update/delete a submission when user group roles intersect `administer`, `{op}_any`, or `{op}_own` (own also requires ownerId == account id). |
| `hook_webform_element_access` (`..._webform_element_access`) | Per-element access; if no group roles set, falls back to user-role (anonymous/authenticated) access. |
| `hook_webform_submission_query_access_alter` (`..._query_access_alter`) | Rewrites submission list queries to the current group's webform + source entity (+ uid for own-only), so lists are group-scoped. |

Group roles are resolved via `WebformGroupManager` (see [../api/manager.md](../api/manager.md)),
which uses `GroupRoleStorage::loadByUserAndGroup($account, $group, TRUE)` — so **implied** roles
(outsider/insider/member) are included.

The `webform_group_roles` form element (`src/Element/WebformGroupRoles.php`) extends core
`Select` (multiple, Select2), listing group roles grouped by group type, with flags
`#include_internal`, `#include_anonymous`, `#include_outsider`, `#include_user_roles`.
