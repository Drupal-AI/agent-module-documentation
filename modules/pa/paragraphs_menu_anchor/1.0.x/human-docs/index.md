# Paragraphs Menu Anchor — manual setup guide

**Paragraphs Menu Anchor** (`paragraphs_menu_anchor`) adds an in-page "jump menu"
to pages built from Paragraphs. On a long landing page, documentation page, or
marketing one-pager, you often want a small navigation menu that scrolls the
reader to a given section. This module lets editors pick which paragraphs become
those sections — right in the edit form — and then renders the navigation
automatically. No custom theming or hand-maintained anchors required.

It works in two parts. First, a compound **Paragraph Anchor** field
(`field_pma_anchor`) that you add to your paragraph types: a single field storing
both an "include in the anchor menu" toggle and the link label, so you don't have
to juggle a separate boolean and text field. Second, a **Paragraphs Anchor Menu**
block that scans the current node, collects every paragraph that has the anchor
enabled, and renders the jump links. The block adds a scroll-spy that highlights
the active section as the reader scrolls, an optional native `<select>` for small
screens, and a configurable scroll offset so a sticky header doesn't cover the
target.

The anchor id for each section is generated from its label automatically
(transliterated to ASCII, lowercased, non-alphanumeric characters replaced with
hyphens — so "Plan de Estudios" becomes `plan-de-estudios`). Developers can inject
extra, non-paragraph links via `hook_paragraphs_menu_anchor_links_alter()`. The
module is implemented purely as field plugins and a block — there are no custom
routes or permissions, so access simply follows normal field access and block
visibility. It depends on the **Paragraphs** module and supports Drupal 9 through
11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no central settings page**. Setup is a few steps across Manage fields,
Manage display, and Block layout, described below, plus per-block settings when
you place the anchor menu.

## Where it lives in the admin menu

You configure it in the places you already manage Paragraphs and blocks:
**Structure → Paragraph types → *(type)* → Manage fields** (add the anchor field),
**Manage display** (set its formatter), and **Structure → Block layout** (place
the anchor-menu block).

## How to use it

1. Make sure the **Paragraphs** module is enabled, then enable Paragraphs Menu
   Anchor (see [Installation](installation/index.md)).
2. Go to **Structure → Paragraph types → *(your type)* → Manage fields** and add
   the **Paragraph Anchor** field (`field_pma_anchor`, field type **Paragraph
   Anchor**) to every paragraph type that should be able to appear in the anchor
   menu.
3. In **Manage display** for each of those paragraph types, set
   `field_pma_anchor` to the **Anchor (hidden — used by block)** formatter. The
   field renders nothing itself; the block and a preprocess hook handle the
   output and attach the matching `id` to the paragraph wrapper.
4. Go to **Structure → Block layout** and place the **Paragraphs Anchor Menu**
   block in the region you want (for example a sidebar). In the block settings,
   set the **header CSS selector** (for example `#navbar`) to match your theme so
   scroll-spy accounts for a sticky header's height.
5. Edit a node, open a paragraph, tick **Anchor menu**, and type the link label.
   The block generates the link and the paragraph gets a matching `id`
   automatically.
