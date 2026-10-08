<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Helper service, tokens and Twig filters

## `Drupal\edtf\Helper` (static wrapper around the library)

`src/Helper.php`. Central access point to `professional-wiki/edtf`; caches instances statically.

- `Helper::getParser(): EdtfParser` — lazily builds `EdtfFactory::newParser()`.
- `Helper::getHumanizer($langcode = null): Humanizer` — builds
  `EdtfFactory::newHumanizerForLanguage($langcode)`, defaulting to the current UI language
  (`languageManager()->getCurrentLanguage()->getId()`); cached per langcode.
- `Helper::fromUnixTime(int $unixtime): ExtDateTime` — parses `date('Y-m-d\TH:i:s', $unixtime)` and
  returns the library value (used to derive a year from a min/max bound).
- `Helper::getYearPeriod($edtfValue): string|null` — takes the min and max year of the value,
  left-pads to equal length, and returns the shared leading digits with `X` for the differing
  rightmost digits (e.g. min 1900 / max 1999 → `19XX`).

The parser's `parse()` returns a result with `isValid()` and `getEdtfValue()`; the value exposes
`getMin()` / `getMax()` (UNIX timestamps) and `getYear()`.

## Tokens — `edtf.tokens.inc`

`edtf_token_info()` iterates content-entity types (requires the `token.entity_mapper` service; it
returns early if absent) and, for every field whose storage type is `edtf`, registers three tokens
under `[<token-type>-<field_name>:…]`:

- `humanized` — humanized representation of the value.
- `year` — the (minimum) year.
- `year_period` — the year with `X` for unspecified rightmost digits (e.g. `19XX`).

`edtf_tokens()` resolves each: it reads the first field item, parses `element['value']`, then
returns `getYear()` (year), `Helper::getYearPeriod()` (year_period), or
`Helper::getHumanizer()->humanize()` (humanized). It supports an optional numeric delta prefix in
the token (e.g. `0:humanized`). `edtf_install()` sets the module weight to 1 so these tokens are
not overwritten by the contrib `tokens` module.

Example: `[node:field_when:humanized]`, `[node:field_when:year]`, `[node:field_when:year_period]`.

## Twig filters — `TwigEDTFExtension`

Registered as service `edtf.twig_extension` (`edtf.services.yml`, arg `@renderer`), class
`src/TwigEDTFExtension.php` extending `AbstractExtension`. Each filter parses the string via
`Helper::getParser()`; the value-returning filters return `null` when the input is invalid.

| Filter | Returns |
|---|---|
| `value\|edtf_validate` | `bool` — `isValid()` of the parse |
| `value\|edtf_humanize` | `string\|null` — humanized in the current language |
| `value\|edtf_year` | `int\|null` — the (minimum) year |
| `value\|edtf_year_period` | `string\|null` — year with `X` for unspecified digits |
| `value\|edtf_min` | `int\|null` — earliest UNIX timestamp (`getMin()`) |
| `value\|edtf_max` | `int\|null` — latest UNIX timestamp (`getMax()`) |

Usage in a template:

```twig
{% if content.field_when.0.value|edtf_validate %}
  {{ content.field_when.0.value|edtf_humanize }}
  ({{ content.field_when.0.value|edtf_year_period }})
{% endif %}
```

The `edtf_min` / `edtf_max` timestamps are handy for sorting or building timelines from otherwise
imprecise values.
