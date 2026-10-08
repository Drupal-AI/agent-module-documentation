<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Transliterate Twig (transliterate_twig) — agent index

Registers **one Twig filter, `tl`**, that transliterates a string (accented / non-ASCII → closest
ASCII) inside templates, without the PECL/intl extension. Package `Twig`. Version dir **2.x**
(installed 2.0.2). Core requirement `^10 || ^11`. License GPL-2.0-or-later.

- **The filter, the service registration, and how to use it** → [api/filter.md](api/filter.md)

## What it actually is (from source)

- One class: `TransliterateFilter` (`src/TwigExtension/TransliterateFilter.php`), extending
  `Twig\Extension\AbstractExtension`. `getName()` returns `transliterate_twig.twig_extension`.
- `getFilters()` returns a single `new TwigFilter('tl', [$this, 'transliterateString'])`. The
  static `transliterateString($string)` returns
  `(new \Drupal\Component\Transliteration\PhpTransliteration())->transliterate($string)` — i.e. it
  just delegates to core's pure-PHP transliteration.
- Registered as a `twig.extension`-tagged service `transliterate_twig.twig_extension` in
  `transliterate_twig.services.yml`.

## What it does NOT provide

- No config, no config schema, no settings form/route, no permissions, no Drush commands, no hooks,
  no `.module`/`.install` file, no submodules, no libraries, no plugin types, no dependencies beyond
  Drupal core. `composer.json` is not shipped in the package.
- No Twig *function* — only the `tl` filter.

## Usage

`{{ 'résidence' | tl }}` → `residence`. Chainable: `{{ title | tl | lower }}`.
