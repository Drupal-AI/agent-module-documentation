<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Adding items with `hook_debug_bar_items_alter()`

Debug Bar exposes one alter hook (`debug_bar.api.php`) that lets any module add, remove or reorder
items on the bar. It receives the array of `Drupal\debug_bar\Data\DebugBarItem` objects built by
`DebugBarBuilder::buildItems()` (already populated with the core items), and it is invoked via
`$moduleHandler->alter('debug_bar_items', $items)` right before the list is sorted by `weight` and
filtered by `access`.

## The value object: `DebugBarItem`

`src/Data/DebugBarItem.php` — a `final readonly` class; construct with named args:

| Property | Type | Default | Notes |
|---|---|---|---|
| `id` | `string` | — | Item identifier. |
| `content` | `string \| TranslatableMarkup` | — | The visible label/value (Twig-escaped on output). |
| `iconPath` | `string` | — | URL to a 16px icon; rendered as a `background-image` inline style. |
| `access` | `bool` | `TRUE` | If `FALSE` the item is filtered out in `build()`. |
| `weight` | `int` | `0` | Lower = earlier; list is `uasort`ed by weight. |
| `url` | `?Url` | `NULL` | If set the item renders as a link, else a `<span>`. |
| `attributes` | `Attribute` | `new Attribute()` | Wrapper attributes (preprocess adds classes/title). |
| `title` | `string \| TranslatableMarkup \| NULL` | `NULL` | Tooltip (`title` attribute). |

## Example

```php
use Drupal\debug_bar\Data\DebugBarItem;

/**
 * Implements hook_debug_bar_items_alter().
 */
function mymodule_debug_bar_items_alter(array &$items): void {
  $module_path = \Drupal::service('extension.list.module')->getPath('mymodule');
  $items[] = new DebugBarItem(
    id: 'mymodule_env',
    content: getenv('APP_ENV') ?: 'unknown',
    iconPath: \base_path() . $module_path . '/images/env.png',
    access: \Drupal::currentUser()->hasPermission('access site reports'),
    weight: 100,
    title: t('Environment'),
  );
}
```

Notes:

- Set your own `access` flag; the module filters items on it and does not add any implicit gate
  beyond the `view debug bar` check that decides whether the bar is attached at all. Do not surface
  sensitive values to roles that should not see them.
- `content` is rendered through the `debug_bar` Twig template, so it is auto-escaped; pass a
  `TranslatableMarkup`/plain string, not pre-built markup expecting to bypass escaping.
- To reorder or drop core items, mutate/unset entries by their `id` (e.g. `home`, `execution_time`,
  `memory_usage`, `db_queries`, `php`, `cron`, `git`, `watchdog`, `cache`, `user`, `login`,
  `logout`, `status_report`).
