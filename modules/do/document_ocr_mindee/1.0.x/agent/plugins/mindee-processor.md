<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `mindee` processor plugin

This module contributes a single Document OCR **processor** plugin plus two support services.
It has no UI of its own — you configure a Mindee processor inside the Document OCR framework at
`/admin/config/structure/document-ocr`.

## Install / enable

`composer require drupal/document_ocr_mindee` then enable `document_ocr_mindee` (pulls in
`document_ocr`). No config to import; there is no settings form and no `config/` directory.

## The processor plugin

`src/Plugin/document_ocr/processor/Mindee.php` — class `Mindee extends ProcessorBase`
(base class from `document_ocr`). Annotation `@DocumentOcrProcessor`:

- `id = "mindee"`, `name = @Translation("Mindee")`
- `extensions = "pdf heic tiff tif jpg jpeg png webp"` — accepted upload types
- `requires = {"credentials", "template"}` — the framework requires a credentials file and a
  template/mapping before the processor runs
- `supports = {"store_json"}` — the raw Mindee response can be persisted (see `setDocument()`)

`requirementsAreMet()` returns `TRUE` (no PHP-extension/library preflight). It is constructed
with `tempstore.private`, `file_system`, `logger.factory` (channel `document_ocr_mindee`), and
the `document_ocr_mindee.client` service.

### Configuration form (per processor)

`configurationForm()` renders two selects:

- **API** (`api`) — options come from `client->getApis()` (the `apis.json` catalog, keyed by
  product id, labelled by each entry's `name`). Once chosen it is `#disabled` (immutable after
  first save) and drives an AJAX callback `ajaxApiVersionForm()`.
- **Version** (`version`) — the `versions` list for the selected product.

`configurationValues()` persists `{api, version}`. Because `api` is locked after the first save,
re-editing keeps the stored `api` and only re-reads `version`.

### Extraction (`getMappingData()`)

Runs the client chain and then, for each entry in
`$document['document']['inference']['prediction']`:

- `setOption($prediction, $prediction)` and `setOptionValue($prediction, $value)` (value =
  `$params['value']` or empty) — exposing each Mindee field as a mappable option.
- Non-empty fields are also collected into a combined **`extracted_text`** option
  (`"{field}: {value}"` joined by CRLF), labelled *"Extracted Text"*.
- `setDocument($document['document'])` stores the raw payload (honoring `store_json`).

Any exception is caught and logged; the method returns `FALSE` on failure.

## The HTTP client service

`document_ocr_mindee.client` → `Drupal\document_ocr_mindee\Mindee` (`src/Mindee.php`),
constructed with `@file_system` and `@http_client` (Guzzle). Key methods:

- `setCredentials($credentials)` — stores the decoded credentials array (`apikey`).
- `setEndpoint($configuration)` — builds
  `https://api.mindee.net/v1/products/mindee/{api}/{version}/predict`.
- `processDocument($file)` — resolves the file's real path, reads its bytes, and
  `httpClient->post($endpoint, [...])` with:
  - header `Authorization: 'Token ' . $credentials['apikey']`, `Accept: application/json`
  - `form_params['document'] = base64_encode($contents)`

  It returns `json_decode($response->getBody(), TRUE)`. The endpoint is HTTPS and Guzzle's
  default TLS verification applies. The uploaded document is always the local managed file — the
  module never fetches a request-supplied URL. Exceptions are logged to `document_ocr_mindee`.

## Credentials (how the API key is supplied)

The key is **not** in Drupal config. `getCredentials()` (inherited from `document_ocr`'s
`ProcessorBase::getCredentials()`) does
`json_decode(trim(file_get_contents(realpath($this->credentials))), TRUE)` on the credentials
file whose path is set on the processor. Expected format:

```
{ "apikey": "[API-KEY]" }
```

Convention (README): store it at `private://document-ocr/mindee-credentials.json` and point the
processor at that path. The key is sent only in the `Authorization` request header — never placed
in a URL and never logged.

## The APIs repository

`document_ocr_mindee.apis_repository` → `Drupal\document_ocr_mindee\Repository\ApisRepository`
(`src/Repository/ApisRepository.php`, extends `document_ocr`'s `JsonRepositoryBase`) with
`$module = 'document_ocr_mindee'`, `$repository = 'apis'` — i.e. it loads
`repository/apis.json`. That file is the bounded product catalog; each entry has `name`,
`description` and a `versions` array. Shipped products include: `expense_receipts` (v3–v5),
`invoices` (v2–v4), `delivery_notes`, `financial_document`, `passport`, `proof_of_address`,
`bank_check`, `indian_passport`, `idcard_fr`, `carte_vitale`, `license_plates` (v1 unless noted).
To support a new Mindee product, add an entry here.
