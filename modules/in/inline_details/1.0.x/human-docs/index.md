# Inline Details — manual setup guide

**Inline Details** (`inline_details`) is a small **text-format filter** that turns
double-bracketed text into a neat inline expandable **details** (disclosure)
element. Wrap some text in `(( ))` inside a rich-text or plain-text field, and the
filter renders it as a `<details>`-style toggle the reader can expand and collapse
— perfect for footnotes, asides, definitions, or "read more" details you want
inline in the flow of a paragraph, without hand-writing any HTML.

It is deliberately minimal: authors only need to remember the `(( ))` shorthand,
and the filter does the rest at render time. Because it is a standard Drupal text
filter, you switch it on per **text format**, so you control exactly which
editing contexts get the feature.

There is no settings form to fill in — the module's only setup is enabling its
filter on the text formats where you want it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no dedicated settings page** for this module — it is configured by
enabling its filter on a text format, described in "How to use it" below.

## Where it lives in the admin menu

Inline Details adds no configuration page of its own. You enable its filter at
**Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`), on each text format where you want the `(( ))`
shorthand to work.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Configuration → Content authoring → Text formats and editors** and edit
   a text format your authors use
   (`/admin/config/content/formats/manage/{format}`).
3. In the **Enabled filters** list, tick the **Inline Details** filter, then save
   the format. (If your format re-orders or restricts HTML, place the filter so it
   runs appropriately relative to those filters.)
4. In content using that format, wrap text in double brackets, for example:

   ```text
   The treaty was signed in 1997 ((and amended twice since — in 2002 and 2011)).
   ```

   The bracketed portion renders as an inline expandable details element the
   reader can open and close.
