# Content Freshness Indicator — manual setup guide

**Content Freshness Indicator** (`content_freshness`) shows a small, color‑coded
badge on content telling readers — and editors — how fresh or stale a page is,
based on when it was last updated. At a glance you can see whether an article is
current or overdue for review, which turns "we should audit this content someday"
into something visible on every page.

The badge has three tiers: **Fresh** (green), **Aging** (yellow), and **Stale**
(red). You set the day thresholds that separate the tiers, both globally and
per content type, so a fast‑moving news type can go stale in weeks while a
reference page stays fresh for a year. The badge also shows relative time (for
example "Updated 3 days ago") and is built to be accessible, with ARIA labels.

The badge is exposed as a **pseudo‑field** on the entity's display, so you place
it through **Manage display** wherever you want it to appear. This is a
**needs‑config** module: after enabling it you set thresholds, choose which
content types show the badge, and position it on the display. It depends only on
Drupal core's **Node** module and runs on Drupal 10, 11, and 12.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set thresholds, enable content types,
   and position the badge.

## Where it lives in the admin menu

The settings form is at **Administration → Configuration → Content → Content
Freshness Indicator**. The badge itself is placed per content type through
**Structure → Content types → *(type)* → Manage display**.
