# Commerce Stock UI — agent index

UI glue for Commerce Stock: a two-step **stock transaction** admin form plus a field widget
linking to it, gated by one permission. No config of its own. Depends on `commerce_stock`.

- **The transaction forms, routes, permission, and the link widget** →
  [configure/ui.md](configure/ui.md)

Key facts:
- Routes: `commerce_stock_ui.stock_transactions1`
  (`/admin/commerce/config/stock/transactions1`, `StockTransactions1` — select a variation)
  → `commerce_stock_ui.stock_transactions2`
  (`/admin/commerce/config/stock/transactions2`, `StockTransactions2` — enter the transaction).
- Menu: "Stock transactions" under Commerce → Configuration → Stock.
- Permission: **`use commerce stock transaction form`** (gates both forms).
- Field widget id `commerce_stock_level_transaction_form_link` ("Link to stock transaction
  form") for `commerce_stock_level` fields — renders a link to the form instead of an editor.
- Persistence still comes from `commerce_stock_local`; this module is presentation only.
