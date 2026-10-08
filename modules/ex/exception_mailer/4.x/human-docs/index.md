# Exception Mailer — manual setup guide

**Exception Mailer** (`exception_mailer`, sometimes shown as "Error & Exception
Mailer") sends an email whenever an error or exception occurs on your site, so
operators find out about problems promptly instead of discovering them in the logs
days later.

Two features keep it from becoming a nuisance. **Flood protection** is built in, so a
recurring error does not fill your inbox with identical messages. And **filters** let
you exclude specific errors you have decided to ignore, so expected or noisy exceptions
never trigger an email. You choose which error levels (critical, error, warning, and so
on) are worth an email, and who receives them — by role, by specific address, or both.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable
   it.
2. [Configuration](configuration/index.md) — turn emailing on, choose recipients and
   error levels, add excludes, and tune flood protection.

## Where it lives in the admin menu

The settings form is at **Administration → Development → Exception mailer config**
(`/admin/config/development/exception_mailer`).

## How to use it

1. Open the settings form and enable email sending.
2. Choose which roles and/or specific email addresses receive notifications, and which
   error levels are worth an email.
3. Add exclude rules for any errors you want to ignore, and adjust the flood protection
   if the defaults do not suit you.
4. Leave it running; you will get an email when a qualifying error occurs.

> **These emails can contain sensitive information.** An exception notification may
> include a stack trace, internal file paths, query fragments, and surrounding context —
> occasionally values that should not travel in plain email. So direct the notifications
> to a **secure, trusted admin inbox** rather than a shared or external address, treat
> the messages as potentially-sensitive diagnostic output, and use the exclude rules to
> filter out expected exceptions. Keep in mind, too, that an error storm can become an
> email storm — the flood protection and your excludes are what keep that in check.
