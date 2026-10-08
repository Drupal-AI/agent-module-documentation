# Layout Builder Extra Templates — manual setup guide

**Layout Builder Extra Templates** (`layout_builder_extra_templates`) is a small
theming helper for anyone who builds pages with **Layout Builder**. Out of the box,
Drupal makes it awkward to give a particular *type* of block its own Twig template.
This module fixes that by adding extra template‑name suggestions for content blocks
(`block_content`) and Layout Builder inline blocks (`inline_block`), keyed by the
block's **bundle** (block type) and by the **active theme**.

In plain terms: once it is enabled, a themer can drop a file such as
`block--hero.html.twig` into their theme and it will automatically be used for every
"Hero" block — no preprocess code required. That works both for reusable content
blocks and for the one‑off inline blocks you create directly inside Layout Builder,
so your design system's block components can each map cleanly to a template file.

There is nothing to configure: the module is a single behind‑the‑scenes hook. Enable
it, add your templates, clear the cache, and the new suggestions are available for
every block render.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Nowhere — this module has **no settings page, no permissions, and no configuration**.
It works entirely in the theme layer. Its effect shows up in your theme's
`templates/` directory and in Twig's debug output.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. For each block bundle you want to theme, add a template to your theme's
   `templates/` directory. The suggestions the module adds, from least to most
   specific, are:
   - `block--<bundle>.html.twig` — every block of that bundle.
   - `block--<theme>--<bundle>.html.twig` — that bundle, only in the named theme.
   - `block--<theme>--<base-plugin>--<bundle>.html.twig` — the most specific form,
     where `<base-plugin>` is `block-content` or `inline-block`.

   Remember Drupal's filename convention: underscores in machine names become
   hyphens in file names. So a `call_to_action` bundle uses
   `block--call-to-action.html.twig`, and a `hero` inline block in a theme called
   `mytheme` could use `block--mytheme--inline-block--hero.html.twig`.
3. Clear caches (`drush cr`). Turn on **Twig debug** if you want to confirm the new
   suggestions appear in the HTML comments around each block; Drupal always uses the
   most specific matching template.

That's the whole workflow — the suggestions exist for every content/inline block
render as soon as the module is enabled.
