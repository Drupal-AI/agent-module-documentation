<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `tl` Twig filter

The module's entire surface is one Twig filter. Source: `src/TwigExtension/TransliterateFilter.php`,
service in `transliterate_twig.services.yml`.

## Install / enable

`drush en transliterate_twig` (or via the UI). Nothing to configure — README's Configuration
section is literally "Nothing to configure." Once enabled, the `tl` filter is available in every
Twig template site-wide.

## Registration

`transliterate_twig.services.yml`:

```yaml
services:
  transliterate_twig.twig_extension:
    class: Drupal\transliterate_twig\TwigExtension\TransliterateFilter
    tags:
      - { name: twig.extension }
```

The `twig.extension` tag is what makes core discover the class and merge its filters into the Twig
environment.

## The class

`Drupal\transliterate_twig\TwigExtension\TransliterateFilter extends
Twig\Extension\AbstractExtension`:

- `getFilters()` → `[ new TwigFilter('tl', [$this, 'transliterateString']) ]`. Exactly one filter,
  named **`tl`**. No `is_safe` option and no `needs_context`/`needs_environment` — so Twig treats
  the return value as an ordinary string and applies its normal autoescaping to it.
- `getName()` → `'transliterate_twig.twig_extension'`.
- `public static function transliterateString($string)` →
  `(new PhpTransliteration())->transliterate($string)`, where `PhpTransliteration` is
  `\Drupal\Component\Transliteration\PhpTransliteration`. This is core's pure-PHP transliteration
  (the reason the module advertises "without PECL"): it maps accented/non-ASCII code points to their
  closest ASCII equivalents using core's transliteration data tables.

Because `transliterateString` is `static`, it can also be called directly from PHP:
`\Drupal\transliterate_twig\TwigExtension\TransliterateFilter::transliterateString('résidence')`.

## Behavior

- `PhpTransliteration::transliterate()` signature is `transliterate($string, $langcode = 'en',
  $unknown_character = '?', $max_length = NULL)`. The filter passes only the string, so it uses the
  defaults (langcode `en`, unknown character `?`). Characters with no mapping become `?`.
- Output is a plain string; the exact result depends on core's transliteration tables and can change
  between core versions.

## Usage examples

```twig
{{ 'résidence' | tl }}        {# residence #}
{{ node.label | tl }}
{{ term.name | tl | lower }}  {# chain with core filters #}
```

Typical uses: building ASCII slugs, anchors, `id`s, or filenames from accented / non-Latin text
directly in a template, without a preprocess function or the intl extension.
