# Media Default Image — manual setup guide

**Media Default Image** (`media_default_image`) provides a single fallback image
for your whole site, shown wherever a referenced image or media item is missing or
cannot be found. Instead of a broken-image placeholder, visitors see a configured
default image — rendered with the field's full image style, just like a real
image would be. It depends on core's **Media** and **File** modules.

The point of the module is unification: rather than setting a *Default value* on
each individual image field across your content types, you configure one default
image once and it applies as the fallback everywhere. That keeps a consistent
placeholder across the site and saves you from repeating the same setup on every
field. It is a display feature only — it substitutes an image for presentation and
has no access-control role.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

This module has **no dedicated settings page** (`configure` is null). It works as
an image widget/formatter: you select and configure the fallback default image
through the field's display, as described below.

## Where it lives in the admin menu

Media Default Image adds no standalone admin page. You apply it through the field
display settings of your image fields under **Structure → Content types →
*(type)* → Manage display** (and the equivalent *Manage display* on media types),
where its widget renders the configured default image whenever the real image is
missing.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. On the relevant field's **Manage display**, use the default-image widget this
   module provides so the field falls back to the configured default image when no
   image is present or found.
3. Because it applies the field's own image style to the default, the fallback
   looks consistent with the real images in that display — one default image
   serves the whole site without per-field configuration.
