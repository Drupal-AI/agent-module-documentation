# Drutopia Storyline — manual setup guide

**Drutopia Storyline** (`drutopia_storyline`) provides "storyline" **Paragraph
types** so editors can lay out a chronology or story in a timeline format — an
"our history" page, a set of milestones, or any continuous narrative. It's a
configuration-only [Drutopia](https://www.drupal.org/project/drutopia) feature
that installs two paragraph types: `storyline_header` (a header/intro paragraph
with `field_storyline_header`) and `storyline_item` (each timeline entry, with a
heading `field_storyline_heading` and body `field_text`). A
`field.storage.node.field_storyline` storage lets a series of storyline
paragraphs be referenced from a node.

The feature includes a bundled submodule, **Drutopia Page Storyline**
(`drutopia_page_storyline`), which uses config actions to add the
`field_storyline` field to the Drutopia
[Page](../../drutopia_page/2.0.x/human-docs/index.md) content type and wire it
into the page's form and full view displays — so a Basic page can carry a
timeline. Enable it only if you want storylines on pages.

Both the main module and the submodule are delivered as default configuration
with no PHP, routes, services or permissions; standard node and paragraph access
applies. They depend on Paragraphs, Entity Reference Revisions, Field Group, and
the Drutopia
[core](../../drutopia_core/2.0.x/human-docs/index.md) and
[page](../../drutopia_page/2.0.x/human-docs/index.md) features.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and optionally enable the Page Storyline submodule.

## Where it lives in the admin menu

There is no settings form. The `storyline_header` and `storyline_item` paragraph
types appear under **Structure → Paragraphs types**
(`/admin/structure/paragraphs_type`). If you enable the submodule, the storyline
field is added to the Page type at **Structure → Content types → Page**
(`/admin/structure/types/manage/page`).

## How to use it

Add storyline paragraphs to a content type's storyline (or paragraph) field: a
`storyline_header` to introduce the timeline, then one `storyline_item` per
entry, each with a heading and body text. Order timeline entries by arranging the
paragraph deltas, and theme `storyline_header` and `storyline_item` separately via
their view displays. If you enabled Drutopia Page Storyline, edit a Basic page and
you'll find the storyline field ready to fill in.
