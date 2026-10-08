# Permissions

Permissions are generated dynamically, one per eligible entity type, by
`AutoEntityLabelPermissionController::autoEntityLabelPermissions()` (declared via
`permission_callbacks` in `auto_entitylabel.permissions.yml`).

- `administer <entity_type> labels` — one permission per entity type that has both an
  `auto-label` link template and a `label` key, e.g. `administer node labels`,
  `administer taxonomy_term labels`, `administer media labels`. Grants access to that entity
  type's **Automatic label** configuration tab. Flagged `restrict access` (trusted roles
  only).

There is no single global permission — access is delegated per entity type, so you can let a
role configure automatic labels for media but not for nodes, for example.
