# Communico Plus — manual setup guide

**Communico Plus** (`communico_plus`) integrates the **Communico** library‑events
platform with Drupal. Using the Communico v3 REST API, it pulls events (and
reservations) from your Communico account and can **import them as Drupal event
nodes**, as well as display them through blocks and an optional calendar view.

The problem it solves: libraries that manage their events in Communico can surface
those events natively in Drupal — searchable as real content (including by Search
API) and themeable like any node — instead of relying only on an external embed.
On enable/install the module creates an **`event_page`** content type with a full
set of `field_communico_*` fields (event id, dates, image, type, age group,
location, registration URL, and more). It also provides a **connector service**
(`communico_plus.connector`) with methods advanced developers can use to fetch
Communico data directly.

Importing is queue‑driven and depends on the **Queue UI** module (`queue_ui`):
one queue creates/updates event nodes and another removes stale ones, processed
via cron or Queue UI. A cron job also unpublishes `event_page` nodes once their
event end date has passed. The module creates two blocks (a configurable feed
block and a filterable "wall" events display) and can render a single event page
and a reservation page.

It does **not** work until configured: you must enter your Communico API URL and
your **access key** and **secret key**, then run an import. Configuration is gated
by the **administer communico_plus** permission. Note the project is **not covered
by Drupal's security advisory policy**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (and its Queue UI dependency).
2. [Configuration](configuration/index.md) — enter your Communico API
   credentials, run an import, and place the events block.

## Where it lives in the admin menu

- **API configuration** — `/admin/config/communico_plus/api` (in some releases
  reachable as `/admin/config/communico_plus/config`).
- **Import** — `/admin/config/communico_plus/import`.

Both admin forms require the **administer communico_plus** permission. Public
event/reservation pages are served at `/event/{eventId}` and
`/registration/{registrationId}`. See [Configuration](configuration/index.md).
