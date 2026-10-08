<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Twig filter & helper classes

## `|typogrify` Twig filter

Registered by the `typogrify.twig_extension` service
(`Drupal\typogrify\TwigExtension\Typogrify`, tagged `twig.extension`). Marked
`is_safe: ['html']`, `pre_escape: 'html'`.

```twig
{{ text|typogrify }}                         {# all default refinements #}
{{ title|typogrify(['widont']) }}            {# only widow prevention #}
{{ text|typogrify(['smartypants','amp']) }}  {# only these #}
```

With **no** options it calls `Typogrify::filter($text)` (the full default pipeline). With an
options array it applies only the named steps, in this order:

| Option | Method |
|---|---|
| `amp` | `Typogrify::amp()` — wrap ampersands |
| `widont` | `Typogrify::widont()` — prevent widows |
| `smartypants` | `SmartyPants::process()` — smart quotes/dashes |
| `caps` | `Typogrify::caps()` — wrap capital runs |
| `initial_quotes` | `Typogrify::initialQuotes()` — wrap leading quotes |
| `dash` | `Typogrify::dash()` — dash handling |

Unlike the text-format filter, the Twig filter uses code defaults (it does not read a text
format's stored settings).

## Static helper classes (for custom PHP)

- `Drupal\typogrify\Typogrify` — `filter()`, `amp()`, `widont()`, `caps()`,
  `initialQuotes()`, `dash()`.
- `Drupal\typogrify\SmartyPants` — `process($text, $hyphens = 1, $ctx = [])`,
  `smartAmpersand()`, `smartAbbreviation()`, `smartNumbers()`, `spaceToNbsp()`,
  `spaceHyphens()`, `hyphenate()`; constant `SMARTYPANTS_PHP_VERSION`.
- `Drupal\typogrify\UnicodeConversion` — `map($type)` for `ligature`/`arrow`/`fraction`/`quotes`
  maps and `convertCharacters($text, $chars)`.

```php
use Drupal\typogrify\Typogrify;
$pretty = Typogrify::filter($text);            // full pipeline
$noWidow = Typogrify::widont($heading);        // one refinement
```

## Filter plugin internals (for reference)

`Drupal\typogrify\Plugin\Filter\TypogrifyFilter` (`@Filter(id="typogrify")`,
`TYPE_TRANSFORM_IRREVERSIBLE`, weight 10). `process()` reads the (unserialized) settings and
runs the enabled refinements, then attaches the `typogrify/typogrify` library.
`settingsForm()` builds the per-format options; `setConfiguration()`/`settingsSerialize()`
serialize the `ligatures`/`arrows`/`fractions`/`quotes` array settings for storage.
`typogrify_migration_plugins_alter()` maps the D6 `typogrify` filter id on migration.
