# Paragraphs Table of Contents — manual setup guide

**Paragraphs Table of Contents** (`ptoc`) generates an in‑page table of contents (ToC)
for long pages that are built with the **Paragraphs** module. There is one link in the
contents list for each paragraph on the page, and each link jumps to the corresponding
section. Because the contents list is generated from the **paragraph structure**, it
stays in step with the content: the structure *is* the data, so the list is simply a
rendering of it and cannot drift out of sync the way a hand‑maintained list or one
parsed from body‑field headings would.

The module is deliberately simple — its author describes it as close to a proof of
concept. It works mostly through configuration: it ships the paragraph types and view
modes, plus a View that builds the ToC block, with a small amount of custom code that
adds `id` attributes to sections and themes the ToC entries as in‑page links.

Because it relies on paragraph structure, it carries a wide set of core dependencies —
Block, Entity Reference Revisions, Field, File, Image, and Link — which are enabled with
it. A couple of things are worth keeping in mind: for shareable deep links to keep
working, section anchors need to be **stable**; and if a page has sections a visitor may
not be allowed to see, make sure they don't leak into the contents list, or the ToC
becomes an index of withheld content.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is a small **configuration form** at *Administration > Structure > Paragraphs types
> Configure Paragraphs ToC* (`/admin/structure/paragraphs_type/ptoc`, permission
*administer paragraphs types*). Use it to choose which paragraph types (and which of their
fields) appear in the contents list, and to toggle a **debug** mode that outlines each
paragraph. Everything else works through configuration the module provides — described in
"How it works" below.

## How it works

The module ships three pieces that fit together:

- **View modes** — a "Table of Contents" view mode for paragraphs (`ptoc`) that shows
  only the title (`field_ptoc_title`) and nested paragraphs (using the same view mode),
  and a matching view mode for nodes that shows just the paragraphs field
  (`field_ptoc_sections`).
- **A View** — the `ptoc` view creates a **block** that takes the current
  node's ID and renders that node in the "Table of Contents" view mode, producing the
  contents list.
- **Custom theming** — a preprocess step adds an `id` to each paragraph in the default
  view mode so it can be targeted, and a custom Twig template turns each ToC title into
  an in‑page link to that section.

To use it, build your long pages from paragraphs, then place the **Table of Contents**
block (for example in a sidebar) on those pages. The block lists each paragraph as a
jump link.
