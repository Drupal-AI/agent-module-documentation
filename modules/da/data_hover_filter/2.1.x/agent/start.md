<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Data hover Filter (data_hover_filter) — agent index

Single-purpose text-format filter. When enabled on a format, it adds a `data-hover`
attribute (= the link's own trimmed text) to every `<a>` tag in the filtered HTML, so
themes/CSS can build hover effects and tooltips from the link label.

- **Version:** 2.1.x · **Core:** `^8 || ^9 || ^10 || ^11 || ^12` · **License:** GPL-2.0-or-later
- **Dependencies:** none beyond Drupal core's `filter` module. No Composer requirements.
- **Package:** custom · Not covered by Drupal's security advisory policy.

## What it provides

- **Filter plugin** `filter_attribute` (title "Data hover Filter") —
  `src/Plugin/Filter/FilterAttribute.php`, extends `FilterBase`,
  type `TYPE_TRANSFORM_IRREVERSIBLE`. `process()` uses `Html::load()` /
  `Html::serialize()`, iterates `<a>` elements, and `setAttribute('data-hover', $label)`
  where `$label = trim($link->textContent)` (skipped when empty). `tips()` returns a short
  description.
- No routes, services, permissions, config schema, install hooks, hook implementations,
  submodules, libraries, or Drush commands.

## How to operate

- Enable the module, then turn the "Data hover Filter" filter on for the relevant text
  format(s) at Admin → Configuration → Content authoring → Text formats and editors
  (`/admin/config/content/formats`). Order it after any filter that generates links.
- No settings form — it is on/off per format.

## Solution docs

- [Filter: data-hover attribute](filters/data_hover.md) — behavior, plugin details, enabling, theming.
