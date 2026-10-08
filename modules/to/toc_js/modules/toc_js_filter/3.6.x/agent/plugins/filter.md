<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Filter plugin: `toc_js_filter`

`Drupal\toc_js_filter\Plugin\Filter\TocJsFilter` (extends `FilterBase`).

```php
@Filter(
  id = "toc_js_filter",
  title = @Translation("TOC.js shortcode: [toc]"),
  type = TYPE_TRANSFORM_IRREVERSIBLE
)
```

## Behavior

- `process($text, $langcode)`: if the text contains `[toc]` (case-insensitive), each `[toc]` is
  replaced (via `preg_replace_callback`) with a rendered Toc.js build:
  `TocJsService::buildToc($this->pluginId, $settings)` rendered in a `RenderContext`. The filter
  merges the render metadata into the `FilterProcessResult` — attached `toc_js/toc` library,
  `drupalSettings`, the route entity's cache tags, and the `url.path` cache context.
- `settings` = the filter's stored settings + `TocJsService::defaultSettings()`. The TOC list itself
  is still generated client-side by the toc.js library from the page headings.

## Settings form

`settingsForm()` reuses `TocJsService::getTocForm()` with the filter's `#parents`, so the format's
"Configure" for this filter shows the full Toc.js option set (title, selectors, container, list
type, smooth scrolling, back-to-top, sticky, collapsible, ajax, …). Stored under schema
`filter_settings.toc_js_filter`.

## Enable it on a text format

```php
$format = \Drupal\filter\Entity\FilterFormat::load('full_html');
$format->setFilterConfig('toc_js_filter', [
  'status' => TRUE,
  'weight' => 0,
  'settings' => ['selectors' => 'h2,h3', 'list_type' => 'ol'],
]);
$format->save();
```

Read back: `drush cget filter.format.full_html filters.toc_js_filter` → `status: true` and its
`settings`. Then any `[toc]` in a field using that format renders a TOC.
