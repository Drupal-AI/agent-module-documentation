<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Service decorators — css_js_agg_retention

The module's entire runtime behavior is two service decorators that intercept core's asset
collection optimizers and replace their "delete everything" behavior with an age-based sweep.

## Service definitions

`css_js_agg_retention.services.yml` (both `public: false`):

| Service id | `decorates` | Class |
|---|---|---|
| `css_js_agg_retention.css_optimizer` | `asset.css.collection_optimizer` | `CssOptimizerSelectiveDelete` |
| `css_js_agg_retention.js_optimizer`  | `asset.js.collection_optimizer`  | `JsOptimizerSelectiveDelete`  |

Constructor arguments (both): the decorated `*.inner` service, `@file_system`,
`@logger.factory`, `@config.factory`, `@datetime.time`.

> Note: the README says these decorate `asset.css.collection_optimizer_lazy` /
> `..._lazy`, but the actual `services.yml` decorates the non-`_lazy` ids
> `asset.css.collection_optimizer` and `asset.js.collection_optimizer`. Trust `services.yml`.

## Class hierarchy (`src/Asset/`)

- `BaseOptimizerSelectiveDelete` (abstract) implements
  `Drupal\Core\Asset\AssetCollectionGroupOptimizerInterface`. Holds the shared logic and the
  constant `MAX_AGE = 45 * 86400`.
- `CssOptimizerSelectiveDelete` — `getAssetsPath()` returns `'assets://css'`.
- `JsOptimizerSelectiveDelete` — `getAssetsPath()` returns `'assets://js'`.

## Overridden method: `deleteAll()`

This is the only method that changes behavior. Steps:

1. `$dir = $this->getAssetsPath()`. If `fileSystem->prepareDirectory($dir, CREATE_DIRECTORY)`
   fails, return (nothing to do).
2. `$now = time->getRequestTime()`; scan files: `fileSystem->scanDirectory($dir, '/.*/',
   ['recurse' => TRUE])`.
3. Read retention: `configFactory->get('css_js_agg_retention.settings')->get('retention_days')`,
   falling back to `MAX_AGE / 86400` (45). `$max_age = $retention_days * 86400`.
4. For each file, if `$now - filemtime($file->uri) > $max_age`, `fileSystem->delete($file->uri)`
   and increment the removed counter.
5. Log a `notice` to the `css_js_agg_retention` logger channel with the purged count, the
   directory, and the scanned total.

## Pass-through methods

`optimize()`, `optimizeGroup()`, and `getAll()` simply proxy to `$this->inner` (the decorated
core optimizer), so aggregation/optimization itself is unchanged — only bulk deletion is
selective.

## Test coverage

`tests/src/Unit/Asset/BaseOptimizerSelectiveDeleteTest.php` unit-tests the base class's
selective-delete logic.
