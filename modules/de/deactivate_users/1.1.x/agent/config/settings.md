<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — settings & mail templates

Everything is stored in the single config object **`deactivate_users.settings`** (schema:
`config/schema/deactivate_users.schema.yml`; install defaults: `config/install/deactivate_users.settings.yml`).
Two admin forms edit it, both routed under `/admin/config/people/deactivate_users` and gated by
**`administer site configuration`** (menu: Configuration → Users → Deactivate Users; tabs defined in
`deactivate_users.links.task.yml` / `.links.menu.yml`).

## Settings form — `DeactivateUsersSettingsForm`

Route `deactivate_users.admin_settings` → `/admin/config/people/deactivate_users/settings`
(`configure` route). Fields (form key → config key):

- `enabled` → `enabled` (int, checkbox) — master switch; cron does nothing unless this is 1.
- `log_notifications` → `log_notifications` (int) — log successful warning emails to the logger.
- `enable_unblock` → `enable_unblock` (int) — expose the `/user/unblock` self-service form.
- `minimum_warning_time_days` → `minimum_warning_time_days` (int) — after first enabling, wait this
  many days before *any* blocking (see cron doc; anchored to state `first_sent_timestamp`).
- `timeout_inactive` → `timeout.inactive` (int, **days**, required) — inactivity limit.
- `timeout_grace_period` → `timeout.grace_period` (int, **days**) — added to the inactivity limit.
- `notify_email_days` → `notify_email.days` (string) — CSV of days-before-expiry to warn, e.g.
  `5, 10, 20`. `validateForm()` requires `^\d+(?:,\d+)*$` after stripping spaces.
- `timeout_changed_record` → `timeout.changed_record` (int, **seconds**, required) — don't block
  users whose account `changed` within this many seconds (avoids re-blocking a just-unblocked user).
- `timeout_unblock_email` → `timeout.unblock_email` (int, **seconds**, required) — lifetime of a
  self-service unblock link.

Note the unit mismatch: `timeout.inactive` / `timeout.grace_period` are **days** (multiplied by
86400 in cron), while `timeout.changed_record` and `timeout.unblock_email` are stored as **seconds**.

## Mail Templates form — `DeactivateUsersMailTemplatesForm`

Route `deactivate_users.mail_templates` → `/admin/config/people/deactivate_users/mail_templates`.
Three `details` groups; every subject/message field supports Token replacement (a `token_tree_link`
element lists `random`, `language`, `current-date`, `site`, `user` tokens). Keys:

- Warning: `notify_email.enabled`, `notify_email.from_address`, `notify_email.subject`,
  `notify_email.message` (use `[user:expire-timeout:days]`).
- Deactivation: `deactivated_email.enabled`, `deactivated_email.from_address`,
  `deactivated_email.subject`, `deactivated_email.message`.
- Unblock: `unblock_email.from_address`, `unblock_email.subject`, `unblock_email.message`
  (use `[user:unblock-link]`). No separate `enabled` flag — it is sent by the generate form.

`validateForm()` only checks the two `from_address` values against `FILTER_VALIDATE_EMAIL` (empty is
allowed → falls back to `system.site` mail). An empty From on send defaults to the site-wide address.

## Install defaults (`config/install/deactivate_users.settings.yml`)

`enabled: 0`, `log_notifications: 1`, `enable_unblock: 1`; `notify_email` enabled with subject
`[site:name] Account Expiring Soon`, `days: '5, 10, 20'`; `deactivated_email` enabled; `timeout`:
`inactive: 90`, `grace_period: 7`, `changed_record: 432000` (5 days), `unblock_email: 86400` (1 day);
`minimum_warning_time_days: 0`. (`hook_update_8001`–`8004` in `.install` backfill these keys plus the
`account_status_record` entity on existing installs.)

## Config export example

```yaml
# deactivate_users.settings
enabled: 1
log_notifications: 1
enable_unblock: 1
minimum_warning_time_days: 14
notify_email:
  enabled: 1
  from_address: ''
  subject: '[site:name] Account Expiring Soon'
  message: 'Your account will deactivate in [user:expire-timeout:days] days.'
  days: '5, 10, 20'
deactivated_email:
  enabled: 1
  subject: '[site:name] Account Expired'
  message: 'Your account has been deactivated for inactivity.'
timeout:
  inactive: 85
  grace_period: 5
  changed_record: 432000
  unblock_email: 86400
```
