# Views Contextual Range Filter — agent index

Turns a Views contextual filter (argument) into a RANGE filter driven by the URL
(`/view/100--199.99`, `--149.95`, `100--`, `+` for OR, `:` alt separator). Supports numeric,
date and alphabetic ranges plus a PHP-code default argument.

- **Convert a contextual filter to a range filter; settings config keys; URL range syntax** →
  [configure/assignment.md](configure/assignment.md)
- **The Views plugins it provides (argument handlers, validator, php_default) + query building** →
  [plugins/argument-plugins.md](plugins/argument-plugins.md)
- **Permissions (`administer contextual range filters`, `use php code…`)** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Config UI: `/admin/config/content/contextual-range-filter` (route
  `contextual_range_filter.settings`, perm `administer contextual range filters`).
- Config object `contextual_range_filter.settings` keys: `numeric_field_names`,
  `string_field_names`, `date_field_names` — each a list of `table:field` machine names that
  have been converted to range filters.
- Argument plugin ids: `numeric_range`, `string_range`, `date_range`. Argument-default:
  `php_default`. Argument-validator: `numeric_range`.
- Converting a filter both records it in the settings config AND rewrites the View's argument
  `plugin_id` to the matching `*_range` plugin (then clears all caches).
- Range separators: `--` (primary) or `:`. All ranges are inclusive.
