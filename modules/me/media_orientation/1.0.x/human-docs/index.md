# Media Orientation — manual setup guide

**Media Orientation** (`media_orientation`) works out whether an image media item
is **portrait**, **landscape**, or **square**, and makes that orientation
available to work with — most usefully as a **Views filter**. Layouts often need
to treat tall and wide images differently (a masonry grid, a hero that only suits
landscape, a portrait‑only staff list), and the orientation is implicit in every
image but not otherwise exposed anywhere convenient to filter or theme on. This
module surfaces it.

You tell it which field on your image media type stores the orientation, and it
keeps that field populated. Because the obvious use is filtering — "show only
landscape media", "group portraits separately" — it depends on **Views Filter
Select**, which turns the orientation into a clean exposed select filter rather
than a free‑text field. That pairing is the point: orientation as data, plus a
tidy way to filter on it, for example in the Media Library view.

It's a small, focused building block. On its own it provides the classification
and the filtering hook, not a finished gallery — what it does on a given site
depends on how you wire the orientation into your displays and views. It also
ships a Drush command to backfill orientation on media that already exists.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   (with its Views Filter Select dependency).

There is **no central settings page**. You configure the module by choosing the
orientation field on your media type — described under "How to use it" below.

## Where it lives in the admin menu

The module adds no standalone settings form. You wire it up on your media type at
**Structure → Media types → *(your image type)* → Edit**, and use the orientation
in **Structure → Views**.

## How to use it

1. Make sure you have a **media Image type** and that both Media and this module
   are enabled.
2. On that media type, create a **list (integer) field** with these allowed
   values, which the module uses to record orientation:

   ```
   1|Landscape
   2|Portrait
   3|Square
   ```

3. On the media type's configuration page, **select that list field for Media
   orientation**. The module will now populate it as media is saved.
4. Use the orientation in your displays: adapt the **Media Library view** (or your
   own media view) to expose it as a filter — the Views Filter Select dependency
   turns it into a clean select dropdown — and/or show it on the form/display.
5. To add orientation to **existing** media (created before you set this up), run
   the module's Drush command for the relevant bundle, for example:

   ```bash
   drush mo:resave image
   ```

   This re‑saves all media of that bundle so the orientation value is calculated
   and stored.
