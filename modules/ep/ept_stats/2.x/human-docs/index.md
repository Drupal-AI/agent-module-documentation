# EPT Stats — manual setup guide

**EPT Stats** (`ept_stats`) adds a Stats Paragraph type to your site — an "impact"
section built from big numbers with accompanying text or icons, plus a title and
description edited through the WYSIWYG editor. It's the block you use to show
things like *10,000 members* or *98% satisfaction* as a group of key figures.

EPT Stats is one module in the **Extra Paragraph Types (EPT)** family. Every EPT
module ships one ready-made Paragraph type and shares the
[`ept_core`](https://www.drupal.org/project/ept_core) base module for a common
set of per-instance *design options* — spacing (margins, padding, borders), a
background (color, image with parallax or cover, or a YouTube video), edge-to-edge
or contained width. So there is **no site-wide settings page**: you configure each
stats block on the paragraph where you place it.

(If you want a single animated number that counts up rather than a group of static
figures, look at the sibling **EPT Counter** module instead.)

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and confirm the Paragraph type appears.

There is **no configuration page** for this module. Stats blocks are configured
per instance, on the paragraph itself, using the shared EPT design options
described below.

## Where it lives in the admin menu

EPT Stats adds no admin settings page. Once enabled it registers a **Stats**
Paragraph type, listed under **Structure → Paragraphs types**
(`/admin/structure/paragraphs_type`).

## How to use it

Like every EPT component, Stats is used by placing it inside a **Paragraphs
field**:

1. On a content type that has an *Entity reference revisions* Paragraphs field,
   make sure the field's settings allow the **Stats** paragraph type.
2. Edit a piece of content, add a **Stats** paragraph, and enter the figures with
   their text or icons, plus the title and description.
3. Open the paragraph's **design options** (from `ept_core`) to set spacing,
   background, and width for that specific block.
4. Save. The stats block renders at the position of the paragraph in the field.
