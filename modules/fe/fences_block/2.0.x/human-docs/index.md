# Fences block — manual setup guide

**Fences block** (`fences_block`) brings the "Fences" idea — control over the
HTML that wraps your content — to **blocks**. Where the original
[Fences](https://www.drupal.org/project/fences) module lets you choose the wrapper
tag and classes for a *field*, Fences block lets you do the same for a *block*:
change the wrapping element and add classes right from the block's own
configuration, so your block markup matches your design system without writing a
theme template override.

It works on both content blocks and configuration blocks that render through the
standard `block.html.twig` template. It depends on core's **Block** module and on
the **Fences** module, and it provides its own permissions. It changes only the
block's output markup — it does not alter block content or block access.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Fences dependency.

There is **no separate settings page** for this module. You configure the markup
per block, right in each block's configuration form, as described in "How to use
it" below.

## How to use it

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Click **Place block** to add a block, or **Configure** on an existing block
   under its Operations.
3. In the block's configuration form, open the **Fences Block** fieldset. There
   you can change the wrapper element (tag) and add classes to the block's markup.
4. **Save** the block.

### Two things worth knowing up front

- **Themes that override `block.html.twig` or `block--*.html.twig`.** If your
  theme overrides the block template and you need extra features such as block
  wrappers, you may need to base your override on the module's
  `block--fences.html.twig` markup — otherwise these features will not take
  effect. (See drupal.org issue `#3304737`.)
- **Layout Builder.** The module currently does **not** work for custom blocks
  placed via Layout Builder, due to core issues (see `#3117170`).

### A note on versions

The `2.x` branch is the SemVer successor of `8.x-1.0-beta3` — if you were already
on `8.x-1.0-beta3` you can and should upgrade to `2.x`. The older `8.x-1.x` branch
only receives security fixes and may be deprecated, so plan your move to `2.x`
(reading the theme‑override note above first).
