<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theming the Facets Block

## Theme hook

`facets_block` (registered in `facets_block_theme()`), template
`templates/facets-block.html.twig`. Variables:

| Variable | Meaning |
|---|---|
| `show_title` | bool — whether to print each facet's title (from the `show_title` setting). |
| `facets` | array of facet entries, each with `title`, `content`, and `attributes`. |

Override by copying `facets-block.html.twig` into your theme and adjusting markup. Iterate
`facets` and print `facet.title` (guarded by `show_title`), `facet.content`, and spread
`facet.attributes` on the wrapper.

## Per-facet CSS classes

In `FacetsBlock::buildFacets()` each rendered facet gets a unique class derived from its plugin
id with `_` and `:` replaced by `-`, e.g. plugin id `facet_block:brand` →
class `facet-block--brand`. Target these to style individual facets inside the combined block.

## JS classes (`add_js_classes`)

When the block's `add_js_classes` setting is on, `facets_block_block_view_facets_block_alter()`
adds `\Drupal\facets_block\AddJsClasses::preRender` to the block's `#pre_render`, attaching
JS-friendly classes. When `hide_empty_block` is on it adds
`\Drupal\facets_block\AddCssClasses::preRender`, which handles not rendering the block when it
has no facets. Both are plain pre-render callbacks — no library or settings to configure.
