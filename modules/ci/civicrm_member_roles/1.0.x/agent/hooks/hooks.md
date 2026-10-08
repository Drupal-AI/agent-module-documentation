# Hooks implemented (sync triggers)

All hooks live in `civicrm_member_roles.module` and are gated by the `sync_method` config
(`civicrm_member_roles.settings`, see [configure/settings.md](../configure/settings.md)). Each
delegates to the `civicrm_member_roles` service ([api/services.md](../api/services.md)).

| Hook | Runs when `sync_method` contains | Effect |
|------|----------------------------------|--------|
| `hook_user_login` | `login` | Syncs the account that just logged in (`syncUser`). |
| `hook_user_logout` | `login` | Syncs the account that just logged out (`syncUser`). |
| `hook_cron` | `cron` | `sync($config->get('cron_limit'))` — syncs up to `cron_limit` rule-covered contacts. |
| `hook_civicrm_post` | `update` | On CiviCRM `Membership` create/update, resolves the membership's contact and calls `syncContact`. Ignores non-`Membership` objects. |

Notes for integrators:
- `login`/`logout` only touch the one user performing the action — they never sweep other users.
  After adding a rule under a login-only config, run a manual/Drush full sync once.
- `hook_civicrm_post` keys on `$objname == "Membership"` and passes `$objref->contact_id` to the
  service; it fires for whoever edits the membership inside CiviCRM.
- These hooks do no work (early return) unless the corresponding `sync_method` value is enabled, so
  the module is inert until at least one method is selected.
