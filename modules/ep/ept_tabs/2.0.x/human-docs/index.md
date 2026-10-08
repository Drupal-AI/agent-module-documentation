# EPT Tabs — manual setup guide

**EPT Tabs** (`ept_tabs`) adds a ready-made Tabs Paragraph type to your site,
built on the jQuery UI Tabs plugin. What sets it apart from a plain text accordion
is what each tab can hold: formatted text, other paragraphs, a whole page, an
embedded **View**, or a placed **block**. That makes it a real page-composition
tool — a product page with *Description*, *Specifications*, and a *Reviews* view;
a department page with *Overview*, a *Staff* listing, and a *Contact* block. It
ships several tab styles: without a header background, minimalist, tabs-as-buttons,
vertical, and vertical rotated.

EPT Tabs is one module in the **Extra Paragraph Types (EPT)** family. Every EPT
module ships one ready-made Paragraph type and shares the
[`ept_core`](https://www.drupal.org/project/ept_core) base module for a common
set of per-instance *design options* (spacing, background, container width). So
there is **no site-wide settings page**: you configure each tab set on the
paragraph where you place it.

Two things to weigh. The tabs are built on **jQuery UI**, which was removed from
Drupal core and now lives in contrib modules maintained on a best-effort basis —
so this component depends on a library the wider project is moving away from
(though jQuery UI's tabs are one of its more accessible pieces). And, as with any
tab set, inactive panels are still rendered and present in the DOM: an embedded
View in a tab nobody opens is still executed, which costs query time.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and confirm the Paragraph type appears.

There is **no configuration page** for this module. Tab sets are configured per
instance, on the paragraph itself, using the tab style options plus the shared EPT
design options described below.

## Where it lives in the admin menu

EPT Tabs adds no admin settings page. Once enabled it registers a **Tabs**
Paragraph type, listed under **Structure → Paragraphs types**
(`/admin/structure/paragraphs_type`).

## How to use it

Like every EPT component, Tabs is used by placing it inside a **Paragraphs
field**:

1. On a content type that has an *Entity reference revisions* Paragraphs field,
   make sure the field's settings allow the **Tabs** paragraph type.
2. Edit a piece of content, add a **Tabs** paragraph, and add each tab — choosing
   whether it holds text, a View, a block, or other content — then pick a tab
   style (minimalist, buttons, vertical, and so on).
3. Open the paragraph's **design options** (from `ept_core`) to set spacing,
   background, and width for that specific tab set.
4. Save. The tabs render at the position of the paragraph in the field.
