<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Document OCR Mindee (document_ocr_mindee) — agent index

An OCR **provider plugin** for the Document OCR framework. It registers one processor,
`mindee`, that uploads a document to the **Mindee** parsing SaaS (`api.mindee.net`) and maps
the returned prediction fields back into a Document OCR mapping. Package **AI**. Depends only
on **`document_ocr`** (`drupal/document_ocr:^1.0`). Core `^9.5 || ^10 || ^11`. License
GPL-2.0-or-later. Installed version 1.0.5.

- **The `mindee` processor plugin, the HTTP client, credentials, endpoints and field mapping** →
  [plugins/mindee-processor.md](plugins/mindee-processor.md)

## What it actually is

- One processor plugin: `Mindee` (id **`mindee`**, label *"Mindee"*) in
  `src/Plugin/document_ocr/processor/Mindee.php`, extending `document_ocr`'s `ProcessorBase`.
  Annotation `@DocumentOcrProcessor`: `extensions = "pdf heic tiff tif jpg jpeg png webp"`,
  `requires = {"credentials", "template"}`, `supports = {"store_json"}`.
- One HTTP client service: **`document_ocr_mindee.client`** →
  `Drupal\document_ocr_mindee\Mindee` (`src/Mindee.php`), args `@file_system`, `@http_client`.
- One repository service: **`document_ocr_mindee.apis_repository`** →
  `Drupal\document_ocr_mindee\Repository\ApisRepository` (extends `document_ocr`'s
  `JsonRepositoryBase`), which loads the bundled **`repository/apis.json`** product catalog.
- **No** routes, permissions, entities, config objects/schema, hooks, or Drush. All admin/setup
  happens through the **Document OCR** UI at `/admin/config/structure/document-ocr`.

## Mechanism (from source)

- `configurationForm()` builds two selects — **API** (product) and **Version** — from
  `client->getApis()` (i.e. `apis.json`); the version select is AJAX-refreshed from the API.
- `getMappingData()` chains `client->setCredentials(getCredentials())->setEndpoint($configuration)
  ->processDocument(getFile())`, then iterates
  `document['document']['inference']['prediction']`, calling `setOption()`/`setOptionValue()`
  per field and building a combined `extracted_text`; `setDocument()` stores the raw payload.
- `Mindee::setEndpoint()` composes the fixed URL
  `https://api.mindee.net/v1/products/mindee/{api}/{version}/predict` (api/version come from the
  bounded catalog, not from a request).
- `Mindee::processDocument()` reads the local managed file, base64-encodes it, and POSTs it in
  `form_params[document]` with header `Authorization: Token {apikey}` over HTTPS (Guzzle default
  TLS verification). Exceptions are logged to the `document_ocr_mindee` channel.

## Credentials

- The API key is **not** stored in Drupal config. `getCredentials()` (inherited from
  `document_ocr`'s `ProcessorBase`) `json_decode`s a JSON file whose path is set on the processor;
  the key is read from its `apikey` element. README/config convention:
  `private://document-ocr/mindee-credentials.json` containing `{"apikey": "[API-KEY]"}`.
