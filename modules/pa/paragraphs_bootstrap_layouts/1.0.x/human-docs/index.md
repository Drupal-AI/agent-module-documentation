# Paragraphs Bootstrap Layouts — manual setup guide

**Paragraphs Bootstrap Layouts** (`paragraphs_bootstrap_layouts`) is a Bootstrap
grid layout system for Paragraphs. It lets editors arrange paragraphs into
Bootstrap **rows** and **columns**, so a paragraph‑built page can follow the
familiar Bootstrap 12‑ or 24‑column grid and stay responsive.

It is a "feature" module: rather than adding a lot of code, it bundles ready‑made
configuration for existing modules. Out of the box it provides a **Bootstrap Row**
paragraph type and a **Bootstrap Column** paragraph type, and it ships two
submodules that carry the grid configuration — one for a **12‑column** grid and one
for a **24‑column** grid. You enable the base module and then exactly **one** of
the grid submodules, depending on which grid your design uses.

Because the layout is delivered as Bootstrap grid classes and markup, your theme
needs to be Bootstrap‑compatible for the columns to line up. The module builds on
[Classy Paragraphs](https://www.drupal.org/project/classy_paragraphs) (which
provides the class‑selection mechanism) and depends on the
[Paragraphs](https://www.drupal.org/project/paragraphs) module. It has no
access‑control role — it only affects how paragraphs are laid out.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the base
   module, and pick the 12‑ or 24‑column grid submodule.

There is **no central configuration page** for this module. You compose layouts by
adding Row and Column paragraphs to your content, as described in "How to use it"
below.

## Where it lives in the admin menu

The module adds no settings page. The **Bootstrap Row** and **Bootstrap Column**
paragraph types it provides appear under **Structure → Paragraph types**
(`/admin/structure/paragraphs_type`), and column widths are chosen per column when
you build content (through the Classy Paragraphs style selection).

## How to use it

1. Enable the base module and one grid submodule (see
   [Installation](installation/index.md)) — the 12‑column one for a standard
   Bootstrap grid, or the 24‑column one for a finer grid.
2. Add a Paragraphs (Entity Reference Revisions) field to one of your entities and
   allow it to use **only** the **Bootstrap Row** paragraph type.
3. When editing content, create as many **rows** as you need. Inside each row, add
   as many **columns** as you need and choose each column's width. Then add your
   ordinary content paragraphs inside those columns.
4. View the page on your Bootstrap‑compatible theme — the rows and columns render
   with Bootstrap grid classes and reflow responsively.
