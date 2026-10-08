# Configuration

Simple Mail has a small settings form with two options, plus a couple of things
worth knowing about how it sends mail.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → System → Simple Mail**
   (`/admin/config/system/simple_mail`).

## The two settings

- **Simple Mail Queue** — a Disabled / Enabled toggle. While it is **Disabled**,
  calls to `simple_mail_queue()` do nothing and return false. While it is
  **Enabled**, those calls add the message to the `simple_mail_queue` queue, which
  is drained on cron (up to roughly 60 seconds of work per cron run) by sending each
  queued message. Turn this on for bulk/batch sends so a page request isn't blocked
  while messages go out.
- **E‑mail override address** — when this is set to an address, the module rewrites
  the recipient of **every** outgoing site email to that address. Leave it **empty
  in production**.

Save the form when you are done.

## The email override — a staging/dev safety net

The override applies to **all** mail on the site, not just messages sent through
Simple Mail's own functions. That makes it a global capture of outbound email:

- On a **staging or development** environment, set it to a mailbox you control so
  QA can see the messages and no real user is ever emailed by mistake.
- In **production**, leave it blank so mail reaches its real recipients.

If you manage config per environment, set the override only in your non‑production
config so it never leaks to live.

## How Simple Mail sends (good to know)

- The module's mail backend extends core's PHP mailer and sends bodies as
  **`text/html`**, so your message bodies can contain HTML.
- `simple_mail_send()` sends immediately; `simple_mail_queue()` defers to cron (when
  the queue is enabled). Both take the same `($from, $to, $subject, $body)`
  arguments, and an empty `$from` falls back to the site's configured email address.
- The module does **not** automatically make itself the site‑wide default mailer.
  Its helper functions route through its own backend directly. If you want another
  module's mail keys to use this backend too, assign them to the `simple_mail`
  plugin in your mail‑system configuration.
- The message body is sent as‑is (as HTML) — the module does not sanitize it, so
  the calling code is responsible for the content it passes.
