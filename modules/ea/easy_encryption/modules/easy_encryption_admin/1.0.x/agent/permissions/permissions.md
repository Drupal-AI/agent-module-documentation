<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

`easy_encryption_admin.permissions.yml` defines one permission:

- **`administer easy encryption keys`** — "Administer Easy Encryption keys": view, import, and export
  Easy Encryption encryption keys. Marked **`restrict access: true`** (a security-sensitive
  permission).

Every route in the submodule requires this permission, except the private-key migration route which
additionally requires a custom access check (`PrivateKeyStorageMigratorAccessCheck` — only granted
when migration is actually needed). Grant it to trusted roles only.

```php
$role = \Drupal\user\Entity\Role::load('security_admin');
$role->grantPermission('administer easy encryption keys')->save();
```
