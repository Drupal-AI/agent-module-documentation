# Chunker — manual setup guide

**Chunker** (`chunker`) breaks a long piece of body content into **sections at its
heading boundaries** — automatically, based only on the H2 (or H3) tags an editor
already writes. Editors don't learn any new markup or special tokens: they just
write normal headings, and Chunker restructures the output so each section becomes
something you can collapse, tab through, or paginate. It turns a single long page
into in-page navigation without any manual page-splitting.

Chunker does its work in two steps on display. First it **re-arranges the flat
markup semantically**: instead of a heading simply preceding its paragraphs, the
heading and its content get wrapped together in nesting `<div>`s, so higher-level
sections actually *contain* their subsections. That alone lets you box or indent
sections with CSS to make document structure visible. Second, it can layer **UI
effects** on those sections — collapsible fieldset-style markup, standalone
horizontal or vertical tabs, a JavaScript numeric pager with previous/next buttons,
and optional automatic heading anchors. There's also a **custom mode** where you
choose the wrapper markup and CSS classes yourself, and integration with the
**Field Group** module so page sections can sit alongside field-group tabs or
accordion panels.

You apply all of this from a field's **Manage display** settings — it's a field
formatter, so it can be turned on for any existing body content retroactively, with
no changes to the stored text. It has no module dependencies and no site-wide
settings page. It pairs well with architectures like **Display Suite** and its view
mode switcher, letting you offer both a tabbed view and a plain long-form view of
the same page.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module. You set it up per field on the
entity's **Manage display** tab, described in "How to use it" below.

## Where it lives in the admin menu

The module adds no admin page of its own. You use it from **Structure → Content
types (or any fieldable entity) → *(bundle)* → Manage display**.

## How to use it

1. Make sure your content uses **headings** (H2, and optionally H3) to mark
   section boundaries in the body text — that's what Chunker keys off.
2. Go to the bundle's **Manage display** tab for the view mode you want.
3. For the body (or other long-text) field, choose the Chunker formatter in the
   **Format** column.
4. Open the formatter settings (the gear icon) to pick the behavior — semantic
   chunking only, collapsible fieldsets, horizontal/vertical tabs, the numeric
   pager, heading anchors, or custom markup — then **Update** and **Save**.
5. View a piece of content in that view mode to see the long page split into
   navigable sections.
