# Permissions & access

Defined in `geo_entity.permissions.yml`. Access is enforced by
`Drupal\geo_entity\GeoEntityAccessControlHandler`.

| Permission | `restrict access` | Gates |
|---|---|---|
| `administer geo` | true | Full access to all geo entities (bypasses all checks below) |
| `administer geo types` | true | Manage geo bundles (`admin_permission` of `geo_entity_type`) |
| `access geo overview` | — | The geo collection/overview; `admin_permission` of the `geo_entity` type |
| `create geo` | — | Create geo entities |
| `view geo` | — | View geo entities |
| `edit any geo` | — | Edit any geo regardless of owner |
| `edit own geo` | — | Edit geos the user authored |
| `delete any geo` | — | Delete any geo regardless of owner |
| `delete own geo` | — | Delete geos the user authored |

## Access logic (`checkAccess`)

- `administer geo` → allowed for every operation.
- **view** → `view geo` (not ownership-scoped).
- **update** → `edit any geo`, else owner + `edit own geo`, else neutral.
- **delete** → `delete any geo`, else owner + `delete own geo`, else neutral.
- **create** (`checkCreateAccess`) → `administer geo` or `create geo`.

Ownership is `entity->getOwnerId() == $account->id()`; results are cached per-permissions (and per-user for
"own" checks).

## Install-time grant (note)

`geo_entity_install()` grants `view geo` to **both anonymous and authenticated** roles on install
(intentionally, mirroring core Media). Stored geo entities are therefore world-viewable by default. If a site
stores non-public locations, revoke `view geo` from the anonymous role after install.
