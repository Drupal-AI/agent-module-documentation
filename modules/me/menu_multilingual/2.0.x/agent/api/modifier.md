<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The modifier service & the menu-link plugin

## `menu_multilingual.modifier` — `MenuMultilingualLinkTreeModifier`

A `TrustedCallbackInterface` service (args: `language_manager`, `entity_type.manager`,
`config.factory`) that filters a menu block's built link tree. Wired up automatically by
`Helpers::setBlockProcessing()` from the two `hook_block_view_*_alter` implementations:

```php
$modifier = \Drupal::service('menu_multilingual.modifier');
$modifier->filterLabels((bool) $only_translated_labels);   // enable label filtering
$modifier->filterContent((bool) $only_translated_content); // enable content filtering
$build['#pre_render'][] = [$modifier, 'filterLinksInRenderArray'];
```

- `filterLabels(bool)` / `filterContent(bool)` — turn each check on.
- `filterLinksInRenderArray(array $build)` — the trusted `#pre_render` callback. Reads
  `$build['content']['#items']` (the menu tree), recursively filters it, and if nothing remains
  replaces the block with empty markup (keeping `#cache`).
- `filtersLinks(array $tree)` — recursive filter; each item's `original_link` plugin is tested
  with `hasTranslationOrIsDefaultLang()`; children (`below`) are filtered first.

The only public entry points you'd reuse are `filterLabels`/`filterContent` + the
`filterLinksInRenderArray` pre-render. It expects a standard menu block render array
(`content.#items` shaped like `menu` theme items with `original_link` and `below`).

## `MenuLinkContentMultilingual` (`Plugin\Menu`)

Extends core `MenuLinkContent` to add language helpers:

- `getLanguage()` — the menu link entity's langcode (default language when the site is not
  multilingual).
- `getTranslationLanguages()` — the entity's translation languages.

It is a thin helper for language-aware menu link handling; the tree filtering itself keys off the
standard `MenuLinkContent` / `ViewsMenuLink` plugins, not this subclass.
