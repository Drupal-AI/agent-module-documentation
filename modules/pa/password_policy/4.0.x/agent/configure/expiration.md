# Password expiration

Expiration is built into the core module (no submodule needed). A policy's
`password_reset` value is the max password age in **days** (0 disables it).

Fields added to users (config/install): `field_last_password_reset`,
`field_password_expiration`, `field_pending_expire_sent`.

Flow:
- `password_policy_user_presave()` stamps `field_last_password_reset` when a
  password changes.
- `password_policy_cron()` scans users whose password age exceeds their policy,
  processing at most `cron_threshold` accounts per run
  (`password_policy.settings:cron_threshold`, default 250). It sets the expiration
  field and sends reminder (`send_pending_email` days) and expiry emails
  (`send_reset_email`) via `password_policy_mail()`.
- `PasswordPolicyEventSubscriber` (services.yml, tagged `event_subscriber`,
  optional `@?masquerade`) intercepts requests from expired users and redirects
  them to their own edit form until they set a new password. Masqueraded and
  externally authenticated (externalauth) users are skipped.

Manual force-reset: **Force Password Reset** form at
`/admin/config/security/password-policy/reset` (route `password_policy.reset`,
permission `manage password reset`) expires all passwords for chosen roles.

Adjust throughput: `drush config:set password_policy.settings cron_threshold 500 -y`.
