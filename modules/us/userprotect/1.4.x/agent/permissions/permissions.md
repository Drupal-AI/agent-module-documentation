# Permissions

Static permissions in `userprotect.permissions.yml`, plus dynamic per-rule bypass
permissions from `Drupal\userprotect\UserProtectPermissions::permissions()`.

| Permission | Gates |
|---|---|
| `userprotect.administer` | Create/edit/delete protection rules and access the whole `/admin/config/people/userprotect` UI and settings form. `restrict access: true`. Also the entity `admin_permission`. |
| `userprotect.bypass_all` | Holder ignores **all** protection rules. `restrict access: true`. |
| `userprotect.account.edit` | Lets a user edit **their own** account (edit op / `update`) — applied when a user edits itself, since rules never apply to self. |
| `userprotect.mail.edit` | Lets a user change **their own** email address. |
| `userprotect.pass.edit` | Lets a user change **their own** password. |
| `userprotect.{rule}.bypass` | Dynamic, one per saved rule: holders bypass that specific rule. Title "Bypass user protection for {label}". |

Notes:
- User 1 always bypasses every rule regardless of permissions.
- Self-editing is decoupled from rules: when a user edits its own account the module checks the
  `userprotect.*.edit` permissions above (username still uses core's `change own username`;
  cancel uses core's `cancel account`) — see `userprotect_user_access()`.
- Per-rule bypass roles are stored as these permissions: saving a rule writes the bypass
  permission onto the chosen roles (`ProtectionRule::postSave()`), and loading a rule reads
  back which roles hold it (`postLoad()`).

```
drush role:perm:add editor 'userprotect.account.edit'
```
