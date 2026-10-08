# Spambot — agent index

Anti-spam for the **user registration form** (and Webforms) using the **Stop Forum Spam**
(www.stopforumspam.com, "SFS") blacklist. Checks email / username / client IP against SFS with
per-criterion thresholds; blocks, delays, and/or logs matches. Also scans existing accounts via
cron and offers a per-user **Spam** tab to report/clean up spammers. Config entity: none — one
settings config `spambot.settings`. Configure route: `spambot.settings_form`
(`/admin/config/system/spambot`).

- **All settings keys, thresholds, whitelists, cron/action options, caching** →
  [configure/settings.md](configure/settings.md)
- **The one permission (`protected from spambot scans`) and who bypasses checks** →
  [permissions/permissions.md](permissions/permissions.md)
- **Programmatic API: `spambot_sfs_request()`, `spambot_account_is_spammer()`, reporting, the Spam tab** →
  [api/functions.md](api/functions.md)
- **The `spambot_registration_blocked` hook fired on a blocked attempt** →
  [hooks/hooks.md](hooks/hooks.md)

Key facts:
- Thresholds default to email=1, username=0 (off), ip=20. A criterion of `0` disables that check.
- Reporting spammers to SFS needs an API key at `spambot.settings:spambot_sfs_api_key`.
- SFS responses are cached in the dedicated `spambot` cache bin (`cache.spambot` service).
- A module-owned table `node_spambot` records each new node's author uid + hostname (IP).
- The `spambot_validation` Webform handler plugin reuses the same checks on any webform.
