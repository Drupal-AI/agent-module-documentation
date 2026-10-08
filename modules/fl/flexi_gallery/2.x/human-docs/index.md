# Flexi Gallery — manual setup guide

**Flexi Gallery** (`flexi_gallery`) is an image-field *formatter*: it takes a
multi-value image field and renders it as a flexible gallery — a set of large
images together with a row of smaller thumbnails. Big images can link to the
original file (or to an image-style derivative of it), open in a Colorbox or
Fancybox lightbox, and you can cap how many thumbnails are shown.

Everything Flexi Gallery does happens on a field's **Manage display**. There is
no separate settings page and it adds no admin menu items of its own — you enable
it, pick the **Flexi Gallery** formatter on an image field, and configure the big
and thumbnail image styles, the link behaviour, and the lightbox choice right
there in the formatter settings.

Because it is display-only, it stores no data beyond the formatter settings, adds
no routes or permissions, and reuses core's image-style system to build the
actual image derivatives. Lightbox libraries are attached only when you select a
lightbox that is installed.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it has no settings form. All
setup happens on your image field's display, described in "How to use it" below.

## Where it lives in the admin menu

Flexi Gallery adds no admin page. You use it entirely from **Structure → Content
types → *(your type)* → Manage display**, where you set an image field's format to
**Flexi Gallery**.

## How to use it

1. Add (or reuse) a multi-value **Image** field on a content type — a product
   type, a portfolio piece, an article, anything fieldable.
2. Go to that bundle's **Manage display** and set the image field's **Format** to
   **Flexi Gallery**.
3. Click the gear/cog to open the formatter settings, then configure:
   - **Big image style** — the image style used for the large images.
   - **Thumbnail image style** — a separate, usually smaller, style for the
     thumbnail strip.
   - **Link big images** — leave them unlinked, link to the original file, or
     link to an image-style derivative of the original.
   - **Lightbox** — optionally open big images in a **Colorbox** or **Fancybox**
     lightbox. The relevant module must be installed for that option to do
     anything; the library is only attached when you select it.
   - **Visible thumbnails** — limit how many thumbnails appear (useful for a hero
     image plus a short clickable strip beneath it).
4. Save the display and view a piece of content that has several images in the
   field — you should see the big-image + thumbnail gallery.

> **Tip:** Because it builds derivatives through core image styles, create or
> reuse well-sized image styles first (for example a large "gallery" style and a
> small square "thumbnail" style) so the gallery loads efficiently.
