# Simple Mail — manual setup guide

**Simple Mail** (`simple_mail`) provides two easy helper functions —
`simple_mail_send()` and `simple_mail_queue()` — for sending HTML email from custom
Drupal code, plus a mail backend and an optional queue that batches messages
through cron. It is aimed at developers who want to fire off a transactional email
(a confirmation, a notification, an admin alert) without the boilerplate of
defining `hook_mail` themselves.

`simple_mail_send($from, $to, $subject, $body)` sends an HTML email immediately
through Drupal's mail manager, falling back to the site email address when no
`from` is given. `simple_mail_queue(...)` instead pushes the message onto a queue
(when queueing is enabled), and a queue worker drains it on cron — useful for
bulk/newsletter‑style sends so a page request isn't blocked while messages go out.
The module registers a mail backend that sends bodies as `text/html`, so your
messages can contain HTML.

A small settings form offers two options: turn the queue on or off, and set an
**email override** address. The override is a handy staging/development safety net —
when set, it re‑routes the recipient of **every** outgoing site email (not just
Simple Mail's own) to that one address, so you don't accidentally email real users
from a non‑production environment. There are no permissions of its own and no Drush
commands, and it runs on Drupal 8 through 11.

This guide is written for a **human** (here, both a site admin and a developer). If
you want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form (queue toggle and
   email override), plus how to send and queue mail from code.

## Where it lives in the admin menu

The settings form sits at **Configuration → System → Simple Mail**
(`/admin/config/system/simple_mail`), reachable by any user with the **Administer
site configuration** permission.

## How to use it

From custom code, send an HTML email in one call:

```php
simple_mail_send(
  'site@example.com',                    // $from — empty falls back to the site email
  'user@example.com',                    // $to
  'Welcome',                             // $subject
  '<p>Hello <strong>there</strong></p>'  // $body — HTML or plaintext
);
```

Or queue it for cron delivery (only works when the queue is enabled in settings):

```php
$queued = simple_mail_queue('site@example.com', 'user@example.com', 'Digest', $html);
```

See [Configuration](configuration/index.md) for the settings form and more detail
on the queue and the email override.
