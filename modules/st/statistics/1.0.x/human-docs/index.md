# Statistics — manual setup guide

**Statistics** (`statistics`) counts how many times each piece of content is
viewed. For every node it keeps three numbers: an **all‑time total**, a **daily
count** that resets every 24 hours, and the **timestamp** of the most recent
view. From those it can show a "N views" counter under your content, power a
"Popular content" block, and even nudge frequently‑viewed pages higher in search
results.

This is the Statistics module that used to be part of Drupal core (up to Drupal
10). It now ships as a contributed module for Drupal 10.3 and 11. If you're
upgrading a site that relied on the core version, this is its replacement.

Counting is deliberately **off by default** — you turn it on with a single
checkbox. Once on, a view is recorded when someone loads a node's full page in a
browser: a small piece of JavaScript quietly reports the view back to the site.
That approach means teaser and listing renders, previews, and bot traffic that
doesn't run JavaScript generally aren't counted, giving you a reasonable picture
of real page views.

Beyond the counter, Statistics ships a **"Popular content"** block (today's top,
all‑time top, and most‑recently‑viewed lists), Views fields so you can add view
counts as columns and sort by them, and replacement tokens like
`[node:total-count]`. All the numbers are read and written through a single
swappable storage service, so an advanced site can redirect them to an external
analytics backend.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — turn counting on, set the display
   cache, place and tune the "Popular content" block, and grant the two
   permissions.

## Where it lives in the admin menu

The settings form is at **Configuration → System → Statistics**
(`/admin/config/system/statistics`), reachable by users with the **Administer
statistics** permission. The "Popular content" block is placed from **Structure →
Block layout** (`/admin/structure/block`).

## How to use it

1. Enable the module.
2. Open the settings form and tick **Count content views** — nothing is counted
   until you do.
3. Optionally grant **View content hits** to the roles who should see the "N
   views" link, place the "Popular content" block, and add the Views fields to
   any content listing.
