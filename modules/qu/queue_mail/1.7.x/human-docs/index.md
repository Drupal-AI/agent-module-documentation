# Queue Mail — manual setup guide

**Queue Mail** (`queue_mail`) changes *when* your site sends email. Normally Drupal
sends each message inline, during the page request that triggered it — so a page that
fires several emails (a registration, a checkout, a notification blast) makes the
visitor wait while every message goes out. Queue Mail intercepts the mails you nominate
and drops them into a queue instead, then sends them later on cron. The triggering page
returns quickly, and email delivery happens in the background.

Enabling the module on its own does nothing — this is important. Queue Mail queues only
the mail IDs you explicitly list on its settings form. You might queue everything (`*`),
or just the User module's mails (`user_*`), or a single message like
`user_password_reset`. Everything else keeps sending immediately. It also handles
failures gracefully: failed sends are retried after a delay, up to a configurable
threshold, after which the message is dropped and logged.

Queue Mail sits alongside — not instead of — mail transport modules like SMTP or
Symfony Mailer. Those decide *how* mail is sent; Queue Mail only decides *when*. It
depends only on Drupal core (9.4+, 10, or 11) and ships one optional submodule,
**Queue Mail Language**, which makes each queued message send in its own language.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module,
   and the optional language submodule.
2. [Configuration](configuration/index.md) — the settings form field by field, how to
   choose which mail IDs to queue, and how to process the queue on cron.

## Where it lives in the admin menu

The settings form is at **Configuration → System → Queue Mail**
(`/admin/config/system/queue_mail`), guarded by the *Administer site configuration*
permission. It shows how many mails are currently queued and lists the mail‑sending
modules on your site to help you pick which IDs to queue.

## How to use it

1. Enable the module.
2. Open the settings form and enter one or more mail IDs (or `*`) to queue.
3. Make sure cron runs regularly, or process the queue on demand with
   `drush queue:run queue_mail --time-limit=15`.

Until step 2 the module changes nothing about how your site sends mail.
