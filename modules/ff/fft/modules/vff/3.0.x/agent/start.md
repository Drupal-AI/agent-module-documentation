<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Formatter (vff) — agent index

Submodule of **Field Formatter Template** (`fft`). Adds a **Views style plugin** that renders a
whole View result set through a **Twig template** chosen from FFT's configured template directory.
Package `Custom`. Core requirement `^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 3.0.1.
Depends on **`fft:fft`** (and core Views). No permissions, no Drush, no config schema.

- **The `views_formatter_template` style plugin, its options, preprocessing, and templates** →
  [plugins/views_style.md](plugins/views_style.md)
- Parent module: `modules/ff/fft/3.0.x/` — the template directory setting and discovery rules live
  there.

## What it actually is

- One Views style plugin: **`ViewFormatterTemplate`**
  (`src/Plugin/views/style/ViewFormatterTemplate.php`), id **`views_formatter_template`**, title
  *"View Formatter Template"*, `theme = "views_formatter_template"`,
  `theme_file = "../vff.theme.inc"`. `usesRowPlugin = TRUE`, `usesRowClass = TRUE`,
  `usesGrouping = FALSE`.
- Theme registration in `vff.module` (`vff_theme()`): hook `views_formatter_template` →
  `templates/views-formatter-template.html.twig`, which is just `{{ template_rendered | raw }}`.
  `vff_theme_suggestions_alter()` adds a `views_view__vff` suggestion (clean wrapper,
  `templates/views-view--vff.html.twig`) when the *clean template* option is on.
- Preprocessing in **`vff.theme.inc`** (`template_preprocess_views_formatter_template()`) builds
  `template_rendered` by calling the parent module's `fft_render()` on the selected template.
- `vff_help()` provides the module help page. No entities, services, or install file.

## Style options (`defineOptions()`)

`template` (''), `render_type` ('raw' | 'styled'), `vff_tree_field` (''), `vff_tree_parent_field`
(''), `vff_clean_template` (''), `show_empty` (''). The template dropdown is populated by
`fft_get_templates('views')` — templates whose filename starts with `views` and carry a
`{# Template Name: … #}` header. Details in [plugins/views_style.md](plugins/views_style.md).

## Mechanism (from source)

- **raw**: passes `$style->getRenderedFields()` as `data` (one associative array of rendered
  field markup per row). In Twig-debug mode HTML comments are stripped from each field.
- **styled**: passes the raw `rows` render arrays as `data`.
- **tree**: when both `vff_tree_field` and `vff_tree_parent_field` are set, `vff_build_tree()`
  turns the flat rendered rows into a nested `childNodes` structure by id/parentId.
- Also injects `view`, `langcode`, `langcode_content`, `langcode_interface`, and `_variables`.
- `evenEmpty()`/`show_empty` allow rendering the template for an empty View.

## Notes / caveats

- Inherits FFT's rendering path: templates are sandboxed Twig, authored by site builders in the
  FFT storage directory, and rendered via the legacy procedural `twig_render_template()` (throws
  outside a themed web request).
- vff has **no template directory setting of its own** — it reuses `fft.settings:fft_storage_dir`
  from the parent module.
