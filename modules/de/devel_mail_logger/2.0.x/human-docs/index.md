# Devel Mail Logger — manual setup guide

**Devel Mail Logger** (`devel_mail_logger`) is a development and QA tool that
captures every email your Drupal site tries to send and saves it to the
database instead of letting it go out over SMTP. Once it is active, you get a
tidy admin report where you can open any captured message and read its exact
recipient, subject, headers, and body — perfect for checking that a
registration email, password reset, or order confirmation actually contains
what you expect, without risking a real email landing in someone's inbox.

Under the hood it registers a Drupal *mail backend* (a mail plugin called
`devel_mail_logger`). Enabling the module on its own does **nothing** — Drupal
keeps using its normal mail system until you explicitly point the mail system at
this plugin. Once you do, every outgoing message is written to a
`devel_mail_logger` database table and is *not* delivered. You browse the log at
**Reports → Devel Mail Logger**, open a single mail to inspect it, send a test
mail to yourself to confirm the pipeline works, and clear the whole log between
test runs.

Because it swallows real mail, this is strictly a **local/staging tool**. Do not
turn its mail backend on in production, or genuine outgoing email (password
resets, notifications, order receipts) will silently disappear into the database
instead of reaching your users. Think of it as a lightweight, zero-dependency
alternative to Mailhog or Mailpit when you cannot run a separate SMTP catcher.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

Enabling the module is only half the job — you must tell Drupal's mail system to
route mail through the logger. Pick one of these:

- **Globally, via `settings.php`** (simplest for a dev site) — add:

  ```php
  $config['system.mail']['interface']['default'] = 'devel_mail_logger';
  ```

  From now on every message the site sends is captured instead of delivered.

- **Selectively, via the Mail System module** — if you have the
  [Mail System](https://www.drupal.org/project/mailsystem) module installed, set
  the default (or a per-module / per-key) sender to *Devel DB Mail Logger*. This
  lets you capture only some mail keys while others still send normally.

## Where it lives in the admin menu

The captured mail lives under **Reports** (`admin/reports/devel_mail_logger`):

- **Devel Mail Logger** (`admin/reports/devel_mail_logger`) — a paged, sortable
  list of every logged message, with a **Send test mail** link and a delete
  button to clear the whole log.
- **View a single mail** (`admin/reports/devel_mail_logger/mail/{id}`) — the full
  headers and rendered body of one captured message.
- **Send test mail** (`admin/reports/devel_mail_logger/send`) — fires a test
  email to the current user's address so you can confirm the pipeline works.

Three permissions control who can do what, so you can grant testers read-only
access while keeping the ability to send or clear the log to yourself:

- **`devel_mail_logger access logged mail`** — view the list and individual mails.
- **`devel_mail_logger send test mail`** — trigger the test email.
- **`devel_mail_logger delete test mail`** — clear all logged mails.

Set these at **People → Permissions** (`/admin/people/permissions`).
