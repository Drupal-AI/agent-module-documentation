<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Markup, theme hook and library

## Theme hook

`zurb_twentytwenty_theme()` registers one hook:

```php
'zurb_twentytwenty' => [
  'variables' => ['images' => NULL],
  'template'  => 'zurb-twentytwenty',
]
```

`templates/zurb-twentytwenty.html.twig` is three lines:

```twig
<div class="twentytwenty-container">
  {{ images }}
</div>
```

`images` is **pre-rendered markup**, not a render array: `viewElements()` builds one
`#theme: image_formatter` element per file and calls
`\Drupal::service('renderer')->render($images)` before assigning it. Overriding the template can
therefore only wrap or reorder the blob — to change the individual `<img>` markup, override
`image-formatter.html.twig` (or the image style) instead.

Override in a theme:

```
mytheme/templates/zurb-twentytwenty.html.twig
```

Add wrapper classes there if the front end needs them; keep `twentytwenty-container` — the JS
binds to exactly that selector.

## Library

`zurb_twentytwenty.libraries.yml` → library `zurb_twentytwenty/twentytwenty`:

| Asset | Path |
|---|---|
| CSS (theme) | `/libraries/twentytwenty/css/twentytwenty.css` |
| JS | `/libraries/twentytwenty/js/jquery.event.move.js` |
| JS | `/libraries/twentytwenty/js/jquery.twentytwenty.js` |
| JS | `js/drupal.twentytwenty.js` (this module) |

Dependencies: `core/jquery`, `core/drupal`, `core/once`, `core/drupalSettings`.
The library is attached in `template_preprocess_zurb_twentytwenty()`, so it loads whenever the
theme hook renders — including inside Views, blocks or Layout Builder.

To swap in a CDN copy or a differently-located library, override the library in your theme:

```yaml
# mytheme.info.yml
libraries-override:
  zurb_twentytwenty/twentytwenty:
    css:
      theme:
        /libraries/twentytwenty/css/twentytwenty.css: /libraries/vendor/tt/twentytwenty.min.css
```

## Behavior and the drupalSettings caveat

`js/drupal.twentytwenty.js`:

```js
$(once('init', '.twentytwenty-container', context)).twentytwenty({
  default_offset_pct: drupalSettings.twentytwenty.default_offset_pct,
  before_label:       drupalSettings.twentytwenty.before_label,
  …
});
$(window).on('load', function () { $(window).trigger('resize.twentytwenty'); });
```

Two consequences worth knowing before you debug something odd:

1. **Settings are global, not per element.** `viewElements()` writes them to
   `drupalSettings.twentytwenty.*` (and, redundantly, also on `$elements['#attached']` before the
   loop). Every container on the page is initialised from that one object, so with two
   TwentyTwenty fields on a page the labels/offset of whichever was attached last win. If you need
   per-instance options, render each field on its own page/AJAX view, or override
   `drupal.twentytwenty.js` to read `data-` attributes you add via a template override.
2. `orientation` is passed through the formatter settings but **is not forwarded to the plugin**
   in `drupal.twentytwenty.js` — the options object omits it. Setting it to `vertical` has no
   effect unless you patch the JS (or set the plugin's default yourself).

Cache metadata: the formatter merges the image style's cache tags and each file's cache tags into
the rendered items, so image-style flushes and file updates invalidate correctly.
