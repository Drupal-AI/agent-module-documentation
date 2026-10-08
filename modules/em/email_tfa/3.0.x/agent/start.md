<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Email TFA — agent index

Email-based two-factor auth: after login the user is emailed a one-time numeric code and must
verify it at `/tfa/verify/{uid}/{hash}`. Overrides the core `user.login` form + `user.login.http`
REST endpoint. All state is the config object `email_tfa.settings`. Requires `hash_salt` in
`settings.php`. No Drush, no custom plugin types.

- **All settings keys (status, tracks, roles, code length, timeout, flood, email subject/body, dev mode), config route, drush cget/cset** →
  [configure/settings.md](configure/settings.md)
- **How the flow works: route override, one-time code, tempstore/hash, verify route, mail token, user opt-in base field, block, gin_login** →
  [api/flow.md](api/flow.md)
- **The `administer email tfa` permission and the per-user `email_tfa_status` field** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts: config object `email_tfa.settings` — `status` (bool, default FALSE),
`tracks` (`globally_enabled` | `optionally_by_users`), `role_exclusion_type`
(`disable_for` | `force_for`) + `ignore_role` list, `user_one` (exclude user 1),
`security_code_length` (4–9, default 4), `timeouts` (seconds, min 60, default 300),
`dev_mode`, `log_events`, `flood_threshold` (5) / `flood_window` (3600), `subject` / `body`
(uses `[user:email_tfa]` token). Config UI route `email_tfa.settings` at
`/admin/config/people/email-tfa`. hook_mail key `send_email_tfa`.
