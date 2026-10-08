# Theming — template, `sortbyweight` filter, Olivero

## Template

`templates/tabs.html.twig` renders the section. On the live page it outputs:

- A nav list `<ul class="tabs tab--primary layout-tabs">` with one `<li class="tabs__tab">` per
  block that has non-empty content; the first tab gets `is-active`.
- A `.tab-content` container with one `.tab-pane` per block (`id="panel-<block_id>"`), first pane
  `active`.
- Attaches library `layout_builder_tabs/tabs` (CSS + `js/tabs.js`, depends on `core/jquery`) which
  drives client-side tab switching.

**Tab label resolution** (per block): the rendered `content['#title']['#markup']`; if empty, the
block's `#configuration.label`.

**In the Layout Builder editor** the template detects `content.tabs.layout_builder_add_block` and
instead renders a simplified *stacked* preview (each block under its label heading) because the real
tabbed markup breaks the editor UI.

## The `sortbyweight` Twig filter

Registered by service `layout_builder_tabs.customTwigExtension`
(`Drupal\layout_builder_tabs\TwigExtension\SortByWeight`, tagged `twig.extension`). It defines one
filter, `sortbyweight`, used as `{% set blocks = content[region]|sortbyweight %}`. `performSort()`
runs `uasort()` on the render array by each item's `#weight`, so blocks (tabs) appear in weight
order. Non-arrays pass through unchanged; items lacking `#weight` sort last.

## Olivero integration

`TabsLayout::build()` checks the active theme; when it is `olivero` it appends
`$build['#attached']['library'][] = 'olivero/tabs'` so the tabs inherit Olivero's tab styling. Under
other themes only `layout_builder_tabs/tabs` is attached — style it in your theme's CSS if needed.

## Overriding

- Override `tabs.html.twig` in your theme to change the markup (theme hook `tabs`, provided by the
  layout template declaration `template: templates/tabs`).
- Provide your own CSS/JS by overriding or extending the `layout_builder_tabs/tabs` library.
- The `sortbyweight` filter is reusable in any Twig template once this module is enabled.
