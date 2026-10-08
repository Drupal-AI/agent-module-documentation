# Permissions

`entity` defines no fixed permissions of its own. Instead `EntityPermissions::buildPermissions`
(via `entity.permissions.yml`) **dynamically generates** permissions for every entity type
that declares an `entity`-provided `permission_provider` handler.

For an entity type `X` with bundles `B` (granularity = `entity_type` or `bundle`):

| Permission | Gates |
|---|---|
| `administer X` (or the type's `admin_permission`) | Full admin over the type (`restrict access`) |
| `access X overview` | The collection/listing page (only if a `collection` link template exists) |
| `view X` / `view B X` | Viewing entities (type- or bundle-wide) |
| `view own unpublished X` | Author viewing their own unpublished entities (owner-aware + publishable types) |
| `create X` / `create B X` | Creating entities (type- or bundle-wide) |
| `update own X` / `update any X` (+ `B`) | Editing own vs any entities (owner-aware types) |
| `duplicate own X` / `duplicate any X` (+ `B`) | Cloning own vs any entities (needs a `duplicate-form` link template) |
| `delete own X` / `delete any X` (+ `B`) | Deleting own vs any entities (owner-aware types) |

Non-owner types get a single `update X` / `delete X` / `duplicate X` (or the bundle variant)
instead of the own/any pair.

`UncacheableEntityPermissionProvider` additionally emits **`view own X`** (and `view own B X`),
which core omits because it forces per-user page caching.

The `EntityAccessControlHandler` enforces exactly these strings, so granting the generated
permission is all that's required — no custom access code.
