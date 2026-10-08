# Nameday (Slovak & Hungarian) — manual setup guide

**Nameday (Slovak & Hungarian)** (`nameday_skhu`) provides **Slovak** and
**Hungarian** name‑day data — the traditional name‑day calendar for those
locales — and exposes it as blocks so a Central European site can show today's
(or a given date's) name day as a cultural calendar feature.

Beyond the ready‑made blocks, the module also offers a small service that
developers can call to look up the name day for any locale and date, which makes
it a handy building block for custom features. It is a lightweight
display/calendar feature with no content or access‑control role of its own, and
it works on Drupal 9, 10, and 11.

There is no settings page — you use it either by placing a block or by calling
the service from custom code, both described below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — you place a block or call
its service, described in "How to use it" below.

## How to use it

**As a block:**

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Click **Place block** in your chosen region and select the Slovak or Hungarian
   nameday block.
3. Set the usual block visibility options and save.

**From custom code (developers):** the module registers a `nameday` service you
can call to look up a name day for a locale and date, for example:

```php
$nameday_service = \Drupal::service('nameday');
$nameday = $nameday_service->nameday('hu', '2017', '04', '10');
```

Pass `'hu'` for Hungarian or `'sk'` for Slovak, along with the year, month, and
day you want to look up.
