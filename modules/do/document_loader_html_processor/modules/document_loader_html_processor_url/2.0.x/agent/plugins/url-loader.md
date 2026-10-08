<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The URL loader plugin

## Install & enable

The submodule ships inside `document_loader_html_processor`. Enable it separately (it is off by
default):

```bash
drush en document_loader_html_processor_url -y
```

Requires the parent `document_loader_html_processor` and `document_loader` (with `html_processor`
coming through the parent). It adds **no** permissions, routes, config objects, or config schema.

## The plugin

`src/Plugin/DocumentLoader/HtmlProcessorUrlLoader.php` (`class HtmlProcessorUrlLoader extends
DocumentLoaderBase`, `use HtmlProcessorTrait`). Attribute:

- id: `document_loader_html_processor_url.html_processor_url`
- label: *HTML Processor URL Loader*
- `document_loader_types: ['document_loader_type:website']`
- `output_types: ['html']`

`create()` injects the `html_processor` facade, `document_loader.type_factory`, and `http_client`.

`load(DocumentLoaderInputInterface $input, string $output_format = 'html')`:

1. rejects an unsupported `$output_format` (only `html`);
2. requires `$input instanceof WebsiteUrlInput` (else throws);
3. `$url = $input->getUrl(); $html = $this->fetchUrl($url, $input);`
4. `$config = $input->getMetadata(); $config['base_url'] ??= $url;` — **auto-injects the fetched
   URL as `base_url`** so relative links resolve unless the caller overrode it;
5. `$processed = $this->processHtml($html, $config);` (the parent trait — 10 MB re-check,
   `array_intersect_key` option filter, sanitizer-shorthand expansion, facade call);
6. returns `typeFactory->createOutput('html', $processed, ['source' => $url, 'options' =>
   $config])`.

## `fetchUrl()` — the fetch and its guards

`fetchUrl(string $url, WebsiteUrlInput $input): string`:

- **Scheme allowlist** — `ALLOWED_SCHEMES = ['http', 'https']`; `parse_url(...PHP_URL_SCHEME)` is
  lower-cased and checked first, so `file://`, `gopher://`, etc. are rejected before any network
  work (error uses the credential-redacted URL).
- **Input validation** — after the scheme guard, `$input->validate()` runs (well-formed-URL check
  via the parent framework's `WebsiteUrlInput`).
- **Guzzle request** — `httpClient->request('GET', $url, $options)` where `$options` sets
  `timeout` and `connect_timeout` from `$input->getTimeout()`; `stream => TRUE` (read on demand so
  the transfer can be aborted mid-stream); `allow_redirects` either `FALSE` (when
  `shouldFollowRedirects()` is false) or `['max' => $input->getMaxRedirects(), 'protocols' =>
  ['http','https']]` — **redirect protocols are pinned** so a `3xx` cannot bounce to a blocked
  scheme; `User-Agent` from `$input->getUserAgent()` (default
  `'Drupal Document Loader (document_loader_html_processor_url)'`) and an `Accept` header. A
  `GuzzleException` becomes a `DocumentLoaderHtmlProcessorException` (URL redacted).
- **Content-Type guard** — `ALLOWED_CONTENT_TYPES = ['text/html', 'application/xhtml+xml',
  'application/xml', 'text/xml']`. A present-but-unlisted type is rejected; a **missing/empty**
  Content-Type is allowed through (many servers omit it).
- **Size cap (10 MB)** — `MAX_HTML_BYTES = 10 * 1024 * 1024`. A pre-flight `Content-Length` over
  the cap is rejected early; then the body is read in `READ_CHUNK_BYTES` (8192) chunks in a
  `while (!$body->eof())` loop, aborting as soon as the running total exceeds the cap. An empty
  body is rejected.
- **Credential redaction** — `redactUrl()` rebuilds the URL from `parse_url()` parts **without**
  the `user:pass@` userinfo (falling back to a defensive regex when unparsable), so credentials
  never appear in exception messages or logs.

TLS certificate verification is left at Guzzle's secure default (no `verify => false`).

## Options

HTML-processing options are the flat `WebsiteUrlInput` metadata array and match the base module
(`container`, `strip_regex`, `remove_ads`, `base_url`, `sanitizer` [array or `'safe'`/`'static'`],
`output_full_document`, `minify`). URL-specific keys — `timeout`, `follow_redirects`,
`max_redirects`, `user_agent` — are consumed by `WebsiteUrlInput`'s own accessor methods and are
**dropped** before reaching the html_processor pipeline (the trait's `array_intersect_key`).

## Programmatic usage

```php
use Drupal\document_loader\DocumentLoaderType\Input\WebsiteUrlInput;

$loader = \Drupal::service('plugin.manager.document_loader')
  ->createInstance('document_loader_html_processor_url.html_processor_url');

$input = new WebsiteUrlInput('https://example.com/article', [
  'container'        => 'article',
  'remove_ads'       => TRUE,
  'sanitizer'        => 'safe',
  'timeout'          => 15,
  'follow_redirects' => TRUE,
]);

$processed = $loader->load($input, 'html')->getContent();
```

Prefer routing through `document_loader.manager` so the framework's validation, access check, and
hooks run. Because this loader performs an outbound request, only enable the submodule and grant
its invocation surfaces to trusted operators.
