# EPT Image — manual setup guide

**EPT Image** (`ept_image`) adds a single-image Paragraph type to your site — a
standalone image component you drop between text sections on a stacked, component-
built page. The image is chosen through a **Media** field, so it comes from your
media library. It also has an optional **image link** field, so the image can act
as a link, and it can be displayed as a thumbnail that opens in a lightbox popup.
If you have the [Link Attributes](https://www.drupal.org/project/link_attributes)
module, you can use its widget on the wrapper link to control link attributes.

EPT Image is one module in the **Extra Paragraph Types (EPT)** family. Every EPT
module ships one ready-made Paragraph type and shares the
[`ept_core`](https://www.drupal.org/project/ept_core) base module for a common
set of per-instance *design options* — spacing (margins, padding, borders), a
background (color, image with parallax or cover, or a YouTube video), edge-to-edge
or contained width. So there is **no site-wide settings page**: you configure each
image on the paragraph where you place it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and confirm the Paragraph type appears.

There is **no configuration page** for this module. Image paragraphs are
configured per instance, on the paragraph itself, using the shared EPT design
options described below.

## Where it lives in the admin menu

EPT Image adds no admin settings page. Once enabled it registers an **Image**
Paragraph type, listed under **Structure → Paragraphs types**
(`/admin/structure/paragraphs_type`).

## How to use it

Like every EPT component, Image is used by placing it inside a **Paragraphs
field**:

1. On a content type that has an *Entity reference revisions* Paragraphs field,
   make sure the field's settings allow the **Image** paragraph type.
2. Edit a piece of content, add an **Image** paragraph, and select an image from
   the media library. Optionally set the image link and enable the
   thumbnail/lightbox display.
3. Open the paragraph's **design options** (from `ept_core`) to set spacing,
   background, and width for that specific image.
4. Save. The image renders at the position of the paragraph in the field.
