# Twig filters

`Drupal\intl_date\TwigExtension` (service `intl_date.twig_extension`, tagged `twig.extension`)
registers two Twig **filters**. Both take a timestamp on the left and delegate to the
`IntlDate` service.

| Filter | Signature | Formats using |
|--------|-----------|---------------|
| `intl_format_date` | `timestamp\|intl_format_date(pattern, langcode = null, timezone = null)` | a raw ICU pattern string |
| `intl_format_date_pattern` | `timestamp\|intl_format_date_pattern(format_id, langcode = null, timezone = null)` | the id of an existing `intl_date_format` entity |

The input value must be a UNIX **timestamp** (integer seconds).

## Examples

```twig
{# Custom ICU pattern: standalone month name + year #}
{{ 1626255230|intl_format_date('yyyy LLLL') }}

{# Use a named preset entity #}
{{ 1626255230|intl_format_date_pattern('medium') }}

{# Force a language / timezone regardless of current interface language #}
{{ node.created.value|intl_format_date('eeee, MMMM d', 'fr', 'Europe/Paris') }}
```

When `langcode` is omitted the current interface language selects the ICU locale;
`intl_format_date_pattern` throws `\IntlException` if the given format id does not exist.
See `api/service.md` for the underlying `IntlDate::format()` / `formatPattern()` methods and
the alter hooks that adjust the locale map or the produced string.
