# Plugins — `search_api_decoupled_filter`

A plugin type for reusable query conditions attached to an endpoint (preset or client-exposed).

## Plugin type
- Manager service: `plugin.manager.search_api_decoupled.filter`
  (`SearchApiDecoupledFilterPluginManager`, a `DefaultPluginManager` implementing
  `FallbackPluginManagerInterface`).
- Discovery namespace: `Plugin/search_api_decoupled/filter`.
- Interface: `Drupal\search_api_decoupled\SearchApiDecoupledFilterInterface`; base class
  `Plugin/search_api_decoupled/filter/SearchApiDecoupledFilterBase`.
- Annotation: `@SearchApiDecoupledFilter(id, label, description)`
  (`src/Annotation/SearchApiDecoupledFilter.php`).
- Fallback plugin id: **`standard`** (used when a configured plugin id is missing).
- Alter hook: `hook_search_api_decoupled_filter_info_alter(&$definitions)`.
- Cache bin key: `search_api_decoupled_filter_plugins`.

## Instances on an endpoint
Endpoint `filters` are a `SearchFiltersPluginCollection` (`getFilters()`); each instance carries
config: `uuid`, `field`, `operator`, `value`, `label`, `exposed`, `expose` (settings), `weight`.
The controller applies them in `prepareQuery()`:
- **Non-exposed** filter → `transformUserInput(getValue())` then
  `$query->addCondition(field, value, operator)` — always constrains results.
- **Exposed** filter → its `expose.identifier` becomes an accepted query-string key; incoming value
  is run through `validateUserInput($value, $operator)` (skips the filter if invalid) and
  `transformUserInput()`; `expose.use_operator` / `operator_limit_selection` / `operator_list`
  bound which operators the client may choose.

## Implement one
```php
namespace Drupal\mymodule\Plugin\search_api_decoupled\filter;

use Drupal\search_api_decoupled\Plugin\search_api_decoupled\filter\SearchApiDecoupledFilterBase;

/**
 * @SearchApiDecoupledFilter(
 *   id = "my_filter",
 *   label = @Translation("My filter"),
 *   description = @Translation("…"),
 * )
 */
class MyFilter extends SearchApiDecoupledFilterBase {
  // Override getSummary(), buildConfigurationForm(), validateUserInput(),
  // transformUserInput() as needed. Base handles field/operator/value/expose config.
}
```
Add/configure instances through the endpoint's Filters UI (`{endpoint}/filters`). Use
`transformUserInput()` to accept human input like `now` / `-1 day` and convert it for querying;
use `validateUserInput()` to reject bad client input on exposed filters.
