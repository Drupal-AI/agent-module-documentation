# Permissions

Field Encrypt defines exactly one permission (`field_encrypt.permissions.yml`):

| Permission | Restricted | Gates |
|---|---|---|
| `administer field encryption` | yes (`restrict access: true`) | Every Field Encrypt route (settings form, entity-type settings, profile switch, process-queue, field overview, field decrypt) **and** the "Encrypt field" / properties controls added to the field-storage edit form. |

Notes:

- The encrypt controls on a field-storage form only render if the current user has this
  permission **and** a global `encryption_profile` is set
  (`FieldEncryptHooks::formFieldConfigEditFormAlter`).
- It is a security-sensitive permission (`restrict access: true`) — grant only to trusted
  administrators, since it controls what is encrypted and can trigger decryption of data.
- Grant via role config or drush:
  `drush role:perm:add administrator 'administer field encryption'`.
