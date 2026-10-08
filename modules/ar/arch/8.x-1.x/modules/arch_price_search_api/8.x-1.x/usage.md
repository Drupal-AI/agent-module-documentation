Arch Price Search API adds a currency-aware net/gross price Views filter to Search API indexes of Arch products.

---

Arch Price Search API (`arch_price_search_api`) bridges Arch's price fields into Search API–backed Views. Its `hook_views_data_alter()` inspects every Search API index; on an index whose id is `products` it detects the Arch price fields (real fields matching `arch_price_(net|gross)(_currency)?_*`) and, when present, registers an `arch_price_value_filter` filter handler. That handler, `SearchApiPriceFilter` (extending `SearchApiNumeric`), lets an editor filter the view by **net or gross** price in a selected currency, optionally exposing the currency choice to visitors. Critically, it enumerates only the price types the current user may `view` (via `PriceTypeManager::getAvailablePriceTypes`), builds the matching indexed field names (`arch_price_{base}_{price_type}_{currency}`) and adds them as an OR condition group — so per-role price-type visibility is preserved in search. Requires `arch_price`, `views` and `search_api`.

---

- Add a price range filter to a Search API product listing or search page.
- Filter products by **net** or **gross** price depending on the storefront's display convention.
- Constrain results to a specific currency, or expose a currency selector to shoppers.
- Build faceted product search where price is one of the facets.
- Respect per-role price-type access — a visitor only filters on price types they can view.
- Support "between" price filtering (min/max) on an indexed product view.
- Support simple comparison operators (=, <, >, etc.) on the price field.
- Support empty / not-empty operators to find products with or without a price of a given type.
- Provide a "price from – to" exposed filter on a catalog page.
- Combine price filtering with other Search API facets (category, stock, attributes).
- Let a merchant expose the currency picker only where multi-currency pricing is enabled.
- Keep price-type permission logic consistent between entity views and search views.
- Alter the effective filter currency programmatically via the `arch_price_search_api_filter_currency` alter hook.
- Configure the default price base (net) and currency per view via the filter's options form.
- Drive a "products under X" promotional listing from a Search API index.
- Enable performant price filtering on large catalogs by pushing the condition into the search backend.
- Reuse the same indexed price fields across multiple views and exposed filters.
