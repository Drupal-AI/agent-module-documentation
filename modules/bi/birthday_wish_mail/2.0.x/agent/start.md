<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Birthday Wish Mail (birthday_wish_mail) — agent index

Cron-driven sender of a **templated birthday email** to active users whose configured
date-of-birth field matches today's month-and-day. One admin settings form; no entity, no
permission of its own, no Drush, no plugins. Depends on **`token`**. Core
`^8 || ^9 || ^10 || ^11`. Version 2.0.4. License GPL-2.0-or-later.

- **Config object, settings form, routes, the cron engine, `hook_mail`, tokens, and the log
  table** → [config/settings.md](config/settings.md)

## What it actually is (from source)

- **No controllers, entities, services, or plugins.** All logic lives in procedural hook files:
  `birthday_wish_mail.module` (cron + mail + help), `birthday_wish_mail.tokens.inc` (token
  info/replacements), `birthday_wish_mail.install` (schema/uninstall), and one form class
  `src/Form/BirthdayWishMailSettingsForm.php`.
- **Engine:** `birthday_wish_mail_cron()` (`hook_cron`) selects active users (`status = 1`) whose
  `user__<dob-field>` value LIKEs today's `date("m-d")`, then calls `MailManager::mail()` with key
  `send_birthday_wish_mail` for each, in the user's `preferred_langcode`.
- **Mail:** `birthday_wish_mail_mail()` (`hook_mail`) builds the subject via
  `PlainTextOutput::renderFromHtml()` and the body via `Markup::create()`, running both config
  strings through `Token::replace()` with the `user` account as data; sets a `bcc` header when
  `site_bcc` is configured.
- **Config object:** `birthday_wish_mail.settings_advanced` (keys `bwm_dob`, `site_title`,
  `site_value`, `site_format`, `site_bcc` — see the caveat in the solution doc: the runtime keys
  differ from the shipped schema/install file).
- **Routes:** `birthday_wish_mail.admin` (menu block page) and
  `birthday_wish_mail.settings_advanced` (the form) — both require **`administer site
  configuration`**. `configure` in info.yml → `birthday_wish_mail.admin`.
- **Tokens:** `birthday_wish_mail.tokens.inc` re-declares the standard `user` tokens and a callback
  (`birthday_wish_mail_mail_tokens`) that adds `[user:one-time-login-url]` and `[user:cancel-url]`.
- **DB table:** `birthday_wish_mail` (`pid`, `mail`, `created`) — per-day dedupe log; dropped on
  uninstall.
- **Extension point:** invokes `hook_birthday_wish_mail_users_alter(&$result)` on the recipient
  rowset before sending.
