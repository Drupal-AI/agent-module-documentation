# URL Alias Permissions — agent index

Adds per-entity-type / per-bundle permissions to edit the URL alias (`path`) field, replacing the
all-or-nothing core `create url aliases` gate. Depends on core `path`. No config UI
(`configure` null), no Drush, no plugins, no config schema — it is entirely permissions +
`hook_entity_field_access`.

- **The dynamic permissions, their names, and exactly how field-edit access is decided** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Permission callback `Drupal\url_alias_permissions\UrlAliasPermPermissions::urlAliasPermissions`
  (registered via `permission_callbacks` in `.permissions.yml`).
- Generated names: bundle-granular → `edit <bundle> <entity_type> url alias`
  (e.g. `edit page node url alias`); entity-type-granular → `edit <entity_type> url alias`.
- `hook_entity_field_access` in `.module`: for `edit` op on a `path` field, returns
  `AccessResult::allowedIfHasPermissions($account, [<specific perm>, 'create url aliases',
  'administer url aliases'], 'OR')`; otherwise `neutral`. **Grant-only** — never returns forbidden.
- Access decision is cached per-permissions (`cachePerPermissions()`).
- `update_8001` renamed legacy `edit <type> url alias` → `edit <type> node url alias`.
