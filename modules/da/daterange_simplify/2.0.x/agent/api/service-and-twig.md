<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Simplify service and the Twig extension

Two services in `daterange_simplify.services.yml`:

```yaml
daterange_simplify.simplify:
  class: Drupal\daterange_simplify\Simplify
daterange_simplify.twig_extensions:
  arguments: ['@renderer']
  class: Drupal\daterange_simplify\TwigExtension\Extension
  tags:
    - { name: twig.extension }
```

## `Simplify` service (`daterange_simplify.simplify`)

Class `src/Simplify.php`. Methods are effectively static wrappers around `OpenPsa\Ranger\Ranger`.

- `getAllowedFormats(bool $restrict_intl = FALSE): array`
  → `['none','full','long','medium','short']`, or `['none','short']` when restricted.
- `daterange(DrupalDateTime $start, DrupalDateTime $end, $date_format='medium',
  $time_format='short', $range_separator=null, $date_time_separator=null, $locale='en'): string`
  — builds a `Ranger($locale)`, sets date/time types (mapped to `IntlDateFormatter` constants via
  the protected `getDateFormat()`), optionally sets the range and date-time separators, formats
  both endpoints as ISO 8601 (`->format('c')`), and returns `$ranger->format($start, $end)`. If
  `$end` is empty it reuses `$start`.
- `datetime(DrupalDateTime $time, $date_format='medium', $time_format='short', $locale='en'):
  string` — single-value form; calls `$ranger->format($time, $time)`.
- `toDrupalDateTime($datetime, $tz_override=NULL, bool $date_only=FALSE): DrupalDateTime` —
  parses a stored value (numeric → `U`, length-10 → `Y-m-d`, else `Y-m-d\TH:i:s`) as UTC, applies
  the user/system time zone (or `DateTimeItemInterface::STORAGE_TIMEZONE` when `date_only`), then
  applies `$tz_override` if provided. The protected `setTimeZone()` mirrors core's
  `DateTimeFormatterBase`.

Call it from PHP:

```php
$s = \Drupal::service('daterange_simplify.simplify');
$start = $s->toDrupalDateTime('2013-10-05T10:00:00');
$end   = $s->toDrupalDateTime('2013-10-05T13:30:00');
$phrase = $s->daterange($start, $end, 'medium', 'short', ' to ', ', ', 'en');
// e.g. "Oct 5, 2013, 10:00 AM to 1:30 PM"
```

## Twig extension (`daterange_simplify.twig_extensions`)

Class `src/TwigExtension/Extension.php` (`getName()` → `daterange_simplify.twig_extensions`).

### Filter `intl_date`

```twig
{{ value|intl_date(dateformat='medium', timeformat='none', lang=NULL) }}
```

`Extension::format($datetime, $dateformat='medium', $timeformat='none', $lang=NULL)`:
- resolves `$lang` to `currentLanguageId()` when null;
- if `$datetime` is not already a `DrupalDateTime`, runs it through the service's
  `toDrupalDateTime()` (so a raw ISO string, `Y-m-d`, or UNIX timestamp works);
- returns `Simplify::datetime($datetime, $dateformat, $timeformat, $lang)`.

Examples:

```twig
{{ node.field_when.0.value|intl_date('long', 'short') }}
{{ '2013-10-05T10:00:00'|intl_date('full', 'none', 'de') }}
{{ 1381000000|intl_date('short', 'short') }}
```

### Function `current_lang`

```twig
{{ current_lang() }}          {# two-letter id, from URL language by default #}
```

`Extension::currentLanguageId($from_url = TRUE)` returns the id of the current
`LanguageInterface::TYPE_URL` language (or `TYPE_INTERFACE` when `$from_url` is false).

## Notes

- The service exposes only default `en` formatting unless a locale is passed; the Twig filter
  defaults the locale to the current language automatically.
- Time style is not restricted at the service/Twig layer (only the formatter UI limits time to
  `none`/`short`) — any of `none/full/long/medium/short` maps to an `IntlDateFormatter` constant.
- Non-`en` locales require the PHP `php-intl` extension.
