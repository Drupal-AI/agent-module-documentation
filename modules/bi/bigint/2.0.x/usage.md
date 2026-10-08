BigInt adds a `bigint` numeric field type that stores an 8-byte database integer (up to 19 digits) instead of the 4-byte range of core's Integer field, for IDs and counters that overflow a normal int.

---

The module registers a single field type plugin, `bigint` (label "Number (bigint)"), extending core `NumericItemBase`, whose `schema()` declares a database column of `type: int`, `size: big`, so MySQL/PostgreSQL create a `BIGINT`/`bigint` column (signed range ±9.2×10¹⁸, unsigned 0–1.8×10¹⁹). Storage settings default to `unsigned: TRUE` and `size: big`; when `unsigned` is on, the item adds a `Range` constraint with `min: 0` so negative values are rejected in validation as well as at the DB level. It ships a matching widget (`bigint`, extending core `NumberWidget`) and a default formatter (`bigint_item_default`, extending core `IntegerFormatter`) whose `numberFormat()` groups digits by the configured thousand separator using a string-safe `str_split` (avoiding float precision loss on very large numbers). A `Feeds` target plugin (`Drupal\bigint\Feeds\Target\BigInt`, extends the Feeds Integer target) lets Feeds import map values into bigint fields when the Feeds module is present. Config schema is provided for `field.storage_settings.bigint` (unsigned + size) and `field.field_settings.bigint` (inherits the core integer field settings such as min/max/prefix/suffix). There is no admin settings page — you use it like any field: add a "Number (bigint)" field to an entity and configure it on the field's edit form.

---

- Store database primary keys or external IDs that exceed the 2.1-billion limit of a core Integer field.
- Hold Unix timestamps in milliseconds or other large counters without overflow.
- Persist large financial or accounting integers (cents) that go beyond 32-bit range.
- Store 64-bit identifiers imported from another system (e.g. social media IDs, ERP keys).
- Keep an unsigned big integer field (0 and up) by leaving the default `unsigned` setting on.
- Allow negative big integers by unchecking `unsigned` in the field's storage settings.
- Add a "Number (bigint)" field to a content type, taxonomy term, user, or any fieldable entity.
- Format very large numbers with thousand separators without floating-point rounding errors.
- Set min/max/prefix/suffix on the field via the inherited core integer field settings.
- Enforce a non-negative range constraint automatically when the field is unsigned.
- Import large integer values into a bigint field using the Feeds module target mapper.
- Migrate legacy `bigint` columns into Drupal fields while preserving full precision.
- Replace a core Integer field that is hitting range limits with a drop-in bigint equivalent.
- Store phone-number-like or barcode numeric values that exceed 10 digits (where numeric storage is desired).
- Track high-volume view/like/download counters that could surpass 2 billion.
- Represent large geospatial or scientific integer measurements.
- Use the bigint widget (a standard number input) on entity edit forms.
- Display bigint values with the default integer formatter, including separator grouping.
- Provide 64-bit ID storage for custom entities defined by other modules via a configurable field.
- Generate sample big-integer values for test content (respects field min/max settings).
