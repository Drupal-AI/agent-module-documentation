# Configure field permissions

![Field visibility and permissions section on a field's settings form](../../../../../../../screenshots/field_permissions/1.5.x/field-settings.png)

Set per field, on the **field settings** form (Manage fields → *field* → edit). Requires
the `administer field permissions` permission (and normally `administer <entity> fields`).

## Choose a permission type
A "Field visibility and permissions" section offers the `FieldPermissionType` plugins:
- **Public** — core default; entity-level access applies (no plugin restriction).
- **Private** (`private`) — only the entity author and users with
  `access private fields` may view/edit the value.
- **Custom** (`custom`) — reveals a role × permission grid.

Stored as field-storage third-party settings:
```yaml
# field.storage.<entity>.<field>.yml
third_party_settings:
  field_permissions:
    permission_type: custom   # public | private | custom
```

## Custom permission grid
When type = `custom`, you grant per role:
- `create <field>` — set the value when creating an entity.
- `edit own <field>` / `edit <field>` — edit own vs. any entity's value.
- `view own <field>` / `view <field>` — view own vs. any entity's value.

These permissions are generated dynamically per configured field via the
`permission_callbacks: FieldPermissionsService::getAllPermissions` entry in
`field_permissions.permissions.yml`, so they appear on **People → Permissions**.

## Report
`/admin/reports/fields/permissions` (route `field_permissions.reports`) lists every field
with a non-public type and shows the per-role grant matrix.
