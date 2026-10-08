# Birthday Wish Mail — manual setup guide

**Birthday Wish Mail** (`birthday_wish_mail`) automatically emails a birthday greeting
to users on their birthday. Using a configured birthday field and Drupal's cron, it
checks each day for users whose birthday matches and sends them a templated wish — a
simple way to add a warm, personal touch on a community or membership site without
anyone having to remember to send anything.

It is a user-engagement feature built on the **Token** module, so your greeting
template can include tokens (for example the user's name). The message and the
birthday field it reads are configured in the module's settings.

Two practical notes. First, **privacy**: the module uses users' birthdays (personal
data) and their email addresses, so handle that data in line with your privacy
policy. Second, **cron**: the emails are sent when cron runs, so the module depends
on cron running reliably each day — if cron does not run on a given day, that day's
greetings may be missed. The module has no access-control role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (it depends on the Token module).
2. [Configuration](configuration/index.md) — choose the birthday field, write the
   email template, and make sure cron runs reliably.

## Where it lives in the admin menu

The module's settings — the birthday field it reads and the email template it sends —
are configured in its admin form, and sending happens on **cron**
(`/admin/config/system/cron`).

## How to use it

1. Install and enable the module and the Token module (see
   [Installation](installation/index.md)).
2. Make sure your users have a birthday field, then configure that field and the
   email template (see [Configuration](configuration/index.md)).
3. Ensure cron runs at least daily so the greetings go out on the right day.
