# BigInt — agent index

Adds a `bigint` field type storing an 8-byte DB integer (19 digits) vs core Integer's 4 bytes.
Ships a widget, a formatter, and a Feeds target. No admin UI (`configure` null), no permissions,
no Drush. Depends on core `field`. Provides config schema for its storage/field settings.

- **The field type, storage settings (`unsigned`/`size`), constraints, widget, formatter, and
  Feeds target — with how to add one via Drush** → [configure/field.md](configure/field.md)

Key facts:
- Field type id `bigint` (`Number (bigint)`), extends core `NumericItemBase`; DB column
  `type: int, size: big` → a `BIGINT` column. Default `default_widget: bigint`,
  `default_formatter: bigint_item_default`.
- Default storage settings: `unsigned: TRUE`, `size: big`. `unsigned` adds a `Range` min:0
  validation constraint.
- Widget `bigint` extends `NumberWidget`; formatter `bigint_item_default` extends
  `IntegerFormatter` and groups digits with a string-safe separator.
- Feeds target `bigint` (`src/Feeds/Target/BigInt.php`) maps Feeds imports into bigint fields.
