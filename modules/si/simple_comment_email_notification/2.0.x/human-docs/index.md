# Simple Comment eMail Notification — manual setup guide

**Simple Comment eMail Notification** (`simple_comment_email_notification`) sends
the site administrator an email whenever a new comment is posted on the site. It
is meant for small sites where a moderator or owner wants to know about incoming
comments without having to log in and check for them.

The module is deliberately tiny. It does one thing: on a new comment, it emails
the administrator a notice that includes the comment content and links to the
approved and un‑approved comments, and it also writes a log entry you can review
at **Reports → Recent log messages** (`/admin/reports/dblog`). It has **no
settings form and no configuration options of its own** — it works the moment you
enable it, using the site's configured mail system and the administrator's email
address.

Because the notification includes the comment text a visitor typed, be aware that
you are forwarding user‑submitted content by email. That is normal for a
notification tool, but worth keeping in mind if comments can contain sensitive or
unmoderated material. The module has no content or access‑control role — it only
sends alerts.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it. There is nothing else to configure.

## How to use it

Once enabled, the module runs automatically. Post (or have a visitor post) a
comment, and the site administrator receives an email with the comment and links
back to the site's comment moderation. You can confirm it fired by checking the
log at **Reports → Recent log messages** (`/admin/reports/dblog`), where each sent
email is recorded. There is no admin menu entry or settings page to visit.
