<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# experience formatters

Both formatters extend `FormatterBase`, declare `field_types = {experience}`, and take no formatter settings. Select them on the bundle's **Manage display**. They decode the stored integer (total months) back into years/months using the same rules as the widget.

## `experience_default` — `ExperienceDefaultFormatter`

Label "Default". `viewElements()` output per item (`#markup`, values passed as `@year`/`@month` placeholders through `t()`):

- `value == 0` → `Fresher`.
- year and month both non-zero → `@year Year(s) @month Month(s)`.
- year only → `@year Year(s)`.
- month only → `@month Month(s)`.

(`value > 11` splits into `floor(value/12)` years + `value % 12` months; `value <= 11` is 0 years, `value` months.)

## `experience_month` — `ExperienceMonthFormatter`

Label "Month". Simpler: `value == 0` → `Fresher`; otherwise renders the raw stored integer as `@month Month(s)` (i.e. total months, not split into years).

## Notes

- Both formatters render via `#markup` with `t()` placeholder substitution over integer field values; no formatter configuration or user-supplied markup is involved.
- Each also copies any `$item->_attributes` into `#options['attributes']` (standard Field API attribute passthrough) and unsets them afterward.
