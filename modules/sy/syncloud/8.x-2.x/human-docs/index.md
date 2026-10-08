# syncloud — manual setup guide

**syncloud** (`syncloud`) captures events happening on your site — completed
Drupal Commerce orders, webform submissions and contact-form messages — and
pushes them, as structured JSON payloads, over **MQTT** to an external
"biz-panel"/Telegram bridge. In practice it is a notification/integration bridge:
when an order completes or a form is submitted, the relevant data is queued and
published to a remote broker that can, for example, surface it in Telegram or a
back-office panel.

The heart of the module is a **`syn` configuration entity**. Each `syn` entity
maps a local site "type" (such as `commerce_order`, `webform_submission` or a
contact message) to a remote id and MQTT routing metadata. Insert/complete hooks
enqueue the affected entity onto the `syncloud_queue`; a queue processor then
loads the entity, builds a message (order line items, prices and quantities,
billing-profile fields, webform values or contact fields as appropriate) and
publishes it as JSON to an MQTT topic. Developers can reshape the outgoing
payloads with the `hook_syncloud_queue_preprocess_commerce`,
`_webform` and `_contactform` hooks.

The module needs configuration before it does anything: you must enter the MQTT
broker connection details and enable the Telegram integration toggle, then create
the `syn` entity mappings for the events you want forwarded. It depends on core's
Contact module, provides its own permissions (chiefly `administer syn`), and
supports Drupal 9, 10 and 11.

**One important operational caveat.** The route `/syncloud/queue`
(`syncloud.queue`) is declared with open access, so **any anonymous visitor can
reach it**. Its controller does not read request input or return any queue data —
it simply triggers queue processing — but it deliberately waits (`sleep(5)`) and
then processes the queue for up to about 30 seconds, so an anonymous client can
call it repeatedly to force processing and tie up a worker for roughly 5–35
seconds per request. That is an availability/denial-of-service concern, not a
data-exposure one. Front this route with access control at your web server or
proxy, or replace its use with a cron-only trigger. Note too that MQTT
credentials are stored in configuration; keep that configuration out of anywhere
untrusted. The module is currently marked *not covered* by Drupal's security
advisory policy.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the MQTT settings form, the `syn`
   event mappings, and the security notes for the queue route.

## Where it lives in the admin menu

The settings form lives at **`admin/structure/syn`** (the `entity.syn.settings`
route), gated by the `administer syn` permission. That is where you enter the
MQTT broker details, toggle the Telegram integration, and manage the `syn` entity
mappings that decide which events are forwarded. See
[Configuration](configuration/index.md) for the field-by-field walkthrough.
