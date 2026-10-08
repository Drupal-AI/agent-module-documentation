<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Number Formatter adds one field-display formatter that renders integer, decimal and float field values through PHP's intl `NumberFormatter`, so a number can be shown as a locale-aware decimal, currency, percent, scientific, spell-out, ordinal or duration string.

---

Core ships a "Number" formatter that lets you set a fixed number of decimals, a thousands/decimal separator and a prefix/suffix, but it has no concept of locale, currency codes, percentages, scientific notation, ordinals ("1st", "2nd") or spelling a value out in words. This module fills that gap by delegating the actual formatting to PHP's `intl` extension: you pick a NumberFormatter *style* on the field's *Manage display* screen, and the value is formatted for a chosen language. It is a small, focused module — a single `FormatterBase` plugin (id `number_formatter`) and nothing else: no entities, no routes, no permissions, no services, no blocks.

The formatter targets the three core number field types (`integer`, `decimal`, `float`). Choose a style from eight options; for the Currency style you also enter a 3-letter ISO 4217 currency code, and `formatCurrency()` renders the value with the right symbol and grouping for the language. For the non-currency styles the value is run through `NumberFormatter::format()` and wrapped with the number field's own prefix/suffix (with singular/plural handling via `|`). On a multilingual site an extra option lets you pick which language drives the formatting. The `intl` PHP extension is required; `hook_requirements()` reports an error on the status page if it is missing.

---

- Display a price as locale-aware currency with the correct symbol (e.g. `$1,234.56`, `1.234,56 €`).
- Format a decimal field as a percentage without storing the `%` in the data.
- Show a very large or very small float in scientific notation.
- Spell a number out in words ("one thousand two hundred") for accessibility or invoices.
- Render an integer as an ordinal ("1st", "2nd", "3rd") for rankings or positions.
- Format a numeric seconds field as a duration.
- Present quantities with grouped thousands separators that match the site language.
- Reuse the number field's existing prefix/suffix (unit label) around the formatted value.
- Switch a field's number presentation without changing the stored value.
- Apply different styles to the same value across view modes (teaser vs. full).
- Show currency amounts in EUR on one field and USD on another via the per-display currency setting.
- Localize number grouping/decimal marks by choosing the field or current language on a multilingual site.
- Format measurement values (weights, distances) with consistent decimal grouping.
- Display statistics or KPIs as percentages on a dashboard node.
- Render ratings or scores as spelled-out or ordinal text.
- Show scientific/engineering data fields in exponential form.
- Keep numeric storage clean (raw number) while presenting a formatted string on output.
- Provide accessible, human-readable numbers in reports and printed/PDF views.
- Format financial figures per-locale in a multilingual commerce or catalogue site.
- Verify the `intl` extension is installed via the module's status-report requirement check.
