# Simplenews — manual setup guide

**Simplenews** (`simplenews`) publishes and sends email newsletters to lists of
subscribers. It supports multiple independent newsletters, double opt‑in
subscription for anonymous visitors, per‑newsletter settings (format, from
address, subject, priority), and queued ("spooled") sending that goes out either
immediately or throttled over cron runs.

Simplenews models three things. A **newsletter** is a list or category a
subscriber can join (for example "Weekly digest") — it's a config entity. A
**subscriber** is a person, keyed by their email address, holding the set of
newsletters they've joined. An **issue** is the actual email you send — it's an
ordinary node whose content type has the Simplenews *issue* field attached. You
create newsletters in the admin UI, attach the issue field to the content types
you want to send from, and then each node of that type gains a **Newsletter** tab
for sending.

Sending is deliberately **not inline**. Publishing or activating an issue writes
one row per recipient into a mail **spool**, and a mailer service drains that
spool — either immediately as a batch, or a set number of mails per cron run so
you don't overwhelm your mail server. Who receives an issue is decided by a
pluggable *recipient handler* (the default sends to all active subscribers of the
newsletter).

Simplenews depends on core **Node**, **Field**, **Options**, and **Views**. It
provides its own permissions and Drush commands (`simplenews:spool-send`,
`simplenews:spool-count`). Note one important detail: before you can uninstall
the module you must run its **Prepare uninstall** step, because subscriber data
and fields need to be cleaned up first.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — create newsletters, attach the issue
   field to a content type, set up subscription and sending options, and send
   an issue.

## Where it lives in the admin menu

- **Newsletters** — *Configuration → Web services → Simplenews*
  (`/admin/config/services/simplenews`). This is the module's main configure
  page, where you create and manage newsletter lists.
- **Settings** — under the same Simplenews section, split into *Newsletter*,
  *Subscription*, and *Send mail* settings forms, plus the **Prepare uninstall**
  form.
- **Subscribers** — *People → Subscribers* (`/admin/people/simplenews`), for
  managing, importing, unsubscribing, and exporting subscribers.
- **Per‑issue sending** — the **Newsletter** tab on any node that is a newsletter
  issue (`/node/{node}/simplenews`).

## How to use it

1. Create one or more newsletters at *Configuration → Web services → Simplenews*.
2. Attach the Simplenews **issue** field to the content types you'll send from.
3. Place the **Simplenews subscription block** (or point people at
   `/simplenews/subscriptions`) so visitors can subscribe.
4. Write a node of your issue content type, then use its **Newsletter** tab to
   send a test, send now, or queue it for cron.

See [Configuration](configuration/index.md) for the details of each step.
