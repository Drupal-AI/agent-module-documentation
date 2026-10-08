<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# WebpageLoader plugin (document_loader:webpage)

Source: `src/Plugin/DocumentLoader/WebpageLoader.php`. One class, `WebpageLoader extends
DocumentLoaderBase` (base from the `document_loader` module). This is the whole module — no other
PHP, no config, no routes, no services beyond the injected `http_client`.

## Install / enable

```
composer require drupal/document_loader_webpage
drush en document_loader_webpage -y
drush cr
```

Pulls in `drupal/document_loader`, `fivefilters/readability.php ^3.3`, and
`league/html-to-markdown ^5.1` via Composer. Enabling the module registers the plugin; run `drush cr`
after enabling so plugin discovery picks up the attribute. Verify with
`drush document-loader:list` (the parent's Drush command) — the `document_loader:webpage` loader
should appear as a loader for `document_loader_type:website`.

## Plugin definition (the `#[DocumentLoader]` attribute)

- `id: 'document_loader:webpage'`
- `label: 'Webpage Loader'`, `description: 'Load and convert content from web pages'`
- `document_loader_types: ['document_loader_type:website']` — it handles the parent's **Website**
  type (`Drupal\document_loader\Plugin\DocumentLoaderType\WebsiteType`, input class
  `WebsiteUrlInput`).
- `output_types: ['html', 'text', 'markdown']` — the formats it can produce.

## Dependencies injected

`create()` calls `parent::create()` then sets `$instance->httpClient = $container->get('http_client')`
(Guzzle `GuzzleHttp\ClientInterface`). That is the only service. Readability and the Markdown
converter are plain PHP objects instantiated inside the methods.

## `load(WebsiteUrlInput $input, string $output_format = 'text')`

Return type `DocumentLoaderOutputInterface`. Flow:

1. Reject non-`WebsiteUrlInput` with `throw new \InvalidArgumentException('WebpageLoader only accepts
   WebsiteUrlInput instances')`.
2. Normalise the format: `strtolower($output_format)`; an **empty** string becomes `'markdown'`
   (so a direct empty call defaults to Markdown, even though the parameter default is `'text'`).
3. Build Guzzle options (`buildRequestOptions()`), issue `httpClient->request('GET', $input->getUrl(),
   $options)`, read the body with `$response->getBody()->getContents()`.
4. Seed `$metadata` = `source` (the URL), `type` = `'webpage'`, `loader` = `'webpage_loader'`,
   `status_code`, `content_type` (response `Content-Type` header), `fetched_at` (`date('Y-m-d
   H:i:s')`).
5. `cleanHtml($html, $input, $metadata)` (adds Readability metadata, see below).
6. `match ($format)`: `'html'` → `HtmlOutput`, `'text'` → `TextOutput(htmlToText(...))`,
   `'markdown'` → `MarkdownOutput(htmlToMarkdown(...))`; anything else →
   `\InvalidArgumentException` from `getUnsupportedFormatMessage()` ("Output format '{x}' is not
   supported. Supported formats are: html, text, markdown").
7. Error handling: an inner `\InvalidArgumentException` (bad input / bad format) is rethrown as-is;
   any other `\Exception` (network, parse) is wrapped as
   `throw new \Exception('Unable to load webpage: ' . $e->getMessage())`.

The three `*Output` value objects come from `document_loader` and each hold `(content, metadata)`;
callers read them via `getContent()` / `getMetadata()`.

## `buildRequestOptions(WebsiteUrlInput $input)`

Builds the Guzzle option array from the input's accessors (all optional, with defaults from
`WebsiteUrlInput`):

- `timeout` → `$input->getTimeout()` (default **30** s).
- `allow_redirects` → `['max' => $input->getMaxRedirects()]` when `shouldFollowRedirects()` is TRUE
  (default TRUE, max default **5**), else `FALSE`.
- `headers`: `User-Agent` → `$input->getUserAgent()` or the literal
  `'Drupal Document Loader (document_loader_webpage)'`; `Accept:
  text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8`.

TLS verification is left at Guzzle's default (verified). No `verify => false` anywhere.

## `cleanHtml(string $html, WebsiteUrlInput $input, array &$metadata)`

1. Empty/whitespace body → returns `''`.
2. `new Readability(new Configuration())` then `$readability->parse($html)` inside a `try` that
   swallows `fivefilters\Readability\ParseException` (fall through to the DOM fallback).
3. Populates metadata: `site_name`, `title`, `author`, `excerpt` from the Readability getters
   (each `?? ''`).
4. `$content = (string) ($readability->getContent() ?? '')`. If the stripped content is empty,
   **fallback**: `new \DOMDocument(); @$dom->loadHTML($html, LIBXML_NOERROR)`, take the first
   `<body>`, concatenate `saveHTML()` of each child node.
5. Optional regex removals from the input flags: `shouldRemoveNavigation()` → strips `<nav>…</nav>`
   and `<footer>…</footer>`; `shouldRemoveAds()` → strips `<aside>…</aside>` (all `/is` regex).
6. **Always** strips `<script>…</script>` and `<style>…</style>`.
7. If a `title` was found, prepend `'<h1>' . htmlspecialchars($title) . '</h1>'` to `trim($content)`;
   otherwise return `trim($content)`.

Note the README says `remove_navigation` removes `<header>` too, but the code strips only `<nav>` and
`<footer>` (not `<header>`); `remove_ads` strips `<aside>` only.

## `htmlToText(string $html)`

Pure-string conversion (no DOM): inserts `\n` after the closing tags of block elements
(`p|div|li|h1-6|blockquote|pre|tr|table|thead|tbody|tfoot|section|article|header|footer|nav|aside|
figure|figcaption`), turns `<br>`/`<br/>` into `\n`, adds a space after `</td>`/`</th>`, then
`strip_tags()`, collapses 3+ newlines to 2, and `trim()`s.

## `htmlToMarkdown(string $html)`

Empty → `''`. Otherwise `new League\HTMLToMarkdown\HtmlConverter([...])` with `header_style: 'atx'`,
`strip_tags: TRUE`, `bold_style: '**'`, `italic_style: '*'`, `use_autolinks: FALSE`, then
`trim($converter->convert($html))`.

## WebsiteUrlInput options (defined by the parent `document_loader` module)

`Drupal\document_loader\DocumentLoaderType\Input\WebsiteUrlInput` — constructed as
`new WebsiteUrlInput(string $url, array $metadata = [])`. Metadata keys read by this loader (via the
input's accessors):

| key | accessor | default | effect |
|---|---|---|---|
| `user_agent` | `getUserAgent()` | null → default UA | request User-Agent |
| `timeout` | `getTimeout()` | 30 | Guzzle timeout (s) |
| `follow_redirects` | `shouldFollowRedirects()` | TRUE | follow HTTP redirects |
| `max_redirects` | `getMaxRedirects()` | 5 | redirect cap |
| `remove_navigation` | `shouldRemoveNavigation()` | FALSE | strip `<nav>`/`<footer>` |
| `remove_ads` | `shouldRemoveAds()` | FALSE | strip `<aside>` |

`WebsiteUrlInput::validate()` requires a non-empty URL passing `filter_var(…, FILTER_VALIDATE_URL)`;
`checkAccess()` returns `AccessResult::neutral()`.

## How it plugs into the pipeline

The loader is never called directly by end users. The parent framework selects it as the default
loader for `document_loader_type:website` and drives it through
`DocumentLoaderManager::loadFromInput()` / `loadFromData()` (validate → access check → loader
selection → pre-load hook → `load()` → post-load hook → truncate), returning a
`DocumentLoaderResult`. Invocation surfaces (all in `document_loader` or its submodules):

- **Explorer form** `/admin/config/media/document-loader/explorer` (permission
  `document_loader.administer`).
- **Tool API** — `document_loader_tool` submodule (requires `drupal/tool`) derives a "Load from
  website" AI tool (permission `use document_loader tool`).
- **Field Widget Action** — `document_loader_fwa` submodule.
- **MDX editor dialog** — `document_loader_mdx` submodule (`/document-loader/mdx/dialog`).
- **Drush** — `drush document-loader:load --input url=https://example.com --output-format=markdown`.
- **Programmatic** — `\Drupal::service('plugin.manager.document_loader')
  ->createInstance('document_loader:webpage')->load($input, 'markdown')`, or via
  `document_loader.manager`.

### Minimal programmatic example

```php
$loader = \Drupal::service('plugin.manager.document_loader')
  ->createInstance('document_loader:webpage');
$input = new \Drupal\document_loader\DocumentLoaderType\Input\WebsiteUrlInput(
  'https://example.com/article',
  ['timeout' => 45, 'remove_navigation' => TRUE, 'remove_ads' => TRUE],
);
$markdown = $loader->load($input, 'markdown')->getContent();
```

Prefer routing through `document_loader.manager` rather than calling `load()` directly — the manager
runs validation, the access check, and the pre/post-load hooks that a bare `load()` skips.
