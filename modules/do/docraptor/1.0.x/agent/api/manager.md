<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `docraptor.manager` service — generating a document

`Drupal\docraptor\DocraptorManager` (service id **`docraptor.manager`**,
`src/DocraptorManager.php`, `docraptor.services.yml`) is the module's only behaviour. It wraps the
`docraptor/docraptor` PHP SDK. There is **no route or controller** that calls it — custom code does.

## Construction

Injected arguments (`docraptor.services.yml`): `@config.factory`, `@logger.factory`,
`@cache.data`, `@language_manager`, `@key.repository`. (`cache.data` and `language_manager` are
stored but unused in this version.)

The constructor:

1. loads config object `docraptor.settings`;
2. reads `username_key` and fetches the secret via
   `keyRepository->getKey($username_key)->getKeyValue()`;
3. creates a `DocRaptor\DocApi` and calls `->getConfig()->setUsername($username)` (DocRaptor uses
   the API key as the basic-auth username).

There is no null guard on `getKey()`, so the service errors if `username_key` is unset — configure
the settings form before instantiating it.

## Public methods

### `preparePdfDocument(string $html, string $filename): void`

Builds `$this->docraptor = new DocRaptor\Doc()` and applies config:

- `setTest($config->get('enable_test'))`
- `setDocumentContent($html)` — the HTML to render (caller-supplied markup, e.g. a rendered
  template)
- `setName($filename)`
- `setDocumentType($config->get('document_type'))`
- `setPrinceOptions([...])` from config: `pdf_forms` ← `enable_pdf_forms`,
  `pdf_profile` ← `pdf_profile`, `color_conversion` ← `color_conversion`,
  `icc_profile` ← `enable_icc_profile`.

### `savePdfDocument(string $absolutePath): void`

Calls `docraptorApi->createDoc($this->docraptor)` (the actual HTTPS call to DocRaptor) and writes
the returned bytes with `file_put_contents($absolutePath, $create_response)`. On
`DocRaptor\ApiException` it logs `'DocRaptor API Error: @error'` to the **`docraptor`** logger
channel and re-throws as a generic `\Exception('Failed to generate PDF: …')`. Call
`preparePdfDocument()` first; `savePdfDocument()` depends on `$this->docraptor` being set.

## Calling it

```php
/** @var \Drupal\docraptor\DocraptorManager $manager */
$manager = \Drupal::service('docraptor.manager');   // inject it in real code
$html = '<html><body><h1>Invoice #42</h1></body></html>';
$manager->preparePdfDocument($html, 'invoice-42.pdf');
$manager->savePdfDocument('/absolute/path/invoice-42.pdf');
```

The caller chooses the HTML and the destination path; the module does not create a managed file,
serve a download, or clean up the file. Wrap the call in try/catch to handle generation failures.
