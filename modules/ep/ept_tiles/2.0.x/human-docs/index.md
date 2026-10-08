# EPT Tiles — manual setup guide

**EPT Tiles** (`ept_tiles`) adds a ready-made Tiles Paragraph type to your site —
a responsive grid of tiles (also called cards or key items), each with a title,
rich text edited in a WYSIWYG editor, an image, and a link. It's the block you
reach for a services overview, a set of feature boxes, product categories, a team
overview, or a homepage feature row.

EPT Tiles is one module in the **Extra Paragraph Types (EPT)** family. Every EPT
module ships one ready-made Paragraph type and shares the
[`ept_core`](https://www.drupal.org/project/ept_core) base module for a common
set of per-instance *design options* — spacing (margins, padding, borders), a
background (color, image with parallax or cover, or a YouTube video), edge-to-edge
or contained width. So there is **no site-wide settings page**: you configure each
tile grid on the paragraph where you place it.

Worth weighing before you adopt it: a pre-built paragraph type is quick to use and
awkward to diverge from — the markup and field structure are the module's, so a
design the settings don't cover means overriding templates, at which point a
locally defined type may be cheaper. And it becomes a dependency of your content:
removing it later leaves paragraph entities with no type. It's a good fit when you
want a competent grid now without a strong opinion about its markup; less so when
a design system has definite ideas.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and confirm the Paragraph type appears.

There is **no configuration page** for this module. Tile grids are configured per
instance, on the paragraph itself, using the shared EPT design options described
below.

## Where it lives in the admin menu

EPT Tiles adds no admin settings page. Once enabled it registers a **Tiles**
Paragraph type, listed under **Structure → Paragraphs types**
(`/admin/structure/paragraphs_type`).

## How to use it

Like every EPT component, Tiles is used by placing it inside a **Paragraphs
field**:

1. On a content type that has an *Entity reference revisions* Paragraphs field,
   make sure the field's settings allow the **Tiles** paragraph type.
2. Edit a piece of content, add a **Tiles** paragraph, and add each tile with its
   title, text, image, and link.
3. Open the paragraph's **design options** (from `ept_core`) to set spacing,
   background, and width for that specific grid.
4. Save. The tile grid renders at the position of the paragraph in the field.
