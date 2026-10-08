# Commerce Stock Field — agent index

Provides the **`commerce_stock_level`** field type (+ widgets & a formatter) so editors can
view/adjust a variation's stock on its edit form. Widget edits become stock transactions via
the stock service, so it needs `commerce_stock_local` to store anything. Depends on
`commerce_product`, `commerce_stock`, `commerce_stock_local`. No configure route.

- **The field type, widgets, formatter, and how to attach it to a variation type** →
  [api/field.md](api/field.md)

Key facts:
- Field type: `commerce_stock_level` (numeric, precision 19 / scale 4).
- Widgets: `commerce_stock_level_simple`, `commerce_stock_level_absolute`,
  `commerce_stock_level_simple_transaction` (all for field type `commerce_stock_level`).
- Formatter: `commerce_stock_level_simple` (read-only current level).
- Attaching = create a `commerce_stock_level` field on `commerce_product_variation` (or any
  purchasable entity type) and pick a widget on Manage form display.
- Widget settings schema: `field.widget.settings.commerce_stock_level_simple` /
  `_absolute` / `_simple_transaction`. The "required" toggle is removed from field settings.
