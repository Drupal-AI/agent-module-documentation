# EPT Quote — manual setup guide

**EPT Quote** (`ept_quote`) adds a styled Quote Paragraph type to your site — a
pull-quote, a testimonial blockquote, or a highlighted quotation with a citation.
It's a common editorial element that keeps quotes out of the WYSIWYG body and
gives them consistent, themeable styling as a structured component.

EPT Quote is one module in the **Extra Paragraph Types (EPT)** family. Every EPT
module ships one ready-made Paragraph type and shares the
[`ept_core`](https://www.drupal.org/project/ept_core) base module for a common
set of per-instance *design options* — spacing (margins, padding, borders), a
background (color, image with parallax or cover, or a YouTube video), edge-to-edge
or contained width. So there is **no site-wide settings page**: you configure each
quote on the paragraph where you place it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and confirm the Paragraph type appears.

There is **no configuration page** for this module. Quote paragraphs are
configured per instance, on the paragraph itself, using the shared EPT design
options described below.

## Where it lives in the admin menu

EPT Quote adds no admin settings page. Once enabled it registers a **Quote**
Paragraph type, listed under **Structure → Paragraphs types**
(`/admin/structure/paragraphs_type`).

## How to use it

Like every EPT component, Quote is used by placing it inside a **Paragraphs
field**:

1. On a content type that has an *Entity reference revisions* Paragraphs field,
   make sure the field's settings allow the **Quote** paragraph type.
2. Edit a piece of content, add a **Quote** paragraph, and enter the quotation
   and its attribution.
3. Open the paragraph's **design options** (from `ept_core`) to set spacing,
   background, and width for that specific quote.
4. Save. The quote renders at the position of the paragraph in the field.
