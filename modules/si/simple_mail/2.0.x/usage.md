Simple Mail provides two easy helper functions — `simple_mail_send()` and `simple_mail_queue()` — for sending HTML email from custom Drupal code, plus a mail backend and an optional queue that batches messages through cron.

---

The module exposes a minimal API for sending mail without wiring up `hook_mail` yourself. `simple_mail_send($from, $to, $subject, $body)` sends an HTML email immediately via Drupal's mail manager (falling back to the site email when `$from` is empty); `simple_mail_queue($from, $to, $subject, $body)` instead pushes the message onto the `simple_mail_queue` Queue API queue (only when queueing is enabled in config), and a `QueueWorker` plugin (`simple_mail_queue`, 60s cron time) drains it on cron by calling `simple_mail_send()` per item. It registers a `simple_mail` mail backend plugin extending core `PhpMail` that joins the body array and wraps it, and its `hook_mail` sets a `text/html` Content-Type so bodies can contain HTML. A settings form at `/admin/config/system/simple_mail` (route `simple_mail.config`, gated by the core `administer site configuration` permission) offers two options: enable/disable the queue, and an **email override** address. When the override is set, `hook_mail_alter()` re-routes the `to` address of **every** outgoing site email to that address — useful on staging/dev to avoid mailing real users. There are no permissions of its own, no config schema, and no Drush commands. Compatible from Drupal 8 through 11.

---

- Send a one-off HTML email from custom code with a single function call.
- Send transactional emails (confirmations, notifications) without defining `hook_mail`.
- Queue bulk emails so a page request isn't blocked while messages are sent.
- Drain queued emails in batches during cron runs via the built-in queue worker.
- Fall back to the site's configured email address when no `from` is supplied.
- Send HTML-formatted email bodies (Content-Type set to `text/html`).
- Redirect all outgoing site email to a single override address on staging/development.
- Prevent accidental emails to real users in non-production environments.
- Provide a lightweight mail backend for a mail-system configuration.
- Wrap long plaintext bodies for correct line length using core mail formatting.
- Trigger emails from event subscribers, controllers, or hook implementations easily.
- Batch newsletter-style sends through the Queue API instead of sending inline.
- Toggle queueing on or off from the admin settings form without code changes.
- Use as a simple drop-in mail helper on legacy Drupal 8/9 sites and modern 10/11 sites alike.
- Send admin alerts from custom cron jobs or Drush scripts via `simple_mail_send()`.
- Centralize a global email override for QA testing of mail flows.
- Send per-user notifications from a queue populated during content operations.
- Keep custom modules free of boilerplate mail plumbing.
