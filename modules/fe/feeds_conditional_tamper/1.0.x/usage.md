<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Feeds Tamper plugins that skip an entire feed item or clear a single field value when a configurable source-field condition matches.

---

Feeds Conditional Tamper adds two Tamper plugins to the Feeds Tamper pipeline. **Skip item on condition** (`skip_item_on_condition`) drops the whole feed row so no entity is created or updated for it; **Skip value on condition** (`skip_value_on_condition`) clears just the current mapped field value (sets it to NULL) while the rest of the row imports as normal. Both plugins share the same condition form (from `ConditionalTamperBase`): pick a **condition source** — any source field in the feed row, or the current field value being tampered — an **operator** (equals, does not equal, contains, does not contain, matches / does not match regular expression, is empty, is not empty), a **comparison value**, and a **case-sensitive** flag. Regex operators take a full PHP pattern with delimiters and flags and are validated on save. You attach the plugins on a feed type's Tamper/mapping UI; there is no configuration page, no route, and no permission of its own. It requires Drupal 10.2 or 11, plus the `tamper` and `feeds_tamper` (^2.0) modules.

---

- Skip feed rows whose `status` column equals `draft` so unpublished content never imports.
- Skip rows whose `status` equals `archived` or `deleted` to keep retired records out of the site.
- Import only rows of a given `type` by skipping items where `type` does not equal `article`.
- Drop rows where a required `id` or `sku` source column is empty (is-empty operator).
- Skip rows whose `title` contains a spam or placeholder marker such as `TEST` or `lorem`.
- Skip rows whose price/quantity column fails a numeric-format regex like `/^\d+(\.\d{2})?$/`.
- Skip rows whose `event_date` does not match the `YYYY-MM-DD` pattern `/^\d{4}-\d{2}-\d{2}$/`.
- Clear a `field_pdf_url` value on rows whose `type` is not `resource`, keeping the node but blanking the URL.
- Clear a `field_subtitle` value when the incoming subtitle is empty, so a stale value from a prior import is not left behind.
- Blank a promotional `field_banner` when a `campaign` column contains `expired`.
- Suppress a `field_price` value on rows whose `currency` does not equal the site currency.
- Cross-reference columns: attach to `field_a` but test a different source column (`condition source`) to decide the skip.
- Case-insensitive category matching by leaving *Case sensitive* unchecked (default) so `Draft`, `draft`, and `DRAFT` all match.
- Case-sensitive matching (checked) to distinguish codes like `AB` from `ab`.
- Use *does not contain* to keep only rows whose `tags` column includes a required keyword.
- Use *matches regular expression* to keep only rows whose `email` column looks like a valid address.
- Use *does not match regular expression* to drop rows with malformed identifiers.
- Order a conditional skip before transformation tampers (string ops, date conversion) on the same source to avoid processing values that will be dropped.
- Combine both plugins across sources: drop clearly invalid rows with skip-item, and null out optional-but-malformed fields with skip-value.
- Replace a hand-rolled parser filter with a UI-configurable condition that content editors can adjust without code.
- Enforce lightweight per-row data quality gates in a scheduled Feeds import.
