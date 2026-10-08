# Permissions

Defined in `encrypt.permissions.yml`.

| Permission | Gates |
|---|---|
| `administer encrypt` | Create/edit/delete/test encryption profiles and access the profile collection. `restrict access: true` — trusted only. **Does not** grant the ability to view encrypted data. |

This is also the `admin_permission` of the `encryption_profile` config entity, so it governs
all the profile routes under `/admin/config/system/encryption/profiles`.

Grant via drush:
```
drush role:perm:add administrator 'administer encrypt'
```
Note: this permission controls configuration only — decrypting actual data is done through the
`encryption` service by whatever module consumes a profile, not gated by this permission.
