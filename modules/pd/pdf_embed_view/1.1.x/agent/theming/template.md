<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theme hook & template

The module defines one theme hook (`pdf_embed_view_theme()` in `pdf_embed_view.module`):

```
pdf_embed_view:
  variables:
    file_url: null        # absolute URL of the PDF
    modal_id: null        # unique modal DOM id
    display_mode: inline  # inline | modal | new_tab
  template: pdf-embed-view   # templates/pdf-embed-view.html.twig
```

All three display plugins render `#theme => 'pdf_embed_view'` with these three variables.

## Template (`templates/pdf-embed-view.html.twig`)

Wrapper `<div>` gets classes `pdf-embed-view` and `pdf-embed-view--{display_mode}`, then one
branch by mode:

- **inline** — `<iframe class="pdf-embed-iframe" src="{file_url}" loading="lazy">`.
- **modal** — an `<a class="pdf-embed-modal-trigger" data-pdf-open="{modal_id}">View PDF</a>`
  plus a hidden `<div id="{modal_id}" data-pdf-modal>` containing the iframe.
- **new_tab** — `<a class="pdf-embed-newtab-link" target="_blank" rel="noopener noreferrer">`.

`file_url` is printed only into `href`/`src` attributes with default Twig autoescaping (no
`|raw`), so it is escaped.

Override by copying the template into your theme, or add a suggestion via
`hook_theme_suggestions_pdf_embed_view()`.

## Attached assets — library `pdf_embed_view/viewer`

`pdf_embed_view.libraries.yml`: `js/pdf_embed_view.js` + `css/pdf_embed_view.css`, depending on
`core/drupal`, `core/once`, `core/drupal.dialog`, `core/jquery.ui.dialog`, `core/drupalSettings`.
The JS `Drupal.behaviors.pdfEmbedView` opens a `Drupal.dialog` (title "PDF Viewer",
90% width/height, modal, resizable, draggable) when a `[data-pdf-open]` trigger is clicked.
CSS forces `.pdf-embed-modal.ui-dialog` to 90vw/90vh and `iframe.pdf-embed-iframe` to
`height:500px; width:100%`, with a mobile (`max-width:768px`) full-screen dialog treatment.
No external libraries (no pdf.js — uses the browser's native PDF rendering).
