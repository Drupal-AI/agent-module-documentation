# Drush command

Provided by `civicrm_member_roles.drush.inc` — a **legacy Drush command file**
(`hook_drush_command` / `.drush.inc` style). This registration format works on Drush 8 but was
removed in Drush 9+, so on modern Drush the command may not appear. If `drush cmrs` is not found,
use the **Manual Synchronize** form (route
`civicrm_member_roles.admin_config_civicrm.civicrm_member_roles_manual_sync`,
`/admin/config/civicrm/civicrm-member-roles/manual-sync`), which runs the same
`civicrm_member_roles.batch.sync` batch.

| Command | Alias | Options | Behavior |
|---------|-------|---------|----------|
| `civicrm-member-role-sync` | `cmrs` | `--uid`, `--contact_id` | Sync memberships → roles. |

Callback: `drush_civicrm_member_roles_civicrm_member_role_sync()`.

- `--uid=<n>` — sync just that Drupal user (`CivicrmMemberRoles::syncUser()`). Errors if the user
  cannot be loaded.
- `--contact_id=<n>` — sync just that CiviCRM contact (`getContactAccount()` then `syncContact()`).
  Errors if no Drupal user is linked to the contact.
- no option — build the full sync batch (`civicrm_member_roles.batch.sync`), set `progressive`
  FALSE, and run it via `drush_backend_batch_process()` (syncs every contact holding a
  rule-covered membership type).

Examples (from the command definition):

```bash
drush civicrm-member-role-sync --uid=8
drush civicrm-member-role-sync --contact_id=89
drush cmrs          # full batch sync of all rule-covered contacts
```

Use the full sync after bulk membership imports or after adding a rule, rather than waiting for cron.
