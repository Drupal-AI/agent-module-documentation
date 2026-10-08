# EPT Sticky Menu — manual setup guide

**EPT Sticky Menu** (`ept_sticky_menu`) adds a Paragraph type that renders a
sticky in-page menu — a navigation bar that sticks to the viewport as the visitor
scrolls. It's ideal for section navigation on a long landing page, letting readers
jump between sections and always see where they can go.

EPT Sticky Menu is one module in the **Extra Paragraph Types (EPT)** family. Every
EPT module ships one ready-made Paragraph type and shares the
[`ept_core`](https://www.drupal.org/project/ept_core) base module for a common
set of per-instance *design options* — spacing (margins, padding, borders), a
background (color, image with parallax or cover, or a YouTube video), edge-to-edge
or contained width. So there is **no site-wide settings page**: you configure each
menu on the paragraph where you place it. The menu is authored content and the
component plays no access-control role.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and confirm the Paragraph type appears.

There is **no configuration page** for this module. Sticky menus are configured
per instance, on the paragraph itself, using the shared EPT design options
described below.

## Where it lives in the admin menu

EPT Sticky Menu adds no admin settings page. Once enabled it registers a sticky-
menu Paragraph type, listed under **Structure → Paragraphs types**
(`/admin/structure/paragraphs_type`).

## How to use it

Like every EPT component, Sticky Menu is used by placing it inside a **Paragraphs
field**:

1. On a content type that has an *Entity reference revisions* Paragraphs field,
   make sure the field's settings allow the sticky-menu paragraph type.
2. Edit a piece of content — typically a long landing page — add the sticky-menu
   paragraph, and author the menu links (usually pointing at sections further
   down the page).
3. Open the paragraph's **design options** (from `ept_core`) to set spacing,
   background, and width for that specific menu.
4. Save. The menu renders on the page and sticks to the viewport as the visitor
   scrolls.
