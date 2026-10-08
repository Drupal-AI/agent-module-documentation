Commerce Stock UI adds admin user-interface elements for Commerce Stock: a two-step "Create stock transaction" form (pick a variation, then enter the transaction) and a field widget that links to it, gated by a dedicated permission.

---

The submodule provides the human-facing side of stock management. It registers two forms: `StockTransactions1` at `/admin/commerce/config/stock/transactions1` ("Create stock transaction" — select the product variation) which hands off to `StockTransactions2` at `/admin/commerce/config/stock/transactions2` (enter and submit the actual stock transaction for the chosen variation). Both are reached from a "Stock transactions" admin menu item under Commerce → Configuration → Stock and are gated by the permission **`use commerce stock transaction form`**. It also adds a field widget `commerce_stock_level_transaction_form_link` ("Link to stock transaction form") that, placed on a stock-level field, renders a link to the transaction form instead of an inline editor. The submodule ships no config of its own — it is presentation/permission glue on top of the core stock framework and the local storage service. Give warehouse/back-office staff the transaction-form permission so they can adjust stock without needing full stock administration rights.

---

- Give staff a guided form to create stock transactions (receive, adjust) without code.
- Let a clerk pick a product variation and enter a stock change in two steps.
- Expose a "Stock transactions" admin menu item under Commerce configuration.
- Grant back-office users the `use commerce stock transaction form` permission only.
- Separate "can enter stock transactions" from "can administer stock settings".
- Add a link-to-transaction-form widget on a variation's stock field for quick access.
- Provide a UI entry point for manual stock corrections after a stock count.
- Let non-developers record incoming stock deliveries.
- Route users from a product edit screen to the dedicated transaction form via the widget.
- Support a workflow where warehouse staff use the form and managers set policy.
- Offer a browser-based alternative to the programmatic StockServiceManager API.
- Restrict access to stock entry with a single, purpose-built permission.
- Combine with local storage so form-entered transactions persist and adjust levels.
- Give a role the transaction form permission to enable stock entry for that role.
- Present stock entry as an admin task rather than an inline field on the product form.
- Let staff select any purchasable variation and transact against it.
- Keep the stock-entry UI decoupled from the stock backend service.
- Provide a consistent admin location for stock operations.
