# EPT Text — manual setup guide

**EPT Text** (`ept_text`) is the simplest member of the Extra Paragraph Types
family: it ships a single ready-made Paragraph type — a rich-text block with a
title and a WYSIWYG editor — so a page builder has a proper text component without
anyone hand-building the bundle. It's the workhorse you reach for whenever a
component-built page just needs a body of formatted copy.

EPT Text is one module in the **Extra Paragraph Types (EPT)** family. Every EPT
module ships one ready-made Paragraph type and shares the
[`ept_core`](https://www.drupal.org/project/ept_core) base module for a common
set of per-instance *design options* — spacing (margins, padding, borders), a
background (color, image with parallax or cover, or a YouTube video), edge-to-edge
or contained width. So there is **no site-wide settings page**: you configure each
text block on the paragraph where you place it.

This module is pure configuration — it defines the paragraph type, its field, and
its display, and it ships a Twig template
(`paragraph--ept-text--default.html.twig`) to render it. There's no custom PHP,
no route, and no permission; access is governed entirely by Paragraphs and by the
entity the paragraph is attached to. If you want to restyle it, override that Twig
template in your theme rather than editing the module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and confirm the Paragraph type appears.

There is **no configuration page** for this module. Text blocks are configured per
instance, on the paragraph itself, using the shared EPT design options described
below.

## Where it lives in the admin menu

EPT Text adds no admin settings page. Once enabled it registers a **Text**
Paragraph type, listed under **Structure → Paragraphs types**
(`/admin/structure/paragraphs_type`).

## How to use it

Like every EPT component, Text is used by placing it inside a **Paragraphs
field**:

1. On a content type that has an *Entity reference revisions* Paragraphs field,
   make sure the field's settings allow the **Text** paragraph type.
2. Edit a piece of content, add a **Text** paragraph, and enter a title and the
   body copy in the WYSIWYG editor.
3. Open the paragraph's **design options** (from `ept_core`) to set spacing,
   background, and width for that specific block.
4. Save. The text block renders at the position of the paragraph in the field.
