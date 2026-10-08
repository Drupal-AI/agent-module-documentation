<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theming: the `file_pdf` theme hook

`pdf.module` contains exactly one function — `pdf_theme()` — registering a single hook:

```php
'file_pdf' => ['variables' => ['attributes' => NULL]]
```

Template `templates/file-pdf.html.twig` is one line:

```twig
<iframe {{ attributes }}></iframe>
```

Only `pdf_default` uses it. `pdf_thumbnail` and `pdf_pages` emit raw `html_tag` render
elements (`<canvas>` / `<div>`), so they have **no** template to override — style them with
CSS or alter the render array in a `hook_preprocess`/`hook_ENTITY_TYPE_view_alter`.

## Overriding

Copy `file-pdf.html.twig` into your theme's `templates/` directory and add a wrapper,
download link, or `<noscript>` fallback around the iframe. `attributes` arrives as a plain
array from the formatter (class `pdf`, `src`, `data-src`, `width`, `height`, `title`,
`frameborder`, `allowfullscreen` / `webkitallowfullscreen` / `mozallowfullscreen`), so
`{{ attributes }}` prints them all; use `{{ attributes.src }}` etc. to cherry-pick.

There are no theme suggestions (no `file_pdf__<bundle>` variants) — add them yourself with
`hook_theme_suggestions_file_pdf_alter()` if you need per-bundle markup.

## CSS and JS hooks

`css/pdf.css` (in library `pdf/drupal.pdf`) styles `.pdf-canvas` (1px black border),
`#pdf-page`, and the pdf.js `.textLayer` selection classes.

Client-side class contract used by `js/pdf.js`:

| Selector | Set by | JS behaviour |
|---|---|---|
| `.pdf-thumbnail` (a `<canvas>`) | `pdf_thumbnail` | renders page 1 at the element's `scale` attribute |
| `.pdf-pages` (a `<div>`) | `pdf_pages` | appends one `<canvas class="pdf-canvas">` per page |
| `iframe.pdf` | `pdf_default` | `js/default.js` swaps `src` ← `data-src` when Acrobat is detected |

Both canvas formatters read the file URL from a non-standard `file` attribute and the scale
from a `scale` attribute on the element, and require
`drupalSettings.pdf.workerSrc` (set to `/libraries/pdf.js/build/pdf.worker.js` by the
formatters) before `pdfjsLib` can load a document.
