# News Ticker — manual setup guide

**News Ticker** (`news_ticker`) provides a configurable, scrolling news-ticker
block for highlighting timely headlines and announcements. You curate news lists
and items, and the module renders them as a reusable block you can place anywhere
in your theme.

The block is built with care for real-world use: it has a responsive layout,
keyboard-focus behavior, pause controls, and respects the visitor's
reduced-motion preference, so the scrolling animation does not become an
accessibility problem. Administrators get design controls for colors, typography,
spacing, scroll speed, icons, and layout. There is even an optional custom-CSS
field, but it is guarded by a strict allowlist sanitizer that rejects selectors,
at-rules, external resources, executable values, escapes, and `!important` — so the
styling stays contained.

It is a straightforward **content-display** module. It provides its own
permissions to control who can manage ticker content, but it has no access-control
role beyond that, and the ticker content is admin/editor-managed. It depends on
Drupal core only and runs on Drupal 10.6 and Drupal 11.3+.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

The ticker's appearance and behavior are configured on the **block** itself when
you place it — see "How to use it" below.

## Where it lives in the admin menu

News Ticker's content and block are managed through standard Drupal screens. You
create and manage news lists/items and place the ticker **block** from **Structure
→ Block layout** (`/admin/structure/block`), where its design controls live in the
block configuration form.

## How to use it

1. Create a **news list** and add the **items** (headlines/announcements) you want
   the ticker to scroll. You will need the appropriate News Ticker permission to
   manage this content.
2. Go to **Structure → Block layout** (`/admin/structure/block`) and click
   **Place block** in the region where the ticker should appear.
3. Choose the **News Ticker** block and, in its configuration, pick the news list
   to display and adjust the design controls — colors, typography, spacing, scroll
   speed, icons, and layout. If you use the optional custom-CSS field, remember it
   is deliberately restricted by an allowlist sanitizer.
4. Save the block. The ticker scrolls your headlines, with pause controls and
   reduced-motion support built in.

## Permissions

Grant the News Ticker permission(s) to the roles that should manage ticker content
at **People → Permissions** (`/admin/people/permissions`). Keep management to
trusted editors, since the ticker is typically placed site-wide.
