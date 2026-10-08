Views Field Compare adds two Views "Global" filter plugins that let you filter a view by comparing the values of two of the view's own fields against each other, rather than against a static value.

---

The module (via `hook_views_data`) registers two filter handlers under the Views *Global* category: **Field comparison** (`field_comparison`) compares two single-valued fields with a relational operator (`<`, `<=`, `=`, `!=`, `>=`, `>`); **Field contained** (`field_contained`) checks whether a single-valued field's value is IN / NOT IN the set of values of a multi-valued field. Both plugins present admin select lists populated from the fields already added to the view (left/right operand); *Field comparison* only offers click-sortable (simple) fields, and *Field contained* offers click-sortable fields on the left and multi-valued fields on the right. Neither filter can be exposed to end users (`canExpose()` returns FALSE) or grouped — the operands are chosen by the view builder at configuration time. `FieldComparison::query()` resolves each chosen field to its real table alias/column and adds an `addWhereExpression()` like `alias.col <op> alias2.col2`. `FieldContained` builds a correlated sub-SELECT over the multi-valued field's table (reconstructing the field's joins) and adds `IN (...)` / `NOT IN (...)`. Both require the display to use fields and both selected fields to be present; missing fields force `build_info['fail']` so no rows leak. The comparison is done in SQL with limited type casting, so operands should be of compatible types.

---

- Show only rows where a "start date" field is less than an "end date" field.
- Find nodes where the updated/changed field is greater than the created field (edited after creation).
- Filter to rows where two numeric fields are equal (e.g. quantity ordered == quantity shipped).
- Filter to rows where two fields are NOT equal (detect mismatches between two values).
- Compare a "price" field against a "sale price" field to list discounted items.
- List entries where a "current" count field is greater than or equal to a "limit" field.
- Compare two entity-reference target ids to find rows pointing at the same target.
- Build a data-integrity report of rows violating an expected field relationship.
- Filter a view of two joined entity types by comparing a field from each.
- Check whether a single-value taxonomy term field is contained in a multi-value term field.
- Show content whose author is IN a multi-valued "allowed users" field.
- Show content whose category is NOT IN a multi-valued "excluded categories" field.
- Filter memberships where a user's role value is contained in a group's multi-valued roles.
- Compare a chosen tag against a node's multi-value tags list (membership test).
- Exclude rows where a value appears in a related multi-valued field (anti-join style filter).
- Add comparison logic to a view without writing a custom filter plugin.
- Combine with other Views filters/relationships to express cross-field business rules.
- Hide the operand fields in the display (they only need to exist, not be shown).
- Enforce "field A within the set of field B" constraints in list/report views.
- Provide QA views that surface records where two fields disagree.
