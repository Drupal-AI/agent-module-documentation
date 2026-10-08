<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
IntlDate formats dates and times with PHP's **intl / ICU** extension instead of core's `date()`-style patterns, so a timestamp renders correctly per locale — including calendars, month names, ordering and numerals that a single fixed pattern cannot express. Named formats are ICU-pattern config entities, exposed through two field formatters, two Twig filters and a static PHP helper.

---

Drupal's core date formats are `date()` patterns: fixed strings like `d/m/Y` that produce the same shape in every language. That is fine for one locale and wrong for a multilingual site, where "March 5, 2026", "5 mars 2026" and "2026年3月5日" are all the correct rendering of the same instant, and no single pattern yields them. ICU — the standard behind PHP's intl extension — encodes those rules per locale, down to distinguishing a standalone month name (`LLLL`) from a month name inside a full date (`MMMM`), which some languages translate differently, and to using a locale's own script for numerals (e.g. Persian digits for Farsi). This module exposes that: an `intl_date_format` **config entity** (an ICU pattern with a machine name and label) managed at `/admin/config/regional/intl-date-time` under `administer site configuration`; the field formatters `datetime_intl_default` (for `datetime` fields) and `intl_timestamp` (for `timestamp`/`created`/`changed`); the Twig filters `intl_format_date` and `intl_format_date_pattern`; and the static `Drupal\intl_date\IntlDate::format()` / `::formatPattern()` helpers, with `hook_intl_date_locale_map_alter()` and `hook_intl_date_formatted_date()` for customization. Because formats are config entities they export and deploy like core's date formats. It requires the **intl** PHP extension (install fails via `hook_requirements` if it is absent), plus PHP 8.0+ and core `^10.1 || ^11`. The gain over core is precisely the multilingual case; on a single-language site core's date formats are usually simpler and sufficient.

---

- Render dates correctly in every site language.
- Show month names in the visitor's language.
- Distinguish standalone vs. in-date month names (`LLLL` vs `MMMM`).
- Use a locale's own script for date numerals (e.g. Persian digits).
- Use a locale's own field ordering for a date.
- Add named ICU date formats to a site.
- Format a date field with an ICU format via Manage display.
- Format a `created`/`changed`/timestamp field with an ICU format.
- Format a date inside a Twig template with a custom pattern.
- Format a date inside a Twig template from a named preset.
- Format a date from PHP with `IntlDate::format()`.
- Force a specific language or timezone when formatting.
- Export and deploy date formats with configuration sync.
- Give editors named, reusable date formats.
- Override the language-to-locale map for a specific language.
- Post-process a formatted date string globally.
- Provide HTML5-compatible machine date/time strings.
- Improve a multilingual site's date rendering.
- Avoid hard-coding one date pattern per language.
- Reduce bespoke localized date-formatting code.
- Meet a localization requirement for date display.
