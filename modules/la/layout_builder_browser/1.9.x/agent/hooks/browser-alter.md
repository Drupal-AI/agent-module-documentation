<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `hook_layout_builder_browser_alter()`

The only hook the module invites (`layout_builder_browser.api.php`). Invoked at the end of
`BrowserController::browse()` via `$this->moduleHandler->alter('layout_builder_browser', $build, $contexts)`
— so it runs **only** when the curated browser actually built (i.e. the section storage is listed
in `enabled_section_storages`), never on the core fallback.

```php
function mymodule_layout_builder_browser_alter(array &$build, array $context) {
  // $context = ['section_storage' => SectionStorageInterface, 'delta' => int, 'region' => string]

  $build['filter']['#placeholder'] = t('Block name');

  foreach ($build['block_categories'] as $key => &$category) {
    if ($key === 'common' || ($category['#type'] ?? NULL) !== 'details') {
      continue;
    }
    $category['#open'] = FALSE;
  }
}
```

## Shape of `$build`

```
$build['filter']                       // '#type' => 'search', class js-layout-builder-filter
$build['block_categories']             // '#type' => 'container', class js-layout-builder-categories
$build['block_categories'][<cat_id>]   // '#type' => 'details', '#title', '#open'
$build['block_categories'][<cat_id>]['links'][]  // container > 'link' (#type link -> layout_builder.add_block)
$build['#attached']['library'][]       // layout_builder_browser/browser (+ …/modal when use_modal)
```

Caveats:

- Keys in `block_categories` are **category machine names** for curated categories, but the
  auto-added reusable-bundle categories are keyed by the bundle **label** (see
  `auto_added_reusable_block_content_bundles`) — guard with `isset($category['#type'])`.
- A category with no links has already been unset before the alter runs.
- Each link's `#title` is a render array with optional `image` plus a `label` `#markup`, not a string.

Related extension points that are **not** hooks:

- `RouteSubscriber::alterRoutes()` sets `_controller` on `layout_builder.choose_block` at
  `RoutingEvents::ALTER` priority **-110**; subclass/re-alter at a lower priority to win.
- The module ships `templates/layout-builder-browser-block.html.twig` but registers **no
  `hook_theme()`** for it in 1.9 — the links are built as plain `#type => link` render arrays, so
  overriding that template has no effect. Style via `css/layout_builder_browser.css`
  (`.layout-builder-browser-block-item`) instead.
