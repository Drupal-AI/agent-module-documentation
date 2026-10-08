<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ElasticsearchQueryBuilder plugin type (inqube)

The pluggable piece: a builder plugin converts a view's filters/arguments/sorts into an Elasticsearch
DSL query body. The Views query plugin (`elasticsearch_query`) instantiates the builder chosen in query
settings and calls `buildQuery()`. See [../views/query-and-handlers.md](../views/query-and-handlers.md)
for the query plugin.

## Plugin type wiring

- **Manager**: `ElasticsearchQueryBuilderManager` (`src/ElasticsearchQueryBuilderManager.php`), a
  `DefaultPluginManager`; service `elasticsearch_query_builder.manager`.
  - Subdir `Plugin/ElasticsearchQueryBuilder`, interface `Drupal\inqube\ElasticsearchQueryBuilderInterface`,
    annotation `Drupal\inqube\Annotation\ElasticsearchQueryBuilder`.
  - Alter hook `inqube_elasticsearch_query_builder_info`; discovery cache key
    `inqube_elasticsearch_query_builder_plugins`.
- **Annotation** `@ElasticsearchQueryBuilder` (`src/Annotation/ElasticsearchQueryBuilder.php`): `id`,
  `label`, `description`.
- **Interface** `ElasticsearchQueryBuilderInterface` (extends `PluginInspectionInterface`,
  `CacheableDependencyInterface`): `buildQuery()`, `getFilterValues()`, `getArgumentValues()`,
  `getSortValues()`.

## Base classes

- `ElasticsearchQueryBuilderPluginBase` (`src/Plugin/ElasticsearchQueryBuilder/ElasticsearchQueryBuilderPluginBase.php`)
  — extends Views `PluginBase`, implements the interface + `ContainerFactoryPluginInterface`. Provides:
  - `getFilterValues()` → `[$filter->realField => $filter->value]` for every `$view->filter`.
  - `getArgumentValues()` → `[$argument->realField => $argument->getValue()]`.
  - `getSortValues()` → `[$sort->realField => order]` from `$view->sort` and `$view->query->orderby`.
  - Cache: `getCacheContexts()` merges contexts of **exposed** filter handlers; `getCacheTags()` /
    `getCacheMaxAge()` return empty (override to add invalidation).
- `DefaultElasticsearchQueryBuilder` (id **`default`**, label "Default") — `buildQuery()` returns `[]`
  (a no-op placeholder; a view using it returns only `size`/`from`).
- `BaseRootQueryBuilder` (**abstract**, `src/Plugin/ElasticsearchQueryBuilder/BaseRootQueryBuilder.php`)
  — the real starting point. Implements `RootQueryBuilderInterface`, uses `QueryBuilderHelperTrait`.
  Injects `language_manager` + `request_stack` current request (via `create()`), sets `$this->langCode`
  (content language). `init()` pre-computes `$this->cleanFilterValues` by running each filter through
  `QueryBuilderHelperTrait::cleanupFilters()` and dropping empties.
- `BaseIndexRootQueryBuilder` (**abstract**, extends `BaseRootQueryBuilder`) — for index-per-root setups:
  `getAlteredRoots()` maps each base root to key `"{base_root}_index_{langCode}"`; `setQueryRoot()` adds a
  `bool.must.term { _index: {root} }` clause so each sub-query targets a language-specific index.

## RootQueryBuilderInterface (`src/Plugin/ElasticsearchQueryBuilder/RootQueryBuilderInterface.php`)

Hooks a subclass overrides: `getBaseRoots()`, `skipRootOnFilter($root,$filters)`,
`getAlteredRoots($base_roots)`, `setQueryRoot(&$query,$root)`, `applyFilterToRoot(&$query,$filter,$root)`,
`alterRootQuery(&$query,$base_root,$root)`, `alterFullQuery(&$full_query)`, `getSort()`.

## How `BaseRootQueryBuilder::buildQuery()` assembles the body

For each root from `getAlteredRoots(getBaseRoots())`:
1. `setQueryRoot(&$query, $root)` seeds the per-root query.
2. For each `cleanFilterValues` entry, `applyFilterToRoot(&$query, ['name'=>..,'value'=>..], $base_root)`.
3. `alterRootQuery(&$query, $base_root, $root)` for custom logic.
4. Non-empty root query is appended under `body.query.bool.should[]`.

Then `getSort()` result (if any) is set on `body.sort`, and `alterFullQuery(&$full_query)` runs last.
Returned array is `{ body: { query: {...}, sort: [...] } }` (the query plugin prepends `size`/`from`).

### Filter dispatch (`applyFilterToRoot`)

Matches the filter's `name` against optional subclass properties and delegates to the trait:
- `$shouldFilters[name]` → `addShouldQuery()` (terms under `bool.must[].bool.should`).
- `$mustFilters[name]` → `addMustQuery()` (terms under `bool.must[].bool.must`).
- `$keywordFilters` (in_array) → `addKeywordQuery()` (full-text over `$keywordFields`, default `['content']`).
- `$rangeFilters[name]` → `addRangeQuery()` (uses `$field['ranges']::getRanges()[$id]['from'|'to']`).

Declare these arrays on your subclass to route each exposed filter's `realField` to the right clause.

### Sorting (`getSort` / `sortFromQueryParams` / `defaultSort`)

- URL params win: `?sort_by=<key>&sort_order=asc|desc`, where `<key>` must be in `$sortFields`
  (default map: `relevance`/`score`→`_score`, `title`, `created`, `updated`). Invalid `sort_order`
  defaults to `desc`.
- Else, if a keyword filter is active → `{_score: {order: desc}}`.
- Else `defaultSort()` builds from the view's sort handlers via `getSortValues()`, remapped through
  `$sortFields`.

## QueryBuilderHelperTrait (`src/QueryBuilderHelperTrait.php`)

- `cleanupFilters($values)` (static) — drops empty strings / zero ints from an array filter value.
- `cleanDateFilters(array $filters, array &$cleanFilterValues)` — converts a `Y-m-d` date filter (start of
  day) to a Unix timestamp; unsets filters with a single/empty value.
- `addRangeQuery`, `addShouldQuery`, `addMustQuery`, `addKeywordQuery` — the clause builders above.
  `addKeywordQuery` splits the value on `[\s,-]+`, truncates each token at an apostrophe, and emits a
  `query_string` clause `"{kw} OR {kw}* OR  *{kw}*"` over the given fields.

## Minimal builder skeleton

```php
namespace Drupal\my_module\Plugin\ElasticsearchQueryBuilder;

use Drupal\inqube\Plugin\ElasticsearchQueryBuilder\BaseIndexRootQueryBuilder;

/**
 * @ElasticsearchQueryBuilder(
 *   id = "my_content",
 *   label = @Translation("My content"),
 *   description = @Translation("Builds queries for the content index")
 * )
 */
class MyContentQueryBuilder extends BaseIndexRootQueryBuilder {
  public $baseRoots = ['content'];              // → index "content_index_{lang}"
  public $keywordFields = ['title', 'body'];
  public $keywordFilters = ['keyword'];         // realField of the exposed keyword filter
  public $mustFilters = ['bundle' => 'bundle']; // exposed filter realField => ES field
}
```

Select `my_content` in the view's **Query settings** (see the other doc). Registers automatically under
`Plugin/ElasticsearchQueryBuilder`; clear caches after adding.
