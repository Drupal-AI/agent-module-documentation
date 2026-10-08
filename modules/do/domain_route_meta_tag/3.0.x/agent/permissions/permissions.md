# Permissions

Defined in `domain_route_meta_tag.permissions.yml`:

- **`access domain meta`** — "Access Domain Meta for Domain Specific Route".
  Marked `restrict access: true`. This is the permission the entity access handler
  (`DomainRouteMetaTagAccessControlHandler`) checks for `view`, `edit`, `delete` and
  `create` on `domain_route_meta_tag` records. Grant it to trusted roles to let them
  add/edit/delete meta-tag records via the admin UI.

No other operational permission is defined by the module.

## Access caveats (from source, worth knowing)
- The **list/collection route** (`entity.domain_route_meta_tag.collection`,
  `/admin/config/system/domain_route_meta_tag/list`) is gated by `_permission: 'view contact
  entity'` in `domain_route_meta_tag.routing.yml` — a permission that no installed module
  defines (leftover from the entity-example scaffold). In practice only user 1 (which bypasses
  all access checks) can open the list unless that permission is provided elsewhere; the
  add/view/edit/delete routes use entity access (`access domain meta`) and behave normally.
- The entity annotation declares `admin_permission = "administer domain_route_meta_tag entity"`,
  which is also not defined anywhere; the access handler relies on `access domain meta`, so this
  has no effect.
