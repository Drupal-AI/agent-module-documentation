<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Stock Search API (arch_stock_search_api) — agent index

Search API / Views bridge for `arch_stock`: exposes a **warehouse-aware "has stock" boolean filter**
on a Search API `products` index. Package `Arch Search API`. Depends on `arch_stock`, core `views`,
and contrib `search_api`. Core `^9.4 || ^10 || ^11`. License GPL-2.0-or-later. Version dir `8.x-1.x`
(installed `8.x-1.0-alpha26`). No routes, no permissions, no services of its own.

## What it provides (from source)

- `arch_stock_search_api_views_data_alter()` (`arch_stock_search_api.views.inc`) — for a Search API
  index with id **`products`**, scans its Views data for fields whose `real field` matches
  `entity:*/arch_stock_*` and, if any exist, adds a Views filter `arch_stock_value_filter` (id
  `arch_stock_has_stock_search_api`, title *Stock filter*, `allow empty: FALSE`).
- Views filter plugin **`SearchApiHasStockFilter`** (`@ViewsFilter("arch_stock_has_stock_search_api")`,
  `src/Plugin/views/filter/SearchApiHasStockFilter.php`), extends `search_api`'s `SearchApiBoolean`.
  Injects `@current_user` and `@arch_stock.stock_keeper`.
  - `query()` builds an **OR** condition group over the filtering fields, each requiring the indexed
    value `> 0`, added via the Search API query builder (`createConditionGroup` / `addCondition`).
  - `getFilteringFields()` = one `arch_stock_{warehouse_id}` field per warehouse returned by
    `StockKeeper::selectWarehouses($currentUser)` — so only warehouses the current user may purchase
    from are considered.
- Config schema (`config/schema/arch_stock_search_api.schema.yml`): `views.filter.arch_stock_search_api`
  and `views.filter_value.arch_stock_search_api`, both extending the Search API numeric filter schema.

## Operate

Index per-warehouse stock fields onto a Search API index named `products`, then add the *Stock filter*
to a View of that index to show only in-stock products for the viewing user's accessible warehouses.
