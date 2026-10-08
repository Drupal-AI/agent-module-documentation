<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# IntlDate (intl_date) — agent index

Locale-aware date/time formatting built on PHP's **intl / ICU** extension. Formats are
`intl_date_format` **config entities** (an ICU pattern per named format); the module ships
field formatters, two Twig filters and a static PHP helper that render a timestamp with the
right per-locale month names, ordering, calendars and numerals — cases a fixed `date()`
pattern cannot express.

- Requires the PHP **intl** extension (`ext-intl`); `hook_requirements` errors on install if missing.
- Core `^10.1 || ^11`, PHP `>= 8.0`. No module dependencies. No own permissions, no drush.
- `configure`: no `configure:` key in info.yml, but an admin UI (an entity collection) lives at
  `/admin/config/regional/intl-date-time` (route `entity.intl_date_format.collection`), gated by
  `administer site configuration`.

Solutions:
- **Create / edit named ICU date formats (admin UI, drush, PHP)** → [configure/formats.md](configure/formats.md)
- **Render a date or timestamp field with an ICU format** → [fields/formatters.md](fields/formatters.md)
- **Format a date inside a Twig template** → [theme/twig.md](theme/twig.md)
- **Format a date from PHP, and alter the output or locale map** → [api/service.md](api/service.md)

Key facts:
- Config entity: `intl_date_format` (keys `id`, `label`, `pattern`; pattern is an ICU string).
- Shipped formats: `short`, `medium`, `long`, `fallback`, `html_date`, `html_datetime`,
  `html_time`, `html_week`, `html_month`, `html_year`, `html_yearless_date`.
- Service id `intl_date.service` → class `Drupal\intl_date\IntlDate`; its methods are **static**:
  `IntlDate::format($timestamp, $pattern, $langcode = NULL, $timezone = NULL)` and
  `IntlDate::formatPattern($timestamp, $format_id, $langcode = NULL, $timezone = NULL)`.
- Twig filters: `intl_format_date` (pattern) and `intl_format_date_pattern` (format id).
- Field formatters: `datetime_intl_default` (field type `datetime`) and `intl_timestamp`
  (field types `timestamp`, `created`, `changed`).
- Integration hooks: `hook_intl_date_locale_map_alter(&$map)`,
  `hook_intl_date_formatted_date(&$formatted_date, $context)`.
- Route/perm: `entity.intl_date_format.collection` at `/admin/config/regional/intl-date-time`,
  `administer site configuration`. Config schema: `intl_date.intl_date_format.*`.
