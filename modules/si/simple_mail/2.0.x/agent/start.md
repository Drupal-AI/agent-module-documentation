# Simple Mail — agent index

Minimal HTML-email helper: two procedural functions (`simple_mail_send`, `simple_mail_queue`), a
core-`PhpMail`-based backend, and a cron queue worker. Settings at `/admin/config/system/simple_mail`
(`configure` = `simple_mail.config`). No permissions of its own, no config schema, no Drush. Runs on
Drupal 8–11.

- **Config form, the queue toggle, and the global email-override behavior** →
  [configure/settings.md](configure/settings.md)
- **`simple_mail_send()` / `simple_mail_queue()`, the mail plugin, and the queue worker** →
  [api/send.md](api/send.md)

Key facts:
- Config object `simple_mail.settings`: `queue_enabled` (0/1), `override` (email address).
- `hook_mail_alter` reroutes the `to` of **all** site mail to `override` when it's set (dev/staging).
- Mail plugin id `simple_mail` (extends `PhpMail`); `hook_mail` sets Content-Type `text/html`.
- Queue `simple_mail_queue` (QueueWorker, `cron time = 60`) drains queued items via `simple_mail_send`.
