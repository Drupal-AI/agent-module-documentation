# Splitting — manual setup guide

**Splitting** (`splitting`) brings the [Splitting.js](https://splitting.js.org/)
microlibrary to Drupal. Splitting.js takes an element and sections it off into its
individual **words and characters** (and more — lines, items, grids, images),
wrapping each piece and adding CSS custom properties such as per‑item indices and
positions. Those variables unlock text animations that plain CSS could not do on
its own: staggered reveals, per‑letter effects, and other typographic flourishes.

This is a front‑end / theming tool. It affects the markup and adds CSS variables
for animation; it never changes your content or who can access it. The base module
simply loads the Splitting library on every page — you then call `Splitting()`
from your theme's JavaScript and drive the effects with your own CSS.

If you would rather not write JavaScript, the module ships an optional
**Splitting UI** submodule (`splitting_ui`). It gives you an admin form where you
list the CSS selectors to apply Splitting to and set a few global options, so you
can wire up the effect without touching code. Splitting runs on Drupal 8.8 through
11.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module, provide the
   Splitting.js library, and optionally enable the Splitting UI submodule.
2. [Configuration](configuration/index.md) — the Splitting UI form, where you list
   the selectors to split and set global options.

## How to use it

There are two ways to apply Splitting:

- **In code** — enable the base module and call `Splitting()` (optionally targeting
  specific selectors) from your theme's JavaScript, then style the split words and
  characters with CSS using the variables Splitting.js adds.
- **Through the UI** — enable the **Splitting UI** submodule and configure your
  selectors and options on its settings page (see
  [Configuration](configuration/index.md)), no JavaScript required.
