# Permissions

`entity` defines no fixed permissions of its own. Instead `EntityPermissions::buildPermissions`
(via `entity.permissions.yml`) **dynamically generates** permissions for every entity type
that declares an `entity`-provided `permission_provider` handler.

For an entity type `X` with bundles `B` (granularity = `entity_type` or `bundle`):

| Permission | Gates |
|---|---|
| `administer X` (or the type's `admin_permission`) | Full admin over the type |
| `access X overview` | The collection/listing page |
| `view X` / `view B X` | Viewing entities (type- or bundle-wide) |
| `view own unpublished X` | Author viewing their unpublished entities |
| `create B X` | Creating entities of bundle B |
| `update own X` / `update any X` (+ `B`) | Editing own vs any entities |
| `duplicate own X` / `duplicate any X` (+ `B`) | Cloning own vs any entities |
| `delete own X` / `delete any X` (+ `B`) | Deleting own vs any entities |

`UncacheableEntityPermissionProvider` additionally emits **`view own X`** (and `view own B X`),
which core omits because it forces per-user page caching.

The `EntityAccessControlHandler` enforces exactly these strings, so granting the generated
permission is all that's required — no custom access code.
