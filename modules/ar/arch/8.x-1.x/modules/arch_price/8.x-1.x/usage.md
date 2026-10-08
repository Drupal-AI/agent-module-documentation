Define price types, VAT categories and multiple per-customer prices for Arch products, with the effective price negotiated server-side.

---

`arch_price` is the pricing core of the Arch commerce suite. It introduces two config entity types — **Price type** (`price_type`, e.g. default/retail/wholesale) and **VAT category** (`vat_category`, a tax rate) — and a composite **`price` field** that a product can carry many times: each price item records a net or gross amount, currency, price type, VAT category and an optional availability window. At display and checkout time the `price.negotiation` service (`PriceNegotiation`) filters a product's prices to those the current user may see (per-role `price_type` access and date range) and returns the single active price per type. Amounts are rendered via the contrib **Currency** module's Intl formatter, and net/gross/VAT values are always derived server-side from the stored field data.

---

- Give a product several prices at once (retail, wholesale, sale, member) via repeated `price` field items.
- Model price lists as **Price type** config entities and gate each one to specific roles.
- Store either a **net** or a **gross** amount per price and let the module compute the other from VAT.
- Attach a **VAT category** (tax rate) to each price and derive the VAT value/percentage automatically.
- Support a special "custom" VAT category whose rate is entered per price item.
- Limit a price to an availability window (available-from / available-to timestamps).
- Negotiate the correct customer-facing price per request with `PriceNegotiation::getActivePrice()`.
- Expose the original (pre-discount) price with `getOriginalPrice()` for strike-through displays.
- Let other modules adjust prices through the `hook_price_access`, `hook_product_active_price`, `hook_product_available_prices` and `price_negotiation_prices` alter hooks.
- Format prices in the visitor's locale/currency using the Currency module's `Intl` amount formatter.
- Configure store-wide price defaults (default currency, price display) at `/admin/store/price`.
- Restrict price administration behind the `administer prices` permission (restricted).
- Grant per-price-type view/create/update/delete permissions to roles.
- Provide a default price display formatter and a price-table widget for editing multiple prices.
- Index and filter products by price in Search API via the `arch_price_search_api` submodule.
- Build a `Price` value object (`PriceFactory`) for programmatic price math and formatting.
- Ship default `price_type.default`, `vat_category.default` and `vat_category.custom` config on install.
- Keep all price/VAT/net-gross computation on the server — no client-submitted amount is ever trusted.
