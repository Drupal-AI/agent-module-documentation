<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Mailgun sends a Drupal site's outgoing email through the Mailgun HTTP API (via the `mailgun/mailgun-php` library and the Mailsystem module) instead of PHP `mail()`, with optional queued sending, open/click tracking, HTML rendering and per-message tagging.

---

The module registers two Mail plugins — `mailgun_mail` (send immediately) and
`mailgun_queue_mail` (enqueue for cron) — which you select through the **Mailsystem** module as
the sender/formatter for all mail or for specific mail keys. All connection and behavior settings
live in the `mailgun.settings` config object edited at
*Configuration → System → Mailgun* (`/admin/config/services/mailgun/settings`, route
`mailgun.admin_settings_form`, permission `administer mailgun`): the API key and endpoint, the
working domain, `debug_mode`, `test_mode` (log instead of send), open/click tracking, a
`format_filter` text format to render the body, `use_queue` for background sending, `use_theme`,
and `tagging_mailkey`. A companion **Test Email** form (`/admin/config/services/mailgun/settings/test`)
sends a trial message. Queued mail is delivered by the `mailgun_send_mail` cron QueueWorker, and a
Drush `sql-sanitize` hook empties that queue when sanitizing a database. The module ships two
submodules: **Mailgun Email Templates Examples** (ready-made HTML email templates) and
**Mailgun Mailing Lists** (subscribe block + list management). Because it talks to Mailgun's API,
real sending needs a valid API key/domain, but all configuration and plugin wiring is local.

---

- Route all site email through Mailgun instead of the server's PHP `mail()`.
- Send transactional email (password resets, order receipts) via Mailgun's API.
- Queue outgoing email and send it on cron to avoid slowing page requests (`use_queue`).
- Turn on `test_mode` to log messages instead of actually sending during development.
- Enable `debug_mode` to log full Mailgun API request/response for troubleshooting.
- Track email opens and/or clicks per site via the tracking settings.
- Exclude specific mail keys from tracking (e.g. `user:password_reset`) via `tracking_exception`.
- Render HTML emails by choosing a `format_filter` text format for the body.
- Use a site theme wrapper for emails with the `use_theme` option.
- Send only via a specific Mailgun working domain, or derive it from the sender address.
- Route just one mail key (e.g. contact form) through Mailgun and leave the rest on default.
- Tag outgoing messages by mail key for Mailgun analytics (`tagging_mailkey`).
- Send a quick trial email from the admin Test Email form to verify the setup.
- Empty the Mailgun send queue automatically during `drush sql:sanitize`.
- Ship branded HTML emails out of the box with the Email Templates Examples submodule.
- Offer visitors a newsletter signup block backed by a Mailgun mailing list (Mailing Lists submodule).
- Switch mail providers per environment by changing only the Mailsystem/Mailgun config.
- Store the Mailgun API key in an environment variable / Key entity rather than plain config.
- Provide reliable deliverability with SPF/DKIM handled by Mailgun rather than the origin server.
- Centralize outgoing-mail configuration in exported config for deployment.
