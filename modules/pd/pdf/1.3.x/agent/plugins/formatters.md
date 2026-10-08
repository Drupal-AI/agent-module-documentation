<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The three PDF FieldFormatter plugins

The module defines **no plugin types of its own** — it ships three implementations of core's
`FieldFormatter` plugin type. All three declare `field_types = {"file"}`, so they appear on
*Manage display* for any core File field (including a Media entity's `field_media_file`).

| Plugin id | Label | Class | Output |
|---|---|---|---|
| `pdf_default` | PDF: Default viewer of PDF.js | `Drupal\pdf\Plugin\Field\FieldFormatter\PdfDefault` | `<iframe>` around pdf.js `viewer.html` |
| `pdf_thumbnail` | PDF: Display the first page | `…\PdfThumbnail` | one `<canvas class="pdf-thumbnail pdf-canvas">` |
| `pdf_pages` | PDF: Continuous scroll (experimental) | `…\PdfPages` | `<div class="pdf-pages">` filled with one canvas per page by JS |

**Per-item MIME gate (all three):** each delta is rendered only when
`$item->entity->getMimeType() == 'application/pdf'`; any other file falls back to
`['#theme' => 'file_link', '#file' => $item->entity]`. A field holding a DOCX therefore still
renders a normal file link.

## `pdf_default`

`defaultSettings()`:

```php
'keep_pdfjs'  => TRUE,   // "Always use pdf.js" checkbox
'width'       => '100%', // iframe width, e.g. 250px or 100%
'height'      => '',     // iframe height
'page'        => NULL,   // initial page number   (number)
'zoom'        => NULL,   // '' | auto | page-actual | page-fit | page-width | custom
'custom_zoom' => NULL,   // percent, min 5; only used when zoom === 'custom'
'pagemode'    => NULL,   // '' | thumbs | bookmarks
```

`page`, `zoom`, `custom_zoom` and `pagemode` are `#states`-hidden unless `keep_pdfjs` is
checked, and they only take effect when `keep_pdfjs` is TRUE.

`viewElements()` builds the iframe src:

```
$viewer = \Drupal::config('pdf.settings')->get('custom_viewer')
        ?: base_path() . 'libraries/pdf.js/web/viewer.html';
$src = <absolute $viewer> . '?file=' . rawurlencode(<absolute file url>);
// then, only when keep_pdfjs:
$src .= '#' . UrlHelper::buildQuery(array_filter([page, zoom, custom_zoom, pagemode]));
```

`custom_zoom` is folded into `zoom` (`zoom=custom` → `zoom=<custom_zoom>`) and then unset, so
the hash never contains `custom_zoom`. `array_filter()` drops empty values — a `page` of `0`
or an empty `zoom` never reaches the URL.

The render array is `#theme => 'file_pdf'` with `#attributes` carrying
`class: ['pdf']`, `src`, `data-src` (the raw file URL), `width`, `height`,
`title` (the file label), `frameborder: no` and the three `allowfullscreen` variants.

When `keep_pdfjs` is **not** TRUE the element also attaches the `pdf/default` library
(`js/acrobat_detection.js` + `js/default.js`), which swaps `src` for `data-src` when a native
Acrobat/WebKit PDF plugin is detected, and replaces the iframe with a "upgrade your browser"
paragraph when `<canvas>` is unsupported.

## `pdf_thumbnail`

`defaultSettings()`: `'scale' => 1, 'width' => '', 'height' => ''`.

Renders `#type => html_tag`, `#tag => 'canvas'` with attributes
`class: ['pdf-thumbnail','pdf-canvas']`, `id: pdf-thumbnail-<delta>`, `file: <absolute url>`,
`scale`, and an inline `style="width:<width>;height:<height>;"`. Attaches the
`pdf/drupal.pdf` library and `drupalSettings.pdf.workerSrc` =
`<base>/libraries/pdf.js/build/pdf.worker.js`. `js/pdf.js` then loads the document and renders
**page 1 only** at `scale` into the canvas.

## `pdf_pages`

`defaultSettings()`: `'scale' => 1`.

Renders `#type => html_tag`, `#tag => 'div'` with `class: ['pdf-pages']`,
`id: pdf-pages-<delta>`, `file`, `scale`. Same library + `workerSrc` attachment. `js/pdf.js`
iterates `1..pdf.numPages` and appends one `<canvas class="pdf-canvas">` per page. The plugin
description warns: *"Don't use this to display big PDF file."* — every page is rasterised in
the browser.

Note: `pdf_pages::settingsForm()` builds `$elements` from scratch (it does not call
`parent::settingsForm()`), so the standard formatter form wrapper elements are absent — only
the Scale textfield is shown.

## Setting a formatter programmatically

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.default');
$vd->setComponent('field_pdf_doc', [
  'type' => 'pdf_default',
  'region' => 'content',
  'label' => 'hidden',
  'settings' => ['keep_pdfjs' => TRUE, 'width' => '100%', 'height' => '800px', 'page' => 3, 'zoom' => 'page-width'],
])->save();
```

Read it back with
`drush config:get core.entity_view_display.node.article.default content.field_pdf_doc`.
