# Paragraphs Skins — manual setup guide

**Paragraphs Skins** (`paragraph_skins`) lets a single paragraph type be presented
in several different visual styles, without you having to create a separate
paragraph type for each look. It does this by adding a **select field** to a
paragraph bundle where the editor chooses a "skin" — a named style variant — and the
module attaches the corresponding CSS (and, if defined, JavaScript) library when
that paragraph is rendered.

The intended audience is **front‑end developers**. You define the available skins in
a YAML file, wiring each one to a library and, optionally, to a theme‑specific
library so the same skin can render differently per theme. Once defined and the cache
is cleared, the skins show up automatically in the paragraph edit form — and, helpfully,
the select list on a given paragraph only offers the skins that are prepared for that
particular bundle, so editors are never shown irrelevant options.

This is purely a **presentation** feature: applying a skin adds a CSS class / library
to a paragraph's output. It does not change the stored content and has no
access‑control role. It depends on the **Paragraphs** module, supports Drupal 8
through 11, and is maintained by Ukrainian developers.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no settings form** for this module. Skins are defined in a YAML file in
code, not through the admin UI — see "How to use it" below.

## Where it lives in the admin menu

Paragraphs Skins adds no admin settings page. The skin **select field** appears on
your paragraph **edit forms** (only for bundles that have skins defined), and the
skins themselves are declared in a `*.paragraph_skins.yml` file in your module or
theme.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Define your skins in a `*.paragraph_skins.yml` file. Each entry is a standard
   YAML array item with:
   - a **name** (the skin key),
   - a **label** (what the editor sees),
   - a **paragraph_type** (the bundle the skin applies to),
   - a **library** (the asset library to attach), and
   - optionally a **theme_library** map, keyed by theme name, for theme‑specific
     libraries.

   For example:

   ```yaml
   .paragraph_skins:
     - name: feature-card
       label: 'Feature card'
       paragraph_type: 1c
       library: 'openy_prgf_1c/feature-card'
       theme_library:
         openy_carnation: 'openy_carnation/feature-card'
   ```
3. Clear the cache (`drush cr`). The new skins now appear in the select list on the
   relevant paragraph bundle's edit form.
4. When editing a paragraph of that bundle, choose the skin you want; its
   library/CSS is applied when the paragraph is displayed.

To add more skins later, add new items to the YAML file (or create another one) and
clear the cache again.
