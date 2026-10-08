Views Contextual Filter Validator: Number Range adds a "Range" argument validator that lets a View contextual filter accept only numeric argument values that fall within a configured minimum/maximum range.

---

The module ships a single Views argument-validator plugin (id `range`, class `RangeArgumentValidator`) that plugs into the standard "Specify validation criteria" section of any Views contextual filter. In the filter's configuration you set an inclusive Minimum value, Maximum value, or both; either bound may be left blank for an open-ended range. At request time the plugin casts the incoming argument to a float, checks that it `is_numeric`, and returns valid only when the number satisfies the configured bounds — otherwise the filter's "Action to take if filter value does not validate" (e.g. hide the view, show a 404) takes over. It has no settings form, no routes, no permissions, and no config of its own; all configuration lives inside the View. It depends only on core Views and works on Drupal 9.5, 10, and 11. Note that validation constrains input format, not access — it is not an access-control mechanism.

---

- Restrict a Views contextual filter to numeric arguments only, rejecting non-numeric values.
- Constrain a contextual-filter argument to an inclusive minimum value (open-ended maximum).
- Constrain a contextual-filter argument to an inclusive maximum value (open-ended minimum).
- Constrain a contextual-filter argument to a closed numeric range (both min and max).
- Show a view attachment only on the first page by validating the `page` query parameter against max 0.
- Hide a display when a numeric URL argument falls outside an allowed range.
- Return 404 / access-denied behavior for out-of-range numeric arguments via the filter's validate-fail action.
- Validate a paged offset argument so only expected page numbers render a display.
- Limit a "year" contextual filter to a sane range (e.g. min 2000, max current year).
- Limit a "rating" or "score" contextual filter to a 0–5 or 0–100 range.
- Gate a promotional block/attachment to a specific numeric threshold.
- Accept only non-negative numeric arguments by setting minimum value to 0.
- Combine with a query-parameter default value to conditionally display content.
- Provide clean fallback behavior when a numeric argument is missing or invalid.
- Validate a "quantity" or "count" contextual filter against business limits.
- Ensure a numeric ID argument is within an expected range before running the view.
- Drive different displays/attachments on/off depending on a numeric URL segment.
- Apply the validator to multiple displays of the same view with different ranges.
- Use the min/max form fields (HTML number inputs) that appear once "Range" is selected as the validator.
- Rely on inclusive bounds (both endpoints count as valid).
