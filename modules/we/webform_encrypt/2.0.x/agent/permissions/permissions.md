<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

The module defines exactly one permission (`webform_encrypt.permissions.yml`):

| Permission | Machine name | Gates |
|---|---|---|
| View Encrypted Values in Webform Results | `view encrypted values` | Seeing decrypted submission values, and editing submissions that contain encrypted elements |

Behavior:

- **Without** `view encrypted values`: every encrypted element value is rendered as the
  placeholder string `[Value Encrypted]` (results tables, submission view), and the **update**
  operation on any submission containing an encrypted element is **forbidden**.
- **With** the permission: values are decrypted and shown normally; editing is allowed.

Grant it to a trusted role:

```bash
drush role:perm:add trusted_staff 'view encrypted values'
```

There is no "administer" permission — enabling encryption per element only requires the standard
Webform permission to administer webforms (`administer webform`), since the setting is stored on
the webform config entity.
