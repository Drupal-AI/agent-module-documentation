# User Email Verification — agent index

Forces email verification after registration while letting the user log in immediately (unlike core).
Unverified accounts are blocked (and optionally deleted) by cron once a time window elapses.
Config UI at `/admin/config/people/user-email-verification` (`configure`
`user_email_verification.settings_form`). Depends on core `user`; Token and Rules are optional.

- **Settings form + all config keys, required core Account-settings changes, the `[user:verify-email]`
  token, cron/queue enforcement, extended period** → [configure/settings.md](configure/settings.md)
- **The `user_email_verification.service` methods, verification link/HMAC scheme, events, cache
  context, and Views/Rules/block plugins** → [api/service.md](api/service.md)
- **The single permission it defines** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Service `user_email_verification.service` (`UserEmailVerificationInterface`) is the entry point for
  everything (create/load/verify/block/delete/remind, URL + HMAC building).
- Data lives in the `user_email_verification` table (uid, verified, last_reminder, reminders, state).
- Verify routes are anonymous: `/user/user-email-verification/{uid}/{timestamp}/{hashed_pass}` and the
  `-extended` variant; `hashed_pass` = `Crypt::hmacBase64($timestamp.$uid, hash_salt.$uid)` — signed
  with the site secret, so links are not forgeable without it.
- Enforcement is via `hook_cron` → queue workers (block / reminders / delete).
