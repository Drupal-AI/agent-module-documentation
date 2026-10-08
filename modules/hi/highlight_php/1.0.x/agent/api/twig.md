# API — Twig `|highlight` filter & `highlight_php_highlight()`

## Twig filter `|highlight`
Registered by `Drupal\highlight_php\TwigExtension` (service `highlight_php.twig_extension`,
`twig.extension` priority 1). Marked `is_safe: ['html']`.

```twig
{{ my_code_string|highlight }}
```
Behavior (`TwigExtension::highlight($string)`):
- Runs `highlight_php_highlight($string)` (same engine as the filter; honors
  `highlight_php.settings` mode/languages/regex — so the string should contain `<code>` markup for
  auto/manual detection to apply).
- Attaches the `highlight_php/main` CSS library.
- Returns `Xss::filterAdmin($highlighted)` (or `Xss::filterAdmin($string)` when nothing highlighted).

Use it to highlight code assembled in a template or preprocess without going through a text format.

## Procedural helper `highlight_php_highlight($html): string|false`
Defined in `highlight_php.module`. Give it an HTML string containing one or more `<code>` elements;
returns the HTML with each `<code>` block replaced by highlighted, `hljs`-classed span markup, or
`FALSE` if nothing was highlighted. Reads config `highlight_php.settings` for `mode` /
`auto_languages` / `manual_regex`. Call from PHP when you need highlighted markup outside the filter
pipeline; remember to attach the `highlight_php/main` library yourself (the Twig filter and the
`filter_highlight_php` plugin do this for you).

## Not provided
- No services beyond the Twig extension, no plugin manager, no hooks/`*.api.php`, no Drush,
  no own permissions. Highlighting output is always escaped span markup — the module never `eval`s
  or executes the code it highlights.
