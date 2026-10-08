<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Invalidating a custom-tagged view from code

The whole point of the `custom_tag` plugin is that the view is cached until **you** invalidate
one of its tags. The module strips the entity `*_list` tags, so nothing busts the view for you.

## Bust the cache
Invalidate the exact tag(s) you configured on the view:

```php
use Drupal\Core\Cache\Cache;

// Single tag configured as "my_module:report" on the view.
Cache::invalidateTags(['my_module:report']);
```

Typical places to call this:

- An entity hook, e.g. `hook_ENTITY_TYPE_insert()/update()/delete()`:

  ```php
  function my_module_node_update(\Drupal\node\NodeInterface $node) {
    if ($node->bundle() === 'article') {
      \Drupal\Core\Cache\Cache::invalidateTags(['my_module:report']);
    }
  }
  ```

- A queue worker or cron after re-importing external data.
- An event subscriber, ECA/Rules action, or an API write path in a decoupled setup.

Because tags are plain strings you choose, you can share one tag across several views (one
invalidation clears them all) or scope tags per argument (the Twig token expansion, see
[../plugins/custom-tag.md](../plugins/custom-tag.md)).

## Invalidate via Drush
```bash
drush php:eval '\Drupal\Core\Cache\Cache::invalidateTags(["my_module:report"]);'
```

## Debugging which views execute (cache misses)
The plugin's `cacheGet()` will print a message on every **results** cache miss when a state flag
is on — showing `viewId:display:args (tags)`. Toggle it with:

```bash
# turn on
drush php:eval '\Drupal::state()->set("views_custom_cache_tag.execute_debug", TRUE);'
# turn off
drush php:eval '\Drupal::state()->set("views_custom_cache_tag.execute_debug", FALSE);'
```

Use it to confirm a view is being served from cache (no message) vs. re-executing (message).

## Reading a view's configured tags programmatically
```php
$view = \Drupal\views\Views::getView('my_view');
$view->setDisplay('default');
$cache = $view->display_handler->getOption('cache');
// $cache['type'] === 'custom_tag'
// $cache['options']['custom_tag'] === "my_module:report"
```
