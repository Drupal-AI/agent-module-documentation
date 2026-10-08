# Views Send — manual setup guide

**Views Send** (`views_send`) lets you send email to the rows of a View. You
build a View that lists people (or anything with an email address), add its
special *Send email* field, then select rows — or all of them — fill in a
message, and send. It turns any list you can build in Views into a mailing tool:
a subscriber list, everyone in a role, event registrants, a filtered set of
customers, and so on.

Because the recipient list is "whatever your View returns," you get all of Views'
power for free: exposed filters let an operator narrow the list right before
sending, and each message can be personalized with **tokens** drawn from that
row's field values (recipient name, order number, and the like). Row tokens work
even without the Token module; site‑wide tokens need it.

Sending works in two modes. **Direct** send delivers immediately using Drupal's
Batch API — good for small, time‑sensitive blasts. **Spool** send queues the
messages into a table and delivers them on cron, a configurable number per run,
so a large newsletter drips out at a rate your mail provider is happy with, with
automatic retries for failures.

> **A note on trust.** The *mass mailing with views_send* permission effectively
> lets its holder send unlimited outbound email to any address a View can
> surface. Treat it as a high‑impact, administrative capability and grant it only
> to trusted roles.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — the field plugin,
spool/cron behavior, and the Rules events — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and note the optional integrations.
2. [Configuration](configuration/index.md) — build a sending View, understand the
   message form, and tune the global spool/cron settings.

## Where it lives in the admin menu

The global settings form is at **Configuration → System → Views Send**
(`/admin/config/system/views_send`). The mailing itself happens on whatever View
you add the *Send email* field to — there is no single "send" page.

## How to use it

1. Install and enable the module.
2. Build a View over something with email addresses, add a column with the
   recipient email, then add the **Global: Send email** field.
3. Load the View, (optionally filter,) tick the rows you want, and choose **Send
   email**.
4. Fill in the From details, subject, and body — using tokens to personalize —
   and choose direct or spooled delivery.
