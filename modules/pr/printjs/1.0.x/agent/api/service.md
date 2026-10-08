# The `print.js` service, render pipeline & libraries (API)

## Service `print.js` — `Drupal\printjs\Printjs`

Defined in `printjs.services.yml`; args `@config.factory`, `@string_translation`. One public method:

```php
public function getBtnPrintjs($printText = "Print", $config = [])
```

- If `$config` is empty it loads the global `printjs.settings` object; if `$config` is a config
  object it uses `getRawData()`, if it's an array it uses it as-is.
- Returns a render array (`src/Printjs.php`):

```php
[
  '#theme' => 'printjs',
  '#printText' => $this->t('@printtext', ['@printtext' => $printText]),
  '#attributes' => [
    'class' => ['btn-print', 'btn', 'btn-success'],
    'data-type' => 'html',
    'data-printable' => $configuration['printjs_id'] ?? 'print',
    'data-autoprint' => $configuration['auto_print'] ?? FALSE,
  ],
  '#attached' => [
    'library' => [ $local ? 'printjs/printjs.local' : 'printjs/printjs' ],
    'drupalSettings' => ['printjs' => $configuration],
  ],
]
```

Call it from any code (`\Drupal::service('print.js')->getBtnPrintjs('Print', $config)`) to embed a
print button in a controller, block, preprocess, or Twig-ready render array. The Block and the
Views-area handler are both just callers of this method.

## Theme hook `printjs`

`hook_theme()` registers `printjs` with variables `printText` (default `NULL`) and `attributes`
(default `[]`), template `templates/printjs.html.twig`:

```twig
<button {{ attributes }}>
  <i class="bi bi-printer"></i> {{ printText }}
</button>
```

`{{ attributes }}` is a Drupal `Attribute` object (auto-escaped). The Bootstrap-Icons `bi bi-printer`
glyph requires a theme that ships that icon font; it is not provided by the module.
`hook_preprocess_printjs()` (mentioned in help/README) is the intended place to alter `printText` or
`attributes` — e.g. switch `data-type` to `pdf`/`image`/`json` to use Print.js's other modes.

## Wrapper JS — `js/printjs.js`

A `Drupal.behaviors.printjs` bound with `once`. On the trigger selector
(`.btn-print` plus any `drupalSettings.printjs.btn_selector_print`) it:
1. Reads the button's `data()` (type, printable, autoprint) as the Print.js config.
2. Collects every `head link[rel=stylesheet]` `href` into `config.css` (so the print output keeps
   the page's CSS — Print.js otherwise prints unstyled).
3. Resolves `printjs_id`: for a `.class`/`#id`/text selector it (re)assigns ids `print` /
   `wrapper-print`; if `#print` is absent it falls back to tagging `main`, else `body`.
4. If `print_parent_selector` is set, prints `#wrapper-print` (the parent).
5. Calls `printJS(config)` (or `window.print()` if no printable resolved). `data-autoprint=1` clicks
   the button automatically on load.

## Libraries — Print.js is NOT bundled

`printjs.libraries.yml` declares two variants, both depending on `core/drupal`, `core/jquery`,
`core/once`:

- **`printjs/printjs`** (default): `//printjs-4de6.kxcdn.com/print.min.js` and `print.min.css` as
  `type: external` from a third-party CDN, plus the module's `js/printjs.js` and `css/printjs.css`.
- **`printjs/printjs.local`**: `/libraries/Print.js/print.min.js` and `print.min.css` from the site's
  web root — you must download Print.js (https://github.com/crabbly/Print.js/releases) into
  `libraries/Print.js/`. Selected when the `local` config/checkbox is true.

`css/printjs.css` is a print-only `@media print` stylesheet (hides `.btn-print`, forces black text,
avoids page-breaks inside rows/images, sets `@page` margins).
