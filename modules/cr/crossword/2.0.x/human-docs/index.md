# Crossword — manual setup guide

**Crossword** (`crossword`) lets you add crossword puzzles that are playable right
in the browser to your Drupal site. It is *not* a tool for authoring puzzles —
instead, you upload crossword files created elsewhere (it currently supports Across
Lite `.txt` and `.puz` files), and the module renders them as interactive,
solvable puzzles.

At its core, the module provides a **Crossword field type**. Add that field to a
content type (or any fieldable entity), upload a puzzle file into it, and then choose
how to render it — as a playable puzzle, as an image, or as a downloadable file —
via field formatters. The default playable formatter has been built with a good-faith
effort toward screen-reader accessibility.

The base module has no requirements outside core (it depends on core **File**), and
a generous set of **submodules** adds optional features on top — image generation,
color configuration, Media integration, tokens, download formatters, pseudofields,
completion-status styling, and even a puzzle-solving contest framework. You enable
only the ones you need; some carry their own extra dependencies (for example
Crossword Token needs the Token module, and Crossword Download needs File Download
Link).

Version 2.0.x is compatible with Drupal 10 and 11, and upgrading from the old 8.x-1.x
branch requires no update hooks or special steps. The puzzles are simply authored
content rendered for visitors — the module has no access-control role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and pick the submodules you need.

There is no central settings form. You use Crossword by adding its field and
choosing a formatter, described under "How to use it" below. (A couple of submodules
add their own small settings pages, noted in Installation.)

## Where it lives in the admin menu

Crossword doesn't add a top-level admin page. You work with it through the Field UI:
**Structure → Content types → *(your type)* → Manage fields** (to add the Crossword
field) and **Manage display** (to choose how it renders).

## How to use it

1. Add a **Crossword** field to a content type (or other fieldable entity) at
   **Manage fields**.
2. On **Manage display**, choose a formatter for that field — a playable puzzle, an
   image, or a downloadable file (some formatter options come from submodules).
3. Create content, upload an Across Lite `.txt` or `.puz` file into the Crossword
   field, and save. Visitors can now play the puzzle in the browser.
4. Enable any submodules whose features you want (see Installation) — for example
   colors, Media integration, downloads, or the contest framework.

> **Recommended companions:** to present the same puzzle in multiple view modes each
> with its own route, use Views or the View Mode Page module; Entity Print can help
> if you want to turn puzzle files into PDFs.
