<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Twig filters

All are plain `TwigFilter`s registered by tagged services; use them in any `.html.twig`.

## `shuffle` — `ArrayExtension`
`{{ items|shuffle }}` → randomizes an array. Accepts `\Traversable` (converted via
`iterator_to_array`). Uses PHP `shuffle()`; returns the reordered array. Not cryptographically
random; order changes every render.

## `time_diff` — `DateExtension`
`{{ node.created.value|time_diff }}` → a `TranslatableMarkup` like `3 minutes ago` /
`in 2 days`. Signature `time_diff(?int $timestamp)`. Compares against
`datetime.time`->getCurrentTime(); picks second/minute/hour/day/week/month/year buckets, past or
future, and pluralizes via `formatPlural` (translatable). `0` diff → `now`.

## `localizeddate` — `IntlExtension` (needs Twig environment)
`{{ date|localizeddate('medium', 'short', 'fr', timezone, format, 'gregorian') }}`
Signature `localizeddate(env, date, dateFormat='medium', timeFormat='medium', locale=NULL,
timezone=NULL, format=NULL, calendar='gregorian')`. `dateFormat`/`timeFormat` are one of
`none|short|medium|long|full`. Wraps `\IntlDateFormatter`. Converts `$date` via the Twig core
`convertDate` (or legacy `twig_date_converter` if present). Requires PHP `intl`
(`RuntimeException` if `\IntlDateFormatter` is missing).

## `localizednumber` — `IntlExtension`
`{{ 1234.5|localizednumber('decimal', 'default', 'de') }}`
Signature `localizednumber(number, style='decimal', type='default', locale=NULL)`.
Styles: `decimal|currency|percent|scientific|spellout|ordinal|duration`.
Types: `default|int32|int64|double|currency`. Wraps `\NumberFormatter`. Unknown style/type →
Twig `SyntaxError`. Formatter is statically cached per locale+style.

## `localizedcurrency` — `IntlExtension`
`{{ 19.99|localizedcurrency('EUR', 'fr') }}`
Signature `localizedcurrency(number, currency=NULL, locale=NULL)`. Uses
`\NumberFormatter::formatCurrency`. Requires PHP `intl`.

## `truncate` — `TextExtension` (needs Twig environment)
`{{ text|truncate(80, true, '…') }}`
Signature `truncate(env, ?string value, length=30, preserve=false, separator='...')`.
Returns `''` for non-strings. If longer than `length`, cuts to `length` (or, with `preserve`,
to the next space after `length`) and appends `separator`; charset from `env->getCharset()`.

## `wordwrap` — `TextExtension` (needs Twig environment)
`{{ text|wordwrap(80, "\n") }}`
Signature `wordwrap(env, ?string value, length=80, separator="\n", preserve=false)`.
Splits on `separator`, hard-breaks pieces longer than `length` (unless `preserve`), rejoins with
`separator`; charset-aware via `mb_*`. Returns `''` for non-strings.

Output note: none of these mark their result as safe markup, so autoescaping is unaffected — they
carry no XSS or code-evaluation surface of their own.
