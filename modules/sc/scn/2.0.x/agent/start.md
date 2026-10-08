# Simple Comment Notify (scn) — agent index

Sends email/Telegram notifications on each new comment via `hook_entity_insert`. Depends on core `comment`.
One settings form; one permission. No Drush, no plugins, no config schema.

- **All settings keys, recipients, Telegram/proxy, the notification hook** → [configure/settings.md](configure/settings.md)

Key facts:
- Config object `scn.settings`; form route `scn.settings` at `/admin/config/system/scn`, permission
  `administer scn configuration`.
- Trigger: `scn_entity_insert()` fires for `comment` entities; builds body from comment permalink (+ optional
  admin links) and dispatches per enabled recipient.
- Email via mail manager (`scn_mail`, key `new_comment`); Telegram via cURL to `api.telegram.org` (optional
  SOCKS5 proxy).
