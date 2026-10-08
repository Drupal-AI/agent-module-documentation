<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Per-bundle permissions

All permissions are generated at runtime by
`EckBundlePermissionsGenerator::entityPermissions()` (`src/EckBundlePermissionsGenerator.php`), wired
in through the `permission_callbacks:` entry in `eck_bundle_permissions.permissions.yml`. For **every**
ECK entity type (`{type}` = the eck entity type machine id, e.g. `event`) and **every** bundle of it
(`{bundle}` = the bundle machine id, e.g. `article`) the following are produced:

| Permission machine name | UI label | Gates operation | When present |
|---|---|---|---|
| `create {type} entities of bundle {bundle}` | Create new {TypeLabel} {BundleLabel} entities | `create` | always |
| `edit any {type} entities of bundle {bundle}` | Edit any {TypeLabel} entities of bundle {BundleLabel} | `update`/`edit`, any owner | always |
| `delete any {type} entities of bundle {bundle}` | Delete any {TypeLabel} entities of bundle {BundleLabel} | `delete`, any owner | always |
| `view any {type} entities of bundle {bundle}` | View any {TypeLabel} entities of bundle {BundleLabel} | `view`, any owner | always |
| `edit own {type} entities of bundle {bundle}` | Edit own {TypeLabel} entities of bundle {BundleLabel} | `update`/`edit`, owner only | only if the type has an author field |
| `delete own {type} entities of bundle {bundle}` | Delete own {TypeLabel} entities of bundle {BundleLabel} | `delete`, owner only | only if the type has an author field |
| `view own {type} entities of bundle {bundle}` | View own {TypeLabel} entities of bundle {BundleLabel} | `view`, owner only | only if the type has an author field |

Notes:
- The `own` variants exist only when `EckEntityType::hasAuthorField()` is TRUE (the eck entity type was
  created with a `uid`/author base field). Otherwise only the four `any`/`create` permissions appear.
- Each generated permission carries a config **dependency** on its bundle config entity
  (`{bundle}->getConfigDependencyName()`), so the permission is auto-removed when the bundle is deleted.
- The module's help page text describes these as "edit **all** …", but the actual machine names use
  `any` — grant/check the `any` strings.
- These are **additive**: the access handler ORs them onto eck's coarse per-type permissions
  (`{op} any {type} entities`, `{op} own {type} entities`, `create {type} entities`). Holding neither
  the per-type nor the per-bundle permission leaves the user unaffected; the per-bundle permission never
  narrows an access already granted per-type. See [../hooks/hooks.md](../hooks/hooks.md) for the exact
  enforcement (`EckBundleAccessControlHandler`).
- The `create {type} entities of bundle {bundle}` permission is actually enforced by **eck's own**
  base handler (`EckEntityAccessControlHandler::checkCreateAccess()` already checks
  `create {type} entities of bundle {entity_bundle}`); this module only makes it appear on the
  permissions UI. (Its own `checkBundleAccess()` for create checks a `create any …` string that is
  never generated, so that branch is a no-op — net effect is unchanged.)

## Where to grant them

- Standard permissions page: `/admin/people/permissions` (all bundles' permissions listed together).
- Per-bundle tab (Drupal ≥ 10.3): each bundle gets its own permissions form at
  `/admin/structure/eck/entity/{type}/bundles/{bundle}/permissions`, added by
  `eck_bundle_permissions_entity_type_alter()` using core's `EntityPermissionsRouteProvider`.
- Programmatically:

```php
// Grant "view any" on the "article" bundle of the "event" eck type to the "editor" role.
user_role_grant_permissions('editor', ['view any event entities of bundle article']);
```

Because a freshly added bundle produces permissions that no role holds yet, a new bundle is **closed by
default** — grant the needed permission(s) before expecting access.
