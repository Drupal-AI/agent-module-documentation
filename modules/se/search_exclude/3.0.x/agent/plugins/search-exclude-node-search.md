<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `search_exclude_node_search` plugin

```php
/**
 * @SearchPlugin(
 *   id = "search_exclude_node_search",
 *   title = @Translation("Content (Exclude)")
 * )
 */
class SearchExcludeNodeSearch extends \Drupal\node\Plugin\Search\NodeSearch
```

Search Exclude defines **no plugin type of its own** — it supplies one instance of core's
`SearchPlugin` type. Everything below is an override of `NodeSearch`.

| Override | What changes |
|---|---|
| `defaultConfiguration()` | adds `excluded_bundles => []` on top of NodeSearch's defaults. |
| `buildConfigurationForm()` | adds an open `details` element **"Exclude content types"** containing a `checkboxes` element `excluded_bundles`, options = `node_type_get_names()`. Returns early (no element) if the site has no node types. |
| `submitConfigurationForm()` | `array_filter()`s the checkbox values into `configuration['excluded_bundles']` before calling the parent. |
| `updateIndex()` | rebuilds the cron indexing query: selects `node.nid`, left-joins `search_dataset` on `sd.type = 'search_exclude_node_search'`, and — when `excluded_bundles` is non-empty — adds `n.type NOT IN (:excluded_bundles)`. Ranged by `search.settings:index.cron_limit`. Indexes each node with `indexNode()` and flushes word weights in a `finally`. |
| `indexStatus()` | when nothing is excluded, defers to the parent; otherwise counts `total` and `remaining` with the same `NOT IN` restriction, so the admin screen's progress is honest. |
| `searchFormAlter()` | after the parent runs, removes excluded bundles from `$form['advanced']['types-fieldset']['type']['#options']` so users can't filter by a type that is not indexed. |
| `reIndex(EntityInterface $entity)` | **new public method.** Resolves a comment to its commented node, ignores non-node entities, returns early if the node's type is excluded, otherwise calls `\Drupal::service('search.index')->markForReindex('search_exclude_node_search', $nid)`. |

## The reindex hooks

`search_exclude.module` is four hooks that all funnel into `_search_exclude_reindex()`:

- `hook_ENTITY_TYPE_update()` for **node**
- `hook_ENTITY_TYPE_insert()` / `_update()` / `_delete()` for **comment**

`_search_exclude_reindex()` walks
`\Drupal::service('search.search_page_repository')->getIndexableSearchPages()`, and for every
page whose plugin id is `search_exclude_node_search` calls `$plugin->reIndex($entity)`.
So a node/comment change only marks the node dirty on *enabled, indexable* Search Exclude
pages, and never for an excluded content type.

Note there is **no `hook_node_insert()`** — new nodes are picked up by `updateIndex()` on the
next cron because they have no `search_dataset` row yet (`sd.sid IS NULL`).

## Writing your own variant

If you need different exclusion logic (e.g. by field value rather than bundle), subclass the
same base:

```php
namespace Drupal\my_module\Plugin\Search;

use Drupal\search_exclude\Plugin\Search\SearchExcludeNodeSearch;

/**
 * @SearchPlugin(id = "my_node_search", title = @Translation("Content (mine)"))
 */
class MyNodeSearch extends SearchExcludeNodeSearch {
  public function updateIndex() { /* your query */ }
}
```

Remember the `search_dataset.type` key is the **plugin id**, so a new plugin id means a fresh
index; and `_search_exclude_reindex()` only calls `reIndex()` for the exact id
`search_exclude_node_search`, so a subclass with a new id needs its own reindex hooks.
