# Field Image Style — manual setup guide

**Field Image Style** (`field_image_style`) lets content editors choose *which image
style* renders an image, on a per‑entity basis, without a developer touching the
display settings. Normally the image style used for a field is fixed on the *Manage
display* page and applies to every node of that type. This module moves that choice
into the content itself: you add a small "image style" field, the editor picks a
style from a dropdown (for example Small / Medium / Large), and a companion
formatter renders the image using whatever style that entity selected.

It works in two parts. First, a new field type — **Image style** — whose value is
simply the machine name of one of your site's configured image styles; its options
are drawn automatically from the image styles you already have. Second, a formatter
— **Field Image Style formatter** — that you place on an ordinary image field; you
tell it which "image style" field to read, and at render time it applies that
style, falling back to the original image if the editor left the choice empty.

There is no settings page and no permission of its own — everything is configured on
the fields and the display, and it depends only on core's Field and Options modules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

The module is configured entirely on your entity's fields and display. A typical
setup on, say, an Article:

1. **Add (or already have) an image field** — for example `field_hero`.
2. **Add an Image style field** to the same bundle — for example
   `field_hero_style`. On its storage settings you can optionally:
   - **restrict the allowed image styles** to a curated list (leave empty to allow
     all styles), and
   - **sort** the options alphabetically by label.
   The field is forced to hold a single value, so there is no cardinality setting to
   worry about.
3. On **Manage form display**, the image‑style field shows as a select list by
   default (you can switch it to radio buttons using core's *Check boxes/radio
   buttons* widget). This is where editors pick the style.
4. On **Manage display**, set the **image field's** formatter to **Field Image Style
   formatter**, then in its settings choose the image‑style field it should read
   (here, `field_hero_style`). You can also set the usual image‑link option (link to
   content or to the file).

Now each editor picks a style per node, and the hero image renders with it. If they
leave the style empty, the original (unstyled) image is shown. Because the choice
lives in a real field, it is revisionable, translatable, and queryable like any
other content value.
