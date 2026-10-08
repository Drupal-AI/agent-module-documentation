Adds a warehouse-aware "has stock" Search API/Views filter so product listings can exclude out-of-stock items.

---

`arch_stock_search_api` is the Search API and Views bridge for `arch_stock`. When a Search API index named `products` contains indexed per-warehouse stock fields (fields whose real property matches `entity:*/arch_stock_*`), `hook_views_data_alter()` exposes a `Stock filter` (`arch_stock_value_filter`) on that index. The filter plugin `SearchApiHasStockFilter` (`arch_stock_has_stock_search_api`, extending `SearchApiBoolean`) builds an OR condition group requiring stock `> 0` in at least one of the warehouses the current user may purchase from — it asks `StockKeeper::selectWarehouses()` for that list — so the "in stock" view respects each customer's warehouse access.

---

- Hide out-of-stock products from a Search API-backed product listing.
- Add an "in stock only" toggle/filter to a product search View.
- Make stock filtering warehouse-aware: only stock in warehouses the current user may buy from counts.
- Reuse the `arch_stock` per-warehouse permission model (`purchase from {id} stock`) in search results.
- Filter across multiple indexed warehouse stock fields with a single boolean condition.
- Build faceted product search where availability is one of the facets.
- Keep search results consistent with the storefront's per-role availability rules.
- Provide config schema (`views.filter.arch_stock_search_api`) so the filter's Views config validates.
- Combine with other Search API filters (price, category) on the same `products` index.
- Drive an "Available now" product block from a Search API view.
- Support anonymous vs. authenticated visitors seeing different in-stock results based on their warehouse permissions.
- Avoid loading full product entities to determine availability by using indexed stock values.
- Let store admins expose stock filtering in the Views UI without custom code.
- Serve fast product-availability queries from the search backend instead of the database stock field.
- Pair with `arch_price_search_api` for a fully search-driven catalogue.
