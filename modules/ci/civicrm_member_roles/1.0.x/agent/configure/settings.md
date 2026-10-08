# Settings: sync method and cron batch size

Global behavior lives in the `civicrm_member_roles.settings` config object, edited by
`Form\SettingsForm` at route
`civicrm_member_roles.admin_config_civicrm.civicrm_member_roles_configure`
(`/admin/config/civicrm/civicrm-member-roles/configure`, permission
`access civicrm member role setting`). This is a `ConfigFormBase`; the only editable config is
`civicrm_member_roles.settings`.

## Config keys

| Key | Type | Default (config/install) | Meaning |
|-----|------|--------------------------|---------|
| `sync_method` | sequence of string | `['login']` | Which automatic triggers are active. Any of `login`, `cron`, `update`. Empty = no automatic sync (manual/Drush only). |
| `cron_limit` | integer | `150` | Max memberships processed per cron run. Empty/0 = process all. Prevents cron timeouts. |

`sync_method` values (form `checkboxes`; only checked keys are stored):
- `login` — sync the acting user on login **and** logout (only that one user).
- `cron` — on every Drupal cron run, sync up to `cron_limit` contacts across all rules.
- `update` — sync a contact whenever their CiviCRM Membership record is created/updated
  (via CiviCRM `hook_civicrm_post`).

See [hooks/hooks.md](../hooks/hooks.md) for exactly which hook each value drives.

## Set via Drush / PHP

```bash
# Enable cron sync in addition to login, cap at 200 per run.
drush cset civicrm_member_roles.settings sync_method.0 login -y
drush cset civicrm_member_roles.settings sync_method.1 cron -y
drush cset civicrm_member_roles.settings cron_limit 200 -y
```

```php
$config = \Drupal::configFactory()->getEditable('civicrm_member_roles.settings');
$config->set('sync_method', ['login', 'cron', 'update'])
  ->set('cron_limit', 200)
  ->save();
```

Config schema: `config/schema/civicrm_member_role_rule.schema.yml` types `civicrm_member_roles.settings`
with `sync_method` (sequence) and `cron_limit` (integer).

## Notes

- With `login` only, a newly added rule does not reach existing users until they next log in — run
  a **Manual Synchronize** ([drush/commands.md](../drush/commands.md) or the manual-sync form) once.
- `cron` selects the contact set with a `LIMIT` but no ordering guarantee, so a small `cron_limit`
  on a large member base spreads processing across many cron runs rather than syncing everyone each run.
