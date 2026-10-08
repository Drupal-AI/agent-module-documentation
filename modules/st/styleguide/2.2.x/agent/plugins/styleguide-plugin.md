<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Styleguide plugin type

Add your own elements to the style guide by writing a Styleguide plugin.

## Plugin type facts

| Aspect | Value |
|---|---|
| Manager service | `plugin.manager.styleguide` (`StyleguidePluginManager`) |
| Discovery subdir | `Plugin/Styleguide` |
| Interface | `Drupal\styleguide\StyleguideInterface` (one method: `items()`) |
| Base class | `Drupal\styleguide\Plugin\StyleguidePluginBase` |
| Annotation | generic `@Plugin` (id + label) |
| Alter hook | `styleguide_info` (alters plugin definitions) |
| Shipped plugins | `default_styleguide`, `comment_styleguide`, `filter_styleguide`, `image_styleguide`, `layout_styleguide`, `search_styleguide`, `views_styleguide` |

List them live: `\Drupal::service('plugin.manager.styleguide')->getDefinitions()`.

## Implement one

`mymodule/src/Plugin/Styleguide/MyStyleguide.php`:

```php
namespace Drupal\mymodule\Plugin\Styleguide;

use Drupal\styleguide\Plugin\StyleguidePluginBase;

/**
 * @Plugin(
 *   id = "mymodule_styleguide",
 *   label = @Translation("My module styleguide elements")
 * )
 */
class MyStyleguide extends StyleguidePluginBase {

  public function items() {
    $items = [];
    $items['my_badge'] = [
      'title'    => $this->t('Badge'),
      'content'  => ['#markup' => '<span class="badge">New</span>'],
      'group'    => $this->t('Custom'),   // optional grouping heading
    ];
    return $items;
  }
}
```

Each item is keyed by a machine name and has at least `title` and `content` (a string or render
array); `group` is optional. `StyleguidePluginBase` provides the `styleguide.generator` service
(`$this->generator`, for sample text/links/images), the form builder, and helpers
`buildLink($text, $uri)` / `buildLinkFromRoute($text, $route, $params, $options)`.

The controller aggregates `items()` from every Styleguide plugin (then runs
`hook_styleguide_alter()`), so simply defining the plugin makes your elements appear on the
guide after a cache rebuild.
