# Media entity slideshow — manual setup guide

**Media entity slideshow** (`media_entity_slideshow`) lets you build **slideshows
as media entities**. It adds a new core Media **source** called *Slideshow*: a
media type whose "content" is an ordered list of other media items — the slides.
Once set up, a slideshow behaves like any other media (it lives in the Media
Library, has a name and a thumbnail, and can be referenced from content), but
under the hood it's a reusable, orderable collection of images or other media.

The module gives a slideshow media type some sensible built-in behavior: it
counts the slides (a *length* metadata value), auto-names an untitled slideshow
as "N slides, created on <date>", uses the first slide's thumbnail as the
slideshow's own thumbnail, and requires at least one slide before it can be
saved.

One important thing to know up front: this module supplies the *data model* for a
slideshow — it does **not** render a carousel or ship any JavaScript. It's the
foundation. You render the actual slideshow markup yourself with a field
formatter, a View, or a JS carousel library of your choice.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no central settings page. You build a slideshow media type under
**Structure → Media types** (`/admin/structure/media`), then manage its fields
and display there like any other media type.

## How to use it

**Step 1 — Add a slideshow media type.** Go to **Structure → Media types → Add
media type**. Give it a name (for example "Slideshow") and choose **Slideshow**
as the **Media source**. Save.

**Step 2 — Set up the slides field.** Drupal will create or ask for a *source
field* for the slides. Use (or add) a **multi-value entity reference** field —
typically referencing **Media** — and set it as the source field. On the media
type's **Manage fields**, set that reference field's cardinality to *unlimited*
so a slideshow can hold as many slides as you like, and restrict its target
bundles to the slide media types you want to allow (for example your Image media
type).

**Step 3 — Create slideshows.** Now editors can add a *Slideshow* media item,
reference the slides in the order they want, and reuse it anywhere media is
referenced. Each slideshow must contain at least one slide, or saving fails with
"At least one slideshow item must exist."

**Step 4 — Render it.** Because the module doesn't render a carousel itself,
decide how to display the slides: a field formatter on the slides field, a View,
or a JavaScript carousel library you attach in your theme. The module gives you
the ordered slide data to work from.
