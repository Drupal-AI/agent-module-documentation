# Image Comparison Slider Formatter — manual setup guide

**Image Comparison Slider Formatter** (`ics`) adds a **before/after slider**
formatter to image fields. When a multi‑value image field holds two images, the
formatter renders them as an interactive comparison slider — the visitor drags a
handle left and right to reveal one image over the other. It's a natural fit for
renovation photos, photo edits, and any "before and after" comparison.

The formatter is powered by the **Image Comparison Slider** JavaScript library,
which you install alongside the module (see [Installation](installation/index.md)).
A companion submodule, **Image Comparison Slider for Media**, lets you use the
same effect with Media entities of type Image. The module depends only on core's
**Image** module.

This module has **no settings page of its own** — you configure it entirely on a
field's *Manage display*, described in "How to use it" below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   install the JavaScript library, and enable it.

There is **no configuration page** for this module — it has no settings form. The
setup happens on your image field's display, described below.

## Where it lives in the admin menu

Image Comparison Slider Formatter adds no admin page. You use it from **Structure
→ Content types → *(your type)* → Manage display**, by choosing its formatter for
an image field.

## How to use it

1. Add or reuse a **multi‑value image field** on your content type (the slider
   needs at least **two** images to compare).
2. Go to that content type's **Manage display**, find the image field, and set
   its format to **Image Comparison Slider**.
3. Create/edit content and **upload at least two images** to the field. The front
   end renders them as a draggable before/after slider.

> **Tip:** to use the effect with Media reference fields, enable the **Image
> Comparison Slider for Media** submodule and pick its formatter on a Media
> (Image) reference field instead.
