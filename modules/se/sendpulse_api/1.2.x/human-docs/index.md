# Sendpulse — manual setup guide

**Sendpulse** (`sendpulse_api`) connects your Drupal site to the **SendPulse**
cloud marketing platform through its API, so you can manage email, SMS and push
notifications from one place. From Drupal you add your SendPulse credentials,
enable the SendPulse lists you want, and then surface them as signup blocks,
webform targets, content fields, or an optional REST endpoint.

Each enabled list becomes usable in several ways: as a **block** you can place on
a page, as a target for a **Webform handler** (so submissions add subscribers), as
a **content‑type field**, and — if you enable core REST — as a **REST endpoint**
for sending signups. Behind the scenes the module authenticates to SendPulse with
an API user ID and secret and calls the SendPulse API to sync contacts and manage
subscriptions.

Because the module sends contact data (personal data) and messages out to
SendPulse, treat that egress as your privacy policy requires, and store the
SendPulse API credentials as secrets — in `settings.php` (env‑backed) or a Key
entity — over HTTPS, never committed to code. The module provides its own
permissions but has no access‑control role beyond them. It runs on Drupal 9.4, 10,
and 11, and is not covered by Drupal's security advisory policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and enable the Block/REST modules you need.
2. [Configuration](configuration/index.md) — add your credentials, enable lists,
   and wire up blocks, webform handlers, and fields.

## Where it lives in the admin menu

Once enabled, the settings form is at **Configuration → Web services → Sendpulse**
(`admin/config/services/sendpulse-api`), with the list‑management screen at
`admin/config/services/sendpulse-api/lists`.
