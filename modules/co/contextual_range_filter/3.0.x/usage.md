Views Contextual Range Filter lets a View's contextual filter (argument) match a RANGE of values from the URL — numeric, date or alphabetic — using a `from--to` syntax such as `/yourview/100--199.99`, instead of only a single exact value.

---

The module adds range-aware replacements for core Views' contextual filter (argument) handlers. Where a normal contextual filter matches one value, these match an inclusive range read from the URL using `--` (or `:`) as the separator: `100--199.99`, open-ended `100--` or `--149.95`, single values, and OR'd multiples with `+` (when "Allow multiple ranges" is on). It ships three argument plugins — `numeric_range`, `string_range` (case-insensitive alphabetic, glossary-mode aware) and `date_range` (supports strict `YYYY-MM-DD` and relative dates like "10 days ago") — plus a `numeric_range` argument validator and a `php_default` argument-default plugin that runs a PHP snippet to compute a default range (great for "related content" side blocks). Because Views instantiates the handler class before you can pick a range variant, you convert an existing contextual filter into a range filter on the settings page at `/admin/config/content/contextual-range-filter` (route `contextual_range_filter.settings`, permission `administer contextual range filters`): tick the filters to convert, and the module both records them in `contextual_range_filter.settings` (`numeric_field_names` / `string_field_names` / `date_field_names`) and rewrites each affected View's argument `plugin_id` to the `*_range` variant. At query time `ContextualRangeFilter::buildRangeQuery()` turns each range into `BETWEEN` / `>=` / `<=` (or negated `NOT BETWEEN` etc. when "Exclude" is ticked) WHERE expressions. The "Exclude" negation and Views "Glossary mode" are supported.

---

- Filter a product View by price range from the URL, e.g. `/products/100--199.99`.
- Show catalogue items within a distance range (float field) contextually.
- Build an A–Z glossary View that shows titles in an alphabetic range like `/glossary/k--q`.
- Filter content published within a date range, e.g. `/news/2020-01-01--2020-06-30`.
- Use relative dates in a date range filter such as "10 days ago--tomorrow".
- Create open-ended ranges: everything from 100 up (`/view/100--`) or up to 149.95 (`/view/--149.95`).
- Match a single value or a range with the same contextual filter.
- OR several ranges together with `+`, e.g. `/view/a--e+k--r`.
- Exclude (negate) a range so results OUTSIDE it are shown ("Exclude" tickbox → NOT BETWEEN).
- Filter by node ID or taxonomy term ID ranges (they are numeric).
- Filter by list-field key ranges.
- Drive a "related content" block from a PHP default range around the current node's value.
- Show "similarly priced products" using a php_default snippet returning `--<price>` or a band.
- Show "blog posts published around the same time" via a computed date range default.
- Validate URL arguments as numeric ranges with the bundled Numeric Range validator.
- Use a colon instead of `--` as the range separator (`/view/100:199`).
- Return all results for a filter position with `all`, `--` or `:`.
- Apply glossary mode so only the first N characters of a string are compared.
- Combine multiple contextual range filters (e.g. Title range then Price range) in one URL.
- Convert an existing single-value contextual filter into a range filter without editing code.
- Keep string range matching case-insensitive regardless of DB collation defaults.
- Filter integer/float/string/date fields, entity IDs and list keys by range.
- Provide URL-driven faceting for content by numeric or date bands.
- Restrict the PHP-default feature to trusted users via a dedicated permission.
