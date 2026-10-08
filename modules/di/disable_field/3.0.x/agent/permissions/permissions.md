<!-- SPDX-License-Identifier: GPL-2.0+ -->
# Permissions

One permission, defined in `disable_field.permissions.yml`:

| Permission | Machine name | Gates |
|---|---|---|
| Administer disable field settings | `administer disable field settings` | Whether the **"Disable Field Settings"** fieldset appears on the field-config edit form and the base-field-override edit form. `restrict access: TRUE` (marked security-sensitive). |

Checked in `ConfigFormBuilder::addDisableFieldConfigFormToEntityForm()`:
`if (!$this->currentUser->hasPermission('administer disable field settings')) { return; }`.

Notes:
- This permission only controls **who can configure** the disable settings. It does **not**
  gate whether a field is disabled on content forms — that is driven purely by the stored
  third-party settings and the editing user's roles (see
  [../configure/disable-field.md](../configure/disable-field.md)).
- Grant it to trusted admin roles only.

Grant via drush:
```bash
drush role:perm:add administrator 'administer disable field settings'
```
