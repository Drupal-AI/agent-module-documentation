# Maillog / Mail Developer — manual setup guide

**Maillog / Mail Developer** (`maillog`) captures a copy of every outgoing email
in a database table so you can inspect exactly what your site sends — and,
crucially, it can **suppress real delivery** so a development or staging site never
emails real users. It's the go-to tool for debugging registration emails,
password resets, contact forms, and webform notifications without needing a real
mail server.

When you enable it, Maillog installs its own core Mail plugin and makes it the
site's default mail backend. From then on, every mail Drupal tries to send is
formatted exactly as core normally would, then — depending on your settings —
stored in the `maillog` table, optionally dumped on-screen for authorized users,
and only actually delivered if you've left delivery turned on. You browse the
captured messages, with full headers and body, through a bundled report at
**Reports → Maillog** (`/admin/reports/maillog`).

The most common setup is on a cloned production environment: turn delivery off so
you can't accidentally spam your customer list, but keep logging on so you can
still verify what *would* have been sent. Options let you trim stored bodies,
strip large base64 blobs, notify visitors when delivery is off, and automatically
prune old log entries on cron. A Drush command (`drush maillog:clear`) wipes the
log in one step.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (it depends on core Views).
2. [Configuration](configuration/index.md) — the settings form field by field,
   delivery suppression, cron cleanup, permissions, and the `maillog:clear`
   command.

## Where it lives in the admin menu

Two places. The captured emails are listed at **Reports → Maillog**
(`/admin/reports/maillog`), where you can open each message or delete it. The
settings form lives at **Configuration → Development → Maillog Settings**
(`/admin/config/development/maillog`).

## How to use it

1. Enable the module — it immediately becomes the active mail backend, and by
   default it logs every mail while still delivering it.
2. On a dev or staging site, open the settings form and turn **Send mails** off so
   nothing reaches real inboxes.
3. Trigger an email on the site (register a user, request a password reset, submit
   a contact form).
4. Go to **Reports → Maillog** to read the captured message — its recipients,
   subject, headers, and body.
5. When you're done, clear the log from the settings form's "Clear all maillog
   entries" button or with `drush maillog:clear`.

To restore normal PHP mail delivery, simply uninstall the module — it puts the
default mail interface back to `php_mail`.
