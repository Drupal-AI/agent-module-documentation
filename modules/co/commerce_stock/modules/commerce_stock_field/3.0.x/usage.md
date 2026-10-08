Commerce Stock Field provides a `commerce_stock_level` field (with widgets and a formatter) so editors can view and adjust a product variation's stock directly on its edit form, writing stock transactions into Commerce Stock Local Storage.

---

The submodule defines the `commerce_stock_level` field type (a numeric value, precision 19 scale 4) plus three widgets and a formatter that bridge the field to the stock service. Widgets: `commerce_stock_level_simple` (a simple entry system — set an absolute level or adjust, with optional transaction note and context fallback), `commerce_stock_level_absolute` (enter the exact resulting level; the widget computes the adjusting transaction) and `commerce_stock_level_simple_transaction` (enter a signed transaction/adjustment with a note). The formatter `commerce_stock_level_simple` renders the current level read-only. When you attach the field to a purchasable entity type (typically a product variation type) and edit an entity, the widget's `StockLevelProcessor` creates the appropriate stock transaction via the stock service (so it requires `commerce_stock_local` to actually store anything). It also removes the "required" toggle from the field settings form (stock level is computed, not a stored scalar you can require). Widget settings are schema-validated (`field.widget.settings.commerce_stock_level_*`). No configure route, permissions, or Drush of its own.

---

- Add a stock-level field to a product variation type so editors manage inventory inline.
- Let editors set an absolute stock quantity on a variation (absolute widget).
- Let staff enter a signed adjustment (+10, -3) as a stock transaction with a note.
- Show the current stock level read-only on a variation display via the formatter.
- Capture a transaction note describing why stock changed.
- Use the simple entry widget for a straightforward "set the level" UX.
- Record stock changes as proper transactions rather than overwriting a number.
- Attach stock editing to any purchasable entity type, not just the default variation.
- Provide a per-variation-type inventory field configured through Manage form display.
- Combine with Commerce Stock Local Storage so widget edits persist as transactions.
- Fall back to the current store/customer context when no location is specified (context fallback).
- Step stock entry by a configurable amount on the absolute/transaction widgets.
- Give a default transaction note for bulk edits.
- Render stock level in a variation's view display for shop staff.
- Keep stock data on the entity form so editing product and stock happens in one place.
- Migrate legacy stock numbers by entering absolute levels through the widget.
- Prevent the field from being marked required (it is computed from transactions).
- Expose stock level as a field usable in Views and displays.
- Support multiple widget styles depending on the editorial workflow.
- Let a warehouse workflow enter incoming stock as positive transactions.
