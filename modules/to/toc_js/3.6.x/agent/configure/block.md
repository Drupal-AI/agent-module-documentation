<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Block plugin: `toc_js_block`

`Drupal\toc_js\Plugin\Block\TocJsBlock` — a "Toc.js block" (category "Toc js") you can place in any
region to build a TOC for the current page.

```php
@Block(
  id = "toc_js_block",
  category = @Translation("Toc js"),
  admin_label = @Translation("Toc.js block"),
)
```

- `defaultConfiguration()` = `TocJsService::defaultSettings()` (the same ~40 keys as the
  per-content-type TOC). The block config form is built by `TocJsService::getTocForm()` with parents
  `settings`.
- `build()` calls `TocJsService::buildToc($this->pluginId, $this->configuration)` — the settings
  become `data-*` attributes and the JS library builds the TOC client-side.
- Cache: adds the current route entity's cache tags and the `url.path` context, so the TOC varies by
  page.

## Place it (config)

Block settings are validated by schema `block.settings.toc_js_block` (same keys as the content-type
TOC). Example placement:

```php
\Drupal\block\Entity\Block::create([
  'id' => 'tocjs_sidebar',
  'plugin' => 'toc_js_block',
  'theme' => \Drupal::config('system.theme')->get('default'),
  'region' => 'content',
  'settings' => [
    'id' => 'toc_js_block',
    'label' => 'On this page',
    'label_display' => '0',
    'selectors' => 'h2,h3',
    'container' => '.node',
  ] + \Drupal::service('toc_js.service')->defaultSettings(),
  'visibility' => [],
])->save();
```

Read back: `drush cget block.block.tocjs_sidebar`.

The per-node variant block `toc_js_per_node_block` is provided by the `toc_js_per_node` submodule
(see that submodule's docs).
