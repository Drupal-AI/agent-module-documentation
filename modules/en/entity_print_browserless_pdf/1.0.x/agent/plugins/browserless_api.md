<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `BrowserlessApi` print engine

`src/Plugin/EntityPrint/PrintEngine/BrowserlessApi.php` — the module's only class.

```
@PrintEngine(
  id = "browserless_api",
  label = @Translation("Browserless API"),
  export_type = "pdf"
)
```

Extends `Drupal\entity_print\Plugin\EntityPrint\PrintEngine\PdfEngineBase`, implements
`ContainerFactoryPluginInterface`. Entity Print discovers it as a PDF engine; pick it on the
Entity Print settings form.

## Construction (`create()` / `__construct()`)

Injected: `request_stack`, `http_client_factory` (core `Drupal\Core\Http\ClientFactory`),
`logger.factory` (channel `entity_print_browserless_pdf`), plus the `pdf` export-type instance.

- Builds the endpoint as `Url::fromUri($this->configuration['endpoint'] . '/pdf')`. So the configured
  endpoint (e.g. `https://chrome.browserless.io`) gets `/pdf` appended.
- If `configuration['token']` is set, it is attached as the URL **query parameter** `token`
  (`$endpoint->setOptions(['query' => ['token' => ...]])`).
- Creates the Guzzle client with `$client_factory->fromOptions([...])` setting only headers
  `Content-Type: application/json` and `Cache-Control: no-cache`. **No custom `verify` option** —
  the client keeps Guzzle's default TLS certificate verification.

## Page assembly (`addPage()`)

Entity Print calls `addPage($content)` per printable page. Pages are collected in `$this->pages`.
For every page after the first, a break marker
`<html><body><div style="page-break-before: always;"></div></body></html>` is inserted before the
page HTML, so multi-page prints paginate.

## Asset rewriting (`prepareHtml()`, private)

Before sending, iterates `$this->pages` and, per page, loads the HTML into a `\DOMDocument`
(errors suppressed). For each `/html/head/link[@href]` and each `<script src>` whose value starts
with `/` (root-relative), it prefixes it with an absolute base:
`$this->configuration['asset_url'] ?: $this->request->getSchemeAndHttpHost()`. This lets the remote
Chrome fetch the site's CSS/JS by absolute URL. `saveHTML()` writes the rewritten markup back.

## PDF request (`getBlob()`)

1. Calls `prepareHtml()`.
2. Builds the JSON payload: `html` = `implode("", $this->pages)`, `options` = `buildPrintOptions()`,
   `safeMode` = `(bool) configuration['safe_mode']`, plus `gotoOptions.waitUntil = "networkidle2"`.
3. `POST`s to `$this->endpoint->toString()` via the Guzzle client and returns
   `$response->getBody()->getContents()` (the raw PDF bytes).
4. On `ConnectException` / `ClientException` / `ServerException` / `BadResponseException`, it logs a
   warning and re-throws as `Drupal\entity_print\PrintEngineException`.

`buildPrintOptions()` maps config to the Browserless/Chrome PDF `options`: `format` (from
`getPaperSizes()` indexed by `default_paper_size`), `margin` (each side = value + unit),
`preferCSSPageSize: false`, and conditionally `displayHeaderFooter` + trimmed
`headerTemplate`/`footerTemplate`, and `printBackground`.

`getPaperSizes()` returns Chrome format names: `Letter, Legal, Tabloid, Ledger, A0…A6`.

## Output (`send()`)

Wraps `getBlob()` in a Symfony `Response` with `Content-Type: application/pdf`,
`Content-Transfer-Encoding: Binary`, `Content-Length`, and a `Content-Disposition` computed by
`HeaderUtils::makeDisposition()` — attachment when `$force_download`, otherwise inline. Returns
`$response->send()`. A `PrintEngineException` is caught and returned.

## Other overrides

- `testEndpoint()` (private) — POSTs `{"html":"<html><body>Test</body></html>"}` to the endpoint and
  returns the HTTP status (or NULL on connect failure); used by the form to show a success message.
- `dependenciesAvailable()` returns `TRUE` (no local binary/library to detect).
- `getPrintObject()` returns the Guzzle client.
