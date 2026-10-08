# Image Field Extras — manual setup guide

**Image Field Extras** (`image_field_extras`) adds two extra pieces of metadata
to Drupal's core image field: a **photo credit** and a **caption**. Editors type
them in right beside the uploaded image, they are stored with that image, and they
are rendered alongside it on the page — so the person who took the photo gets
attributed and the picture gets an accessible, translatable caption.

The point is that the credit and caption travel *with* the specific image item.
You don't have to add a separate field for credits and captions and then keep them
in sync by hand; the values are attached per image, and they work even when a field
holds several images. Under the hood the module extends the core image
field, widget and formatter, and caches the extra values (invalidating the cache
by cache tags when they change) so the feature costs almost nothing at display
time. It depends only on core's **Image** module.

This is purely a content/metadata feature. The module adds no routes and no
permissions of its own — whether someone can set the credit and caption is
governed by ordinary field edit access, exactly like the image itself.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form. The
credit and caption simply appear on any image field's widget and output once the
module is enabled, described in "How to use it" below.

## How to use it

Once the module is enabled, its behaviour attaches to image fields automatically:

1. Go to a piece of content (or any entity) that has an image field and edit it.
2. In the image field widget, upload an image as usual. Alongside the standard
   alt/title inputs you'll now find fields for a **photo credit** and a
   **caption**.
3. Fill those in and save. The credit and caption are stored with that image item.
4. View the content: the field formatter renders the credit and caption together
   with the image.

Because the values are stored per image item, a multi‑value image field can carry
a different credit and caption for each picture. Setting these values requires
edit access to the field, just like editing the image itself.
