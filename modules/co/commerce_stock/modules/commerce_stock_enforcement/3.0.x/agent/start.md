# Commerce Stock Enforcement — agent index

Blocks over-selling: validates stock on the **add-to-cart** form, the **cart** page, and
**checkout**, disabling out-of-stock purchases and showing configurable messages. Pure form
alteration + validators on top of `commerce_stock.service_manager`; needs real levels (i.e.
`commerce_stock_local`) to enforce anything. Depends on `commerce_product`, `commerce_stock`.
Configure route: `commerce_stock_enforcement.settings`
(`/admin/commerce/config/stock/enforcement/settings`).

- **The behavior and the configurable messages** →
  [configure/enforcement.md](configure/enforcement.md)

Key facts:
- Config `commerce_stock_enforcement.settings` (3 message strings):
  - `insufficient_stock_cart` — placeholders `%name`, `%qty`
  - `insufficient_stock_add_to_cart_zero_in_cart` — placeholders `%qty`, `%qty_asked`
  - `insufficient_stock_add_to_cart_quantity_in_cart` — placeholders `%qty`, `%qty_o`
- Where it acts: add-to-cart (disable + "Out of stock" button), cart form
  (`commerce_cart_form` view), checkout (redirect to cart on failure).
- Stock level read via `commerce.service_manager`; `always_in_stock` = nothing blocked.
- No permissions or plugins of its own; settings gated by `administer commerce stock`.
