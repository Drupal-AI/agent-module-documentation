<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `hook_facets_block_facets_alter()`

Declared in `facets_block.api.php`. Runs in `FacetsBlock::build()` (via
`$this->moduleHandler->alter('facets_block_facets', $facets)`) after the module has built the
array of selected facets and before it is themed. Use it to append, remove, or modify entries.

```php
use Drupal\Core\Link;
use Drupal\Core\Url;

/**
 * Alter the facets array rendered by a Facets Block.
 *
 * @param array $facets
 *   The facets array. Each existing entry has keys:
 *   - '#block_plugin': the facet's block plugin instance
 *   - 'title': the facet title (string)
 *   - 'content': the render array for the facet
 *   - 'attributes': a Drupal\Core\Template\Attribute object
 */
function mymodule_facets_block_facets_alter(array &$facets) {
  // Append an extra "Home page" link entry.
  $facets[] = [
    'title' => '',
    'content' => Link::fromTextAndUrl(t('Home page'), Url::fromRoute('<front>', [], [
      'query' => ['filter' => 'recent-posts'],
    ])),
  ];

  // Or remove a facet by inspecting its title.
  foreach ($facets as $i => $facet) {
    if (($facet['title'] ?? '') === 'Deprecated') {
      unset($facets[$i]);
    }
  }
}
```

The altered array is passed to the `facets_block` theme hook as `#facets`. Note the module does
not validate the shape of entries you add, so match the keys above (`title`, `content`, and
optionally `attributes`) for the default template to render them correctly.
