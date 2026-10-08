Views dynamic fields and filters conditionally shows or hides a Views display's fields and filters based on request-parameter values, without cloning the view or writing custom code.

---

The module adds a "Dynamic fields and filters" section to the *advanced* column of every Views display in the Views edit UI. Per display you map up to nine request parameters (query, POST, exposed-filter/sort identifiers, or contextual-filter query defaults) to the aliases `dff1`–`dff9`. You then embed a small condition syntax inside the *administrative title* of any field or filter — for example `dff1|page|My title` — and the field or filter is only kept when that condition evaluates true against the incoming request. Conditions support operator expressions (`neq`, `in`, `nin`, `gt`, `lt`, `cn`, `ncn`) and can be chained with `AND`, `OR` and `XOR`. It works with any display type and any format (page, block, REST/JSON export, RSS/Serializer, etc.) that uses the display's fields and filters, and integrates cleanly with core Views and modules such as Views Conditional. The implementation is a Views display extender plugin plus a `hook_views_pre_build()` that excludes non-matching fields and unsets non-matching filters before the query is built.

---

- Show a "Author" field only when an exposed "Content type" filter equals `page`.
- Hide detail columns in a table view unless `?show_details=1` is present.
- Apply an extra non-exposed filter only when a search-mode parameter is set to `range`.
- Build a single content-browser view whose columns change with the selected content type.
- Return different fields from one Views JSON/REST export depending on query parameters.
- Add a range filter to a search page only when the user picks "range" mode.
- Vary an RSS/Serializer feed's fields per request without separate displays.
- Express funnels: apply filter A only if exposed filter B is `foo`/`bar` and filter C > 25.
- Toggle fields on a value greater-than test, e.g. `dff2|{gt:5}|`.
- Match any of several values with `dff4|{in:foo,bar}|`.
- Exclude specific values with `dff3|{nin:draft,archived}|`.
- Show a field only when a parameter contains a substring using `{cn:...}`.
- Combine conditions: `dff2|{gt:5}|AND|dff4|{in:foo,bar}|OR|dff3|foobar|`.
- Drive display from contextual filters whose default is a query parameter.
- Drive display from POST parameters as well as GET query strings.
- Handle multi-value query parameters like `?types[]=foo&types[]=bar` (matches if any element does).
- Enable case-insensitive comparison per display for lenient string matching.
- Copy a display's parameter/condition setup into another display of the same view.
- Add the `url.query_args` cache context so Serializer/RSS responses vary correctly per query.
- Avoid maintaining several near-identical view displays for minor field differences.
- Give one exposed form control over both which results and which columns appear.
- Keep a REST export lean by returning only the fields a caller asked for.
- Reuse one view across multiple front-end contexts by switching visible fields.
- Prototype conditional field/filter logic in the UI before considering custom code.
