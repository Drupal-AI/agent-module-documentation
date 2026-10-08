# Responsive Image Field — manual setup guide

**Responsive Image Field** (`responsive_image_field`) defines a new **field type**
for genuine **art‑directed responsive images** — the ability to supply a
*different* image for each breakpoint, not just a resized version of one source.
Core's Responsive Image serves scaled variants of a single uploaded image; this
module lets a content editor hand‑pick a distinct image per breakpoint, so you
can show, say, a wide landscape hero on desktop and a tightly cropped portrait on
mobile.

It builds directly on core's **Responsive Image** system: you still create and
manage **responsive image styles** (which define the breakpoints), and this field
type replaces the source image used at each breakpoint with the one the editor
uploaded. Image selection uses the core **Media Library**, giving editors the
familiar browse‑and‑pick experience.

Because it's a field type rather than a global feature, setup happens in the usual
two places — **Manage fields** (to add the field) and **Manage display** (to
render it) — plus the core responsive image styles admin where the breakpoints
live. There is no dedicated settings screen of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   check the PHP 8.1 requirement, and enable it and its dependencies.

This module has **no settings form of its own**. Its configuration link points to
core's **Responsive image styles** list, and the real setup happens on your
content type's fields and display — see "Where it lives in the admin menu" and
"How to use it" below.

## Where it lives in the admin menu

The breakpoints this field uses come from core's **responsive image styles**,
managed at **Configuration → Media → Responsive image styles**
(`/admin/config/media/responsive-image-style`). Create the responsive image
style(s) you need there first — that's where each breakpoint is defined.

## How to use it

1. **Create a responsive image style** at **Configuration → Media → Responsive
   image styles** if you don't already have one — this defines the breakpoints
   you'll supply images for.
2. Go to your content type's **Manage fields** (for example **Structure →
   Content types → *(your type)* → Manage fields**) and add a new field of type
   **Responsive image** (provided by this module).
3. Configure the field and save.
4. On the same bundle's **Manage display**, set the field's format so it renders
   with the responsive image style you created.
5. When editing content, use the field to pick a **separate image for each
   breakpoint** via the Media Library. Each device size then receives the image
   you chose for it.
