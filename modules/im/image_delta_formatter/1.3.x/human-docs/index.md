# Image and Media Delta Formatter — manual setup guide

**Image and Media Delta Formatter** (`image_delta_formatter`) adds field
formatters that display only specific *deltas* — that is, specific positions — of
a multi‑value image, responsive image, or media field. Instead of rendering every
value in the field, you can say "show just the first image", "show the second and
third", or "show the most recent one". It's the no‑code answer to pulling one
hero image out of a gallery field, or splitting a multi‑image field across two
regions of a page.

The module provides three formatters, each of which extends the matching core
formatter and adds a **Delta** setting:

- **Image delta** (`image_delta_formatter`) — for `image` fields.
- **Responsive image delta** (`responsive_image_delta_formatter`) — for `image`
  fields, available only when core's **Responsive Image** module is enabled.
- **Media delta** (`media_delta_formatter`) — for media reference fields,
  available only when core's **Media** module is enabled.

Each formatter adds two settings: **Delta**, where you type a single position or a
comma‑separated list such as `0, 1, 4` (positions are zero‑based, so `0` is the
first value); and a **Reversed** checkbox that counts from the last value instead
of the first — so `Delta 0` with **Reversed** on gives you the *last* image. All
the usual options of the underlying formatter (image style, responsive image
style, link, media thumbnail settings) are still available. There is no admin
settings page and no permissions; you configure everything on a bundle's *Manage
display* page. The only dependency is core's **Image** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

The module adds no pages of its own. You use it on the **Manage display** tab of
whatever entity holds the multi‑value field — for example **Structure → Content
types → (your type) → Manage display**
(`/admin/structure/types/manage/article/display`).

## How to use it

1. Go to the bundle's **Manage display** page for the view mode you want (Default,
   Teaser, and so on).
2. Find your multi‑value image or media field, and in its **Format** column choose
   **Image delta**, **Responsive image delta**, or **Media delta**.
3. Click the gear icon to open the settings, then enter the **Delta** — a single
   number like `0` (first value) or a list like `0, 1, 4`. Optionally tick
   **Reversed** to count from the end of the field.
4. Adjust the inherited options (image style, link, etc.) as usual, click
   **Update**, then **Save** the display.

Only the deltas you listed are rendered; everything else in the field is hidden
for that view mode. Because it's configured per view mode, you can show different
positions of the same field in a teaser versus a full page — for instance a single
cover image in listings and the full gallery elsewhere.
