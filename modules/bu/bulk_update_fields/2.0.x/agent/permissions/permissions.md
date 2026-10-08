<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Defined in `bulk_update_fields.permissions.yml`:

| Permission (key) | Gates | `restrict access` |
|---|---|---|
| `administer bulk_update_fields` | The update form/action at `/admin/bulk_update_fields` (route `bulk_update_fields.form`). | TRUE |
| `exlude bulk_update_fields` | *(intended)* the exclude form. | TRUE |

Both are marked `restrict access: TRUE` (shown as security-sensitive on the permissions page).

## Gotcha: exclude-permission name mismatch

The permission **key** is misspelled in `permissions.yml` as `exlude bulk_update_fields` (missing the
first "c"), but the exclude-form route (`bulk_update_fields.bulk_update_exclude_form`) requires
`_permission: 'exclude bulk_update_fields'` (correct spelling). Because the required permission name
does not match any defined permission, **no role can be granted it** through the UI, so in practice only
user 1 (who bypasses access checks) can reach `/admin/bulk_update_fields/exclude`. If you need other
roles to configure the exclude list, either patch the typo in `permissions.yml` or grant access another
way. This is a real bug in the shipped 2.0.x code, not a documentation artifact.

Grant the working permission with:

```bash
drush role:perm:add editor 'administer bulk_update_fields'
```
