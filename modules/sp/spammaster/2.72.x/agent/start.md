# Spam Master — agent index

SaaS-backed anti-spam firewall. Blocks spam registrations/comments/posts via real-time threat
lists from spammaster.org, plus honeypot, IP/email blacklist ("buffer"), whitelist, and flood
control. Needs a (free or pro) Spam Master license — auto-created on install. Requires no other
contrib modules. One permission (`restrict access: TRUE`); no Drush.

- **Admin forms, config objects/keys (protection, buffer, whitelist, cleanup schedules), enabling
  firewall/honeypot/flood control, license key** → [configure/settings.md](configure/settings.md)
- **Runtime architecture: the firewall event subscriber, license/action services, SaaS endpoints,
  the `/firewall` & `/spam-master/v1` routes, DB tables** → [api/services.md](api/services.md)
- **The `manage spam master` permission and the admin routes' access** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts:
- `configure` route `spammaster.settings` → `/admin/config/system/spammaster`; 5 forms all behind
  core `administer site configuration`.
- Firewall only enforces when license status ∈ {VALID, MALFUNCTION_1, MALFUNCTION_2} AND
  `spammaster.settings:subtype === 'prod'`.
- Random per-install license key (`spammaster.settings:license_key`) + rotating
  `state: spammaster.spam_master_db_protection_hash` authenticate all SaaS traffic.
- DB tables: `spammaster_threats` (buffer blacklist), `spammaster_white` (whitelist),
  `spammaster_keys` (logs, exempt rules, flood counters).
- SaaS host: `https://www.spammaster.org/core/...` (license + learn/action endpoints).
