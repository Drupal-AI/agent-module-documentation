<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Filters Combine Field provides a Views string-filter plugin that lets one exposed filter search across several chosen View fields at once. Selected fields are combined with `CONCAT_WS(' ', ...)` and matched with the standard string-filter operators; a JS layer adds a per-search field/operator selector.

---

The filter extends core `StringFilter`, so operator handling and value matching go through the Views query API (`addWhere`/`addWhereExpression`) with the search value passed as a bound placeholder (and `LIKE` values escaped via `escapeLike`) — no raw concatenation of the user's search term into SQL. The combined `CONCAT_WS` expression is assembled from `$field->tableAlias.$field->realField`, i.e. Views-internal column aliases from the admin-configured field handlers, not from request input; the exposed `select_field` is validated against the View's existing field handlers (`$this->view->field[...]`) before use. So there is no SQL-injection sink from end-user input. The plugin is functionally messy (webform/node special-casing, duplicated assignments) but not a security concern.

---

- Search several View fields with a single exposed filter.
- Combine title, body and custom fields into one search box.
- Let visitors pick which field to search at query time.
- Offer contains/starts/ends/regex operators on combined fields.
- Build a simple site-search-style filter over a View.
- Concatenate chosen fields with `CONCAT_WS` for matching.
- Populate the field selector from clickable View fields.
- Support node and webform-submission base tables.
- Expose taxonomy/entity-reference option lists for values.
- Reduce many separate exposed filters to one control.
- Add the filter through the Views UI.
- Keep search values placeholdered (no manual SQL).
- Restrict selectable fields to configured View field handlers.
- Provide a JS-enhanced operator dropdown per search.
- Use on content listings that need cross-field search.
- Pair with an exposed-filter block for a search bar.
- Validate that fields are added before enabling the filter.
