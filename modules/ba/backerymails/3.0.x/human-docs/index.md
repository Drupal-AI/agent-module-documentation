# Backery Mails — manual setup guide

**Backery Mails** (`backerymails`) keeps a copy of every email your site sends. It
intercepts messages as they pass through Drupal's mail manager and saves each one as a
stored entity, then gives you a **Views‑based admin list** so you can read exactly what
the site actually sent — subject, body, headers and recipients.

It's useful for debugging transactional email, auditing notifications, or keeping a
searchable archive of outgoing mail during development and QA. Importantly, it
**observes** mail — it saves a copy and then lets delivery continue as normal, so it
doesn't change how your mail is actually sent.

It builds on core **Views** and the contributed **Mail System** module, and registers
itself as a mail plugin that you point your chosen mail formats at. All of its admin
pages require the `administer backerymails` permission, and individual stored messages
have their own per‑entity access check. It runs on Drupal 9.5 and 10.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Views and Mail System.
2. [Configuration](configuration/index.md) — route your mail through it, browse the
   archive, and clear it.

## Where it lives in the admin menu

Backery Mails adds an admin section at **`/admin/config/backerymails`**:

- **Captured mail:** `/admin/config/backerymails/mails` — the Views list of stored
  messages.
- **Settings:** `/admin/config/backerymails/settings` — capture behaviour.
- **Clear:** `/admin/config/backerymails/clear` — purge the whole archive.

All of these require the `administer backerymails` permission.
