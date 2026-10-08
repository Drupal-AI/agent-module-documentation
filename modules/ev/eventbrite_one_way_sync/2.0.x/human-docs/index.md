# Eventbrite One-Way Sync — manual setup guide

**Eventbrite One-Way Sync** (`eventbrite_one_way_sync`) pulls events from one or more
Eventbrite accounts into your Drupal site. As the name says, it flows in a **single
direction — Eventbrite → Drupal only** — so Drupal is treated as a read replica of
Eventbrite. It does an initial bulk import and then keeps events up to date through
Eventbrite webhooks. It synchronizes **events only**, not attendees, orders, ticket
classes, or venues.

Under the hood it talks to the Eventbrite v3 REST API
(`https://www.eventbriteapi.com/v3`) over HTTPS, using a **private token per Eventbrite
account**. It handles both single-date events and multi-date/series events, and it is
extensible: the sync itself is built from plugins, so a developer can add custom
processing. Because it only ever reads from Eventbrite and writes into Drupal, there is
no risk of it pushing changes back the other way.

Incoming updates arrive as **webhooks**, which are received through the required
[Webhook Receiver](https://www.drupal.org/project/webhook_receiver) modules — Eventbrite
times out quickly, so processing is deferred. An optional submodule, **Eventbrite
One-Way Sync Node**, maps synced events onto Drupal nodes.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and Webhook Receiver with
   Composer and enable them.
2. [Configuration](configuration/index.md) — add your Eventbrite tokens, point a
   webhook at your site, and optionally map events to nodes.

## Where it lives in the admin menu

This module does **not** add its own configuration page or public routes. Its
connection settings live in `settings.php` / configuration (your Eventbrite tokens and
organization IDs), and incoming webhooks are handled by the **Webhook Receiver**
module's endpoint. See [Configuration](configuration/index.md) for exactly where each
piece goes.

## How to use it

1. Configure one or more Eventbrite private tokens (and organization IDs) as described
   in [Configuration](configuration/index.md).
2. Run the initial bulk import of an organization's events.
3. Point an Eventbrite webhook at your Webhook Receiver endpoint so `event.updated`
   changes flow through automatically.
4. Optionally enable the node submodule and map Eventbrite fields to node fields so
   events appear as content.
5. Use the module's built-in smoke test / self-test to confirm connectivity, and the
   `hook_requirements` check to catch missing tokens or dependencies.

> **Trust boundary.** This module defines no routes of its own — webhook exposure and
> authentication are handled entirely by the Webhook Receiver module, and the Eventbrite
> plugin does **not** independently verify a signature/HMAC on the webhook payload. So
> whatever authentication you configure on Webhook Receiver is the only gate on inbound
> webhooks; configure it carefully. Outbound calls to Eventbrite use HTTPS with normal
> certificate verification.
