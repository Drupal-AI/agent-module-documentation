# PHP API: the IntlDate service and hooks

Service id `intl_date.service` → class `Drupal\intl_date\IntlDate`. The two public methods are
**static**, so you can call them directly on the class (the Twig extension and field formatters
both do) — no need to fetch the service.

## Methods

```php
// Format a timestamp with a raw ICU pattern.
// Returns the formatted string, or FALSE on error.
IntlDate::format(int $timestamp, string $pattern, ?string $langcode = NULL, ?string $timezone = NULL);

// Format a timestamp using a stored intl_date_format entity by id.
// Throws \IntlException if the id does not exist.
IntlDate::formatPattern(int $timestamp, string $date_format, ?string $langcode = NULL, ?string $timezone = NULL);
```

- `$langcode` NULL → the current interface language
  (`\Drupal::languageManager()->getCurrentLanguage()`).
- `$timezone` NULL/empty → the default (server/`date_default_timezone`) zone.
- Internally builds `new \IntlDateFormatter($locale, FULL, FULL, $timezone, NULL, $pattern)` and
  calls `->format($timestamp)`. The locale is resolved from a built-in
  language-code → ICU-locale map (`IntlDate::LOCALE_LANGUAGE_MAP`), falling back to `en_US.UTF-8`.

Example:

```php
use Drupal\intl_date\IntlDate;

$label = IntlDate::format($node->getCreatedTime(), 'eeee, MMMM d, yyyy', 'de');
$iso   = IntlDate::formatPattern(time(), 'html_datetime');
```

## Hooks the module invokes for you

Defined in `intl_date.api.php`; implement in a `.module`:

### `hook_intl_date_locale_map_alter(&$map)`
Add or override entries in the language-code → ICU-locale map used by `format()`. Only invoked
when a container is present.

```php
function mymodule_intl_date_locale_map_alter(&$map) {
  $map['de'] = 'de_AT.UTF-8'; // Use Austrian German.
  $map['xe'] = 'xe_XE.UTF-16';
}
```

### `hook_intl_date_formatted_date(&$formatted_date, $context)`
Post-process the produced string. `$context` provides `langcode`, `locale`, `pattern` and
`timestamp` (the doc comment names language/locale/pattern; the code also passes `timestamp`).

```php
function mymodule_intl_date_formatted_date(&$formatted_date, $context) {
  if ($context['langcode'] === 'mn') {
    $formatted_date = mb_strtolower($formatted_date);
  }
}
```

## Hook the module implements

`hook_entity_type_build()` in `intl_date.module` attaches the add/edit/delete form classes and
the `IntlDateFormatListBuilder` to the `intl_date_format` entity type. Nothing an integrator
needs to call.
