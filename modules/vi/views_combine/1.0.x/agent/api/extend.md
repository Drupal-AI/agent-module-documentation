<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Runtime pipeline & extension points

## Hooks (in `views_combine.module`)

| Hook | Does |
| --- | --- |
| `hook_views_data()` | Registers the `views_combine` field/filter/sort handlers on the `views` table. |
| `hook_views_post_build()` | `new ViewsCombiner($view)->combine()` — rewrites `$view->build_info['query']` into the UNION. |
| `hook_views_pre_render()` | `new ViewsCombiner($view)->results()` — loads entities for rows and picks per-view field handlers. |
| `hook_views_plugins_style_alter()` | Swaps the `default` and `views_bootstrap_grid` style classes for combine-aware subclasses. |

## `\Drupal\views_combine\ViewsCombiner`

A plain PHP class (not a service), constructed with the base `ViewExecutable`. Pulls
`database` and `entity_type.manager` from the container. Key methods:

| Method | Role |
| --- | --- |
| `hasViews()` | TRUE if the display has any `views_combine` field handler. |
| `combine()` | Orchestrates `setFilters()→setViews()→setFields()→setCombineSorts()→setUnions()`. Called from `hook_views_post_build`. |
| `getView($view_id, $display_id)` | Loads a `view` config entity via storage and sets its display; returns the `ViewExecutable` or NULL. |
| `buildView($view_id, $display_id, $base_view, $field_handler)` | Loads a combined view, inherits the base view's `exposed_raw_input` (applying `filter_map`/`sort_map`), then `preExecute()` + `build()`. |
| `getViewIds($view_query_id)` | Resolves combined views recursively (a combined view may itself combine others). |
| `results()` | Post-build entity loading per row `_view_id`; drops rows whose source view can no longer be built. Called from `hook_views_pre_render`. |

### How the UNION is assembled (safe by construction)

- Each query object is the Views-compiled `Select` from `$view->build_info['query']`; it is
  joined with the **DB query builder** — `$base_query->union($query)` — never by string
  concatenation of request input.
- `setFields()` aligns columns so the UNION is valid: it converts each field to an expression
  (`addExpression($table.'.'.$field, $alias)` using the query's own Views-generated
  identifiers), pads missing columns with `NULL`, tags each row with its source via a bound
  placeholder (`addExpression(":view_$key", '_view_id', [...])`), and re-aliases sort columns
  to `_order_#`.
- `setArguments()` suffixes each query's argument placeholders with the query key so the
  merged statement's placeholders stay unique; argument **values** remain bound parameters.
- `setUnions()` shifts the first (base) query as parent, unions the rest, orders by the
  `_order_#` aliases, and builds a matching `distinct()` count query when the display pages.

Because each combined `Select` keeps its own query tags (e.g. `node_access`,
`*_access`), core `Select::preExecute()` recurses into `$this->union` and runs those tag
alters at execution time — so row-level entity/node access grants still apply to combined rows.

## Supporting an additional display style

The module only patches `default` and `views_bootstrap_grid`. To combine under another style,
create a subclass of that style's plugin that `use`s `CombineStyleTrait`, then register it
from your own `hook_views_plugins_style_alter()`:

```php
// In your_module.module
function your_module_views_plugins_style_alter(array &$plugins): void {
  if (isset($plugins['grid'])) {
    $plugins['grid']['class'] = \Drupal\your_module\Plugin\views\style\CombineGrid::class;
  }
}
```

```php
namespace Drupal\your_module\Plugin\views\style;

use Drupal\views\Plugin\views\style\Grid as GridBase;
use Drupal\views_combine\Plugin\views\style\CombineStyleTrait;

class CombineGrid extends GridBase {
  use CombineStyleTrait;
}
```

`CombineStyleTrait::elementPreRenderRow()` renders each row with the field handlers of the
view that produced it (looked up via the `views_combine` drupal_static cache keyed by
`_view_id`), falling back to the parent style for base-view rows. Advanced styles that do
extra work per row may need more than the trait provides.
