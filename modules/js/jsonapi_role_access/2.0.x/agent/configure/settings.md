# Configuration

Single config object `jsonapi_role_access.settings` (schema
`config/schema/jsonapi_role_access.schema.yml`):

| Key | Type | Meaning |
|---|---|---|
| `negate` | boolean | `FALSE` = **Allow** the selected roles (only they pass). `TRUE` = **Restrict** the selected roles (they are blocked). |
| `roles` | sequence of strings | Role ids the mode applies to. Match is ANY-of (role intersection non-empty). |

Default install (`config/install/jsonapi_role_access.settings.yml`):

```yaml
negate: FALSE
roles:
  authenticated: authenticated
```

→ Allow mode + `authenticated` selected = only logged-in users can use JSON:API; anonymous
gets `403`.

## Settings form

- Path: `/admin/config/services/jsonapi/role_access`
- Route: `jsonapi_role_access.config` (also the `configure` link)
- Permission: `jsonapi role access` (title "Access JSON:API role access settings")
- Fields: "Allow / Restrict roles" (radios → `negate`), "User roles" (checkboxes → `roles`,
  required). Form maps radio `0/1` to boolean `negate`.

## Enforcement semantics

`CheckUserRolePermissionEvent::checkUserRoleAccess()` (KernelEvents::REQUEST, priority 30):

```
hasIntersection = current user's roles ∩ configured roles ≠ ∅
if (!negate && !hasIntersection) || (negate && hasIntersection): throw 403
```

Only runs when `_route` starts with `jsonapi` and is not `jsonapi.settings`,
`jsonapi_extras.settings`, or `jsonapi_role_access.config`. It only ever **denies** — core
JSON:API entity/field access still applies on top and is never widened by this module.

## Set via Drush

```sh
drush config:set jsonapi_role_access.settings negate 0 -y
drush config:set jsonapi_role_access.settings roles.editor editor -y
```
