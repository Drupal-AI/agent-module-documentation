<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Modal route, controller, library & hooks

Backs the formatter's *Modal window* view type. Source: `document_preview.routing.yml`,
`src/Controller/DocumentPreviewModalController.php`, `document_preview.libraries.yml`,
`src/Hook/DocumentPreviewHooks.php`.

## Route (`document_preview.routing.yml`)

```
document_preview.modal:
  path: '/document_preview'
  defaults:
    _controller: '\Drupal\document_preview\Controller\DocumentPreviewModalController::modal'
    _title: 'Controller for output document in modal window'
  requirements:
    _access: 'TRUE'
  methods: [GET, POST]
  options:
    parameters:
      url: { type: string }
```

- Path **`/document_preview`**; controller **`DocumentPreviewModalController::modal`**.
- Access **`_access: 'TRUE'`** (no permission gate). Accepts GET and POST.
- The document to show is taken from the request **`url` query parameter** (not a file id / entity id
  — the caller supplies the URL). The *Modal window* template builds this link from the file's own
  public URL.

## Controller (`DocumentPreviewModalController::modal`)

- `create()` stores `request_stack`'s current request in `$this->currentRequest`.
- `modal()` reads `$this->currentRequest->query->get('url')`, wraps it in `Url::fromUri()`, and builds
  a render array: an `<iframe>` whose `src` is
  `sprintf('%s?url=%s&embedded=true', self::VIEWER_DOMAIN, $url->toString())` where
  `VIEWER_DOMAIN = 'https://docs.google.com/gview'`, plus a `#type => 'link'` **Download** link to the
  same URL.
- Returns an **`AjaxResponse`** carrying an `OpenModalDialogCommand($title, $content, $dialog_options)`
  with title *"Document Preview"* and dialog options `width: 900, height: 600, resizable: true,
  dialogClass: 'document-preview-modal'`.
- Because the response is an `AjaxResponse` (JSON), the endpoint is meant to be invoked through
  Drupal's AJAX dialog framework (the `use-ajax` link the formatter emits), not by direct navigation.

## Library (`document_preview.libraries.yml`)

- `document_preview/document-preview`: CSS `css/document_preview.css` (theme), dependencies
  `core/jquery` and `core/drupal.dialog.ajax`. Attached by the formatter and by `hook_preprocess_node`.

## Hooks (`src/Hook/DocumentPreviewHooks.php`, attribute-based)

- `#[Hook('preprocess_node')]` `preprocessNode()` — attaches the `document_preview/document-preview`
  library to **every node** render.
- `#[Hook('theme')]` `theme()` — declares the **`document_preview_field`** theme hook with variables
  `url, filename, delta, entity, bundle, field_name, field_type, view_type`.
- `#[Hook('theme_suggestions_document_preview')]` `themeSuggestionsDocumentPreview()` — builds the
  entity/bundle/delta/field-name/field-type template suggestions listed in
  [../fields/formatter.md](../fields/formatter.md).
