<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Document Loader Plugin - Webpage (document_loader_webpage) — agent index

A single `DocumentLoader` plugin that fetches a web page over HTTP/HTTPS and converts it to HTML,
plain text, or Markdown. It is a plugin provider for the **`document_loader`** framework — it has
**no routes, forms, permissions, config, config schema, or Drush of its own**. Package
`Document Loader Plugins`. Core `^10.3 || ^11`. License GPL-2.0-or-later. Version 1.0.0 (dir 1.0.x).

- **The loader plugin, the fetch mechanics, HTML cleaning, format conversion, and how it plugs into the pipeline** →
  [plugins/webpage-loader.md](plugins/webpage-loader.md)

## Dependencies

- Drupal module: **`document_loader`** (`document_loader:document_loader`, `^2.0@beta`) — supplies the
  plugin type, the `WebsiteUrlInput`/output value objects, and the manager/factory pipeline.
- Composer libraries (PHP, not Drupal libraries): **`fivefilters/readability.php` `^3.3`** (main-content
  extraction) and **`league/html-to-markdown` `^5.1`** (HTML→Markdown).

## What it actually provides (from source)

- One plugin: **`WebpageLoader`** (id **`document_loader:webpage`**, label *"Webpage Loader"*),
  `src/Plugin/DocumentLoader/WebpageLoader.php`, extends `document_loader`'s `DocumentLoaderBase`.
  Attribute: `document_loader_types: ['document_loader_type:website']`,
  `output_types: ['html', 'text', 'markdown']`. It is the loader for the parent's **Website** type
  (`WebsiteType` → `WebsiteUrlInput`).
- `create()` injects only the core **`http_client`** (Guzzle `ClientInterface`).
- `load(WebsiteUrlInput $input, string $output_format = 'text')` — GET the URL via Guzzle, clean the
  HTML, and return `HtmlOutput` / `TextOutput` / `MarkdownOutput`. An empty format string defaults to
  `markdown`; format match is case-insensitive; a non-`WebsiteUrlInput` throws
  `\InvalidArgumentException`; an unsupported format throws with the supported list; any network/parse
  error is re-thrown as a generic `\Exception('Unable to load webpage: …')`.
- No `.install`, `.module`, `.services.yml`, `config/`, or `hook_*`. The only test is
  `tests/src/Unit/Plugin/DocumentLoader/WebpageLoaderTest.php` (Guzzle `MockHandler`).

## How it is invoked (no route of its own)

The plugin is never reached directly. Callers go through the parent `document_loader` framework:
`document_loader.manager` (`loadFromInput()` / `loadFromData()`), the Explorer admin form
(`/admin/config/media/document-loader/explorer`), the `document_loader_tool` AI tool submodule, the
`document_loader_fwa` Field Widget Action, the `document_loader_mdx` editor dialog, or
`drush document-loader:load --input url=…`. See [plugins/webpage-loader.md](plugins/webpage-loader.md).
