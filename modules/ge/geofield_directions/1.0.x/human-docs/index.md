# Geofield Directions — manual setup guide

**Geofield Directions** (`geofield_directions`) is a small, drop‑in **field
formatter** for Geofield fields. It turns a stored geographic point into a
clickable "get directions" link — so a visitor viewing, say, a shop or venue page
can click through to Google Maps with that location dropped as a pin, ready to get
directions to it. You choose the link text yourself (for example, *Get
Directions*).

There's very little to it, and that's the point: enable the module, then pick the
Directions formatter on your geofield's display. The location comes straight from
the geofield and respects its access, so the module has no access‑control role of
its own. Note that it currently supports **Google Maps** as the only directions
provider, and it's intended for end‑user display (not administrative pages).

It depends on the **Geofield** module and supports a wide range of Drupal
versions (8.8 through 11). It's a likely successor to the old Drupal 7
*Get Directions* module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Geofield dependency.

There is **no central configuration page** for this module. You set it up entirely
on a geofield's *Manage display*, described in "How to use it" below.

## Where it lives in the admin menu

Geofield Directions adds no admin settings page. You use it from **Structure →
Content types → *(your type)* → Manage display**, where it appears as a formatter
option on any Geofield field.

## How to use it

1. Make sure the content type (or other fieldable entity) has a **Geofield** with
   a stored point — a latitude/longitude location.
2. Go to that entity's **Manage display** (for example **Structure → Content
   types → *(type)* → Manage display**), choosing the view mode you want (Default,
   Teaser, and so on).
3. Find your geofield in the list and set its **Format** to the Geofield
   Directions formatter.
4. Open the formatter's settings (the gear/cog icon) to set the **link text** —
   the words the visitor clicks, such as *Get Directions*.
5. Save the display. On the rendered page, the geofield now shows your link; a
   visitor who clicks it is taken to Google Maps with the location pinned so they
   can get directions.
