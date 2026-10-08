# Layout Builder Awesome Sections — manual setup guide

**Layout Builder Awesome Sections** (`layout_builder_awesome_sections`) adds
richer, highly configurable **sections** to **Layout Builder**, so you can build
page structure without writing custom layout plugins. It alters core's one‑column
section and adds four more — **Awesome Two column**, **Awesome Three column**,
**Awesome Four column**, and **Awesome Five column** — each with a generous set of
options.

Where core's sections give you a fixed layout and a place to drop blocks, these
sections let a site builder set a **section class**, per‑region **classes** and
**widths**, a **mobile breakpoint**, and per‑region **background colour** and
**padding** — enough to compose real page structure (multi‑column bands,
responsive behaviour, spacing) directly in the Layout Builder UI with no custom
code.

The sections are admin/editor‑configured layout structure; the module adds no
access‑control role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

This module has no separate settings form — each section's options are set on the
section itself inside Layout Builder. See "How to use it".

## Where it lives in the admin menu

Layout Builder Awesome Sections adds no admin settings page. Its sections appear in
the section chooser inside **Layout Builder** — see
[Layout Builder](https://www.drupal.org/docs/8/core/modules/layout-builder).

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Edit a layout in **Layout Builder** (for example **Structure → Content types →
   *(type)* → Manage display** with Layout Builder enabled, or a per‑entity
   layout).
3. Click **Add section** — the new **Awesome Two/Three/Four/Five column** layouts
   appear alongside core's, and core's one‑column section now carries the extra
   options too.
4. Choose a section, then configure its options: the section class, each region's
   class and width, the mobile breakpoint, and per‑region background colour and
   padding.
5. Add blocks to the regions and **Save the layout**.
