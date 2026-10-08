# Permissions

Defined in `access_policy.permissions.yml` plus a dynamic `permission_callbacks` entry
(`Drupal\access_policy\AccessPolicyPermissions::entityPermissions`).

## Static permissions

| Permission | Grants | Notes |
|------------|--------|-------|
| `administer access policy entities` | Create/edit/delete access policies; access all `access_policy_ui` admin routes | `restrict access: true`. Is the config entity `admin_permission`. |
| `set entity access policy` | Use the per-entity **Access** tab to assign a policy | Not sufficient alone — the user also needs `assign <id> access policy` for the specific policy. |

## Generated per-policy permissions

For **each** access policy, `AccessPolicyPermissions::createAccessPolicyPermissions()` emits
permissions derived from the policy's enabled `operations`, the target entity type label, and
whether the policy uses access rules. `<id>` = policy machine name, `<type>` = lowercased entity
type label (e.g. `content` for node).

| Permission pattern | Emitted when | Meaning |
|--------------------|--------------|---------|
| `view <id> <type>` | `operations.view.permission` + View op applicable | View entities assigned this policy |
| `view any <id> unpublished <type>` | ViewUnpublished op applicable (entity implements `EntityOwnerInterface`) | View unpublished entities assigned this policy |
| `view all <id> <type> revisions` | ViewAllRevisions op applicable (revisionable + `revision` link) | View revisions (still needs core revision perms) |
| `edit <id> <type>` | Edit op applicable | Update entities assigned this policy |
| `delete <id> <type>` | Delete op applicable | Delete entities assigned this policy |
| `assign <id> access policy` | always | Assign this policy to an entity (also the `manage_access` permission) |
| `bypass <id> access rules` | policy supports access rules | View/edit/delete regardless of access-rule outcome (still needs the view/edit/delete permission) |
| `edit <id> user information` | policy supports access rules | Edit user fields observed by this policy's access rules — `restrict access: true` |

Each generated permission carries a config dependency on its access policy, so it disappears when
the policy is deleted.

## How they are enforced

- The operation → permission mapping is per operation plugin
  (`src/Plugin/access_policy/AccessPolicyOperation/*`); `getPermission()` builds the exact string.
- `AccessPolicyValidator::validateAccessPolicy()` checks the operation permission (when
  `operations.<op>.permission`) and then the access rules (when `operations.<op>.access_rules`),
  short-circuiting the rule check if the account has `bypass <id> access rules`.
- Assignment (`manage_access`) is gated by `AccessPolicySelection::validateAssignAccessPolicy()`:
  the account must have `assign <id> access policy` for at least one assignable policy **and** for
  every policy already on the entity.
- `edit <id> user information` is enforced in `EntityOperations::userFieldAccess()`
  (`hook_entity_field_access`): a user field observed by an access rule is hidden on edit forms
  unless the account holds this permission.

## Recommended baseline

Grant `administer access policy entities` only to trusted administrators (it is `restrict
access`). Grant `set entity access policy` + the relevant `assign <id> access policy` to editors
who should apply policies. Grant `view/edit/delete <id> <type>` per policy to the roles that should
reach that content.
