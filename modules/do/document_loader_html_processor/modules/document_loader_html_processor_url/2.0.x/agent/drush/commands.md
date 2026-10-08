<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush: `dlhpu:test`

`src/Drush/Commands/HtmlProcessorUrlTestCommands.php` (`final class HtmlProcessorUrlTestCommands
extends DrushCommands`, `use AutowireTrait`). Fetches a URL and runs the returned HTML through the
URL loader from the CLI. Injects `plugin.manager.document_loader`, the `html_processor`
`HtmlProcessingConfigBuilderInterface`, and `HtmlProcessingOutputHelperInterface`.

- Command: `document_loader_html_processor_url:test` — aliases `dlhpu:test`.
- Plugin invoked: `document_loader_html_processor_url.html_processor_url`.
- Requires `--url` (http/https only); errors if omitted.

## Options

| Option | Description |
|---|---|
| `--url` | URL to fetch and process (http/https only, **required**). |
| `--container` | CSS selector(s) to extract (comma-separated). |
| `--strip-regex` | Regex pattern(s) to strip (admin-trusted; newline-separated). |
| `--remove-ads` | `true`, a network name, or comma-separated networks. |
| `--base-url` | Override the auto-detected base URL. |
| `--output-full-document` | Wrap result in a full HTML document. |
| `--allow-safe-elements` | Enable the sanitizer with `allowSafeElements`. |
| `--minify` | Reduce whitespace. |
| `--timeout` | HTTP request timeout in seconds (WebsiteUrlInput default 30). |
| `--no-follow-redirects` | Disable redirect following. |
| `--max-redirects` | Maximum redirects to follow (default 5). |
| `--user-agent` | Custom User-Agent string. |
| `--out` | Write the result to a file path (relative path under DDEV). |

The html_processor options are built by `configBuilder->buildFromOptions($options)`; the
URL-specific keys are assembled by `buildUrlMetadata()` (only keys the user actually set are
included, so unset ones fall back to `WebsiteUrlInput`'s defaults: `timeout: 30`,
`follow_redirects: TRUE`, `max_redirects: 5`). Both are merged into the `WebsiteUrlInput` metadata.

## Behaviour

`test()` merges config + URL metadata, constructs `WebsiteUrlInput($url, $metadata)`, runs
`$input->validate()` (reporting any errors), then
`pluginManager->createInstance(PLUGIN_ID)->load($input, 'html')` and emits via `emitResult()`
(same file/preview logic as the base command: writes to `--out`, or prints, or shows a
first-1000-character preview when the output is large). `DocumentLoaderHtmlProcessorException` and
other `\Throwable`s are caught and logged (full trace only in verbose mode).

## Examples

```bash
drush dlhpu:test --url=https://example.com --container=article
drush dlhpu:test --url=https://example.com --remove-ads=true --container=article --out=/var/www/html/clean.html
drush dlhpu:test --url=https://example.com --allow-safe-elements --minify
drush dlhpu:test --url=https://example.com --timeout=60 --no-follow-redirects
```
