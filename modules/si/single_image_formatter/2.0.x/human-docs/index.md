# Single Image Formatter — manual setup guide

**Single Image Formatter** (`single_image_formatter`) adds a field formatter that
displays only the **first** value of a multi‑valued image field. It's the answer
to a common display problem: you want an entity to store several images (a
gallery, a photo set, a slideshow) but, in certain view modes, show just one of
them — a teaser thumbnail, a hero image, a catalog card — without having to change
the field's cardinality or add a separate "main image" field.

The formatter is a thin wrapper around Drupal's core image formatter. It inherits
**all** the normal image display settings — image style, link to content or file,
and so on — and only changes *how many* items render: exactly one, the first. The
field keeps storing all of its values, so other view modes can still show the
full gallery.

The module also ships two optional submodules that apply the same "first value
only" idea to other display types: one for **responsive images** and one for
**media reference** fields (showing the first referenced media item's thumbnail).
There's nothing to configure globally — you just pick the formatter on a field's
Manage display tab.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and pick the submodule you need for responsive or media fields.

## Where it lives in the admin menu

There is no configuration page (`configure` is `null`) and nothing is added to
the admin menu. You choose the formatter per field, on an entity's **Manage
display** tab.

## How to use it

1. Go to the entity's **Manage display** tab — for example
   **Structure → Content types → *your type* → Manage display**, and pick the
   view mode you want (Teaser, Full, etc.).
2. For your multi‑value image field, set the **Format** to **Single image
   formatter** (or **Single responsive image** / **Single media thumbnail** if
   you enabled a submodule).
3. Click the formatter's cog to set the inherited options — image style (or
   responsive image style), whether to link the image to the content or the file,
   and so on.
4. Save. That view mode now renders just the first image; the field's other
   values are untouched and remain available to other view modes.

This lets you reuse a single multi‑image field two ways — a full gallery in one
view mode, a single lead image in another.
