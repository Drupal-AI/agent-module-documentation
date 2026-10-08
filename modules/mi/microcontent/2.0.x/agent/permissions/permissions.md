# Micro-content permissions

Defined in `microcontent.permissions.yml` plus a dynamic callback
(`Access\MicroContentPermissions::getPermissions`). Enforced by `Access\MicroContentAccessHandler`
(items) and `EntityHandlers\MicrocontentTypeAccessHandler` (types).

## Static permissions
| Permission | `restrict access` | Gates |
|---|---|---|
| `administer microcontent types` | **true** | Add/edit/delete micro-content **types** (the type entity `admin_permission`). |
| `administer microcontent` | **true** | Full access to all micro-content **items** (item entity `admin_permission`; short-circuits the access handler to *allowed*). |
| `view unpublished microcontent` | — | View unpublished items (also used for JSON:API "among all" filter access and the backfill query). |
| `access microcontent overview` | — | View the admin overview page. |
| `view any microcontent history` | — | View an item's revisions list ("view all revisions"). |
| `view any microcontent revisions` | — | View a specific revision. |
| `revert any microcontent revisions` | — | Revert a revision. |
| `delete any microcontent revisions` | — | Delete a revision. |

## Dynamic per-bundle permissions
For every `microcontent_type`, `MicroContentPermissions::buildPermissions()` generates:
`create <type> microcontent`, `update own <type> microcontent`, `update any <type> microcontent`,
`delete own <type> microcontent`, `delete any <type> microcontent`.

## Access handler logic (`MicroContentAccessHandler::checkAccess`)
- Holder of `administer microcontent` → allowed for everything.
- **view**: `view unpublished microcontent` OR the item `isPublished()`.
- **update / delete**: `update|delete any <bundle> microcontent`, OR (`update|delete own <bundle>
  microcontent` AND the account is the item owner).
- **create** (`checkCreateAccess`): `administer microcontent` OR `create <bundle> microcontent`.
- Revision ops map to the four `* any microcontent revisions` / `view any microcontent history`
  permissions above.
- Type entities: `view label` needs `access content`; everything else falls through to core's
  `admin_permission` check (`administer microcontent types`).

Note: the two `administer *` permissions are `restrict access: true` (trusted-admin). The remaining
permissions are scoped to viewing/owning content and do not cross a trust boundary — nothing here grants
outsized capability to a low-trust role.
