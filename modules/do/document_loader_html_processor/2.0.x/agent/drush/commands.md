<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush: `dlhp:test`

`src/Drush/Commands/HtmlProcessorTestCommands.php` (`final class HtmlProcessorTestCommands extends
DrushCommands`, `use AutowireTrait`). A convenience command for running the HTML Processor loader
against a raw HTML string from the CLI. It injects `plugin.manager.document_loader`,
`html_processor.` `HtmlProcessingConfigBuilderInterface`, and `HtmlProcessingOutputHelperInterface`.

- Command: `document_loader_html_processor:test` — aliases `dlhp:test`.
- Plugin invoked: `document_loader_html_processor.html_processor`.
- **URL fetching is not supported here** — `resolveHtmlContent()` errors with
  *"Provide HTML via --content. URL fetching is not supported by this bridge."* if `--content` is
  empty. (Use the `document_loader_html_processor_url` submodule / `dlhpu:test` for URLs.)

## Options

| Option | Description |
|---|---|
| `--content` | Raw HTML string to process (**required**). |
| `--container` | CSS selector(s) to extract (comma-separated). |
| `--strip-regex` | Regex pattern(s) to strip (admin-trusted; newline-separated). |
| `--remove-ads` | `true`, a network name (`google`, `taboola`, …), or comma-separated networks. |
| `--base-url` | Base URL to resolve relative `href`/`src`. |
| `--output-full-document` | Wrap result in a full HTML document. |
| `--allow-safe-elements` | Enable the sanitizer with `allowSafeElements`. |
| `--minify` | Reduce whitespace. |
| `--out` | Write the result to a file path (use a relative path under DDEV). |

The `html_processor` config builder (`configBuilder->buildFromOptions($options)`) turns these flags
into the pipeline config array that becomes the `HtmlContentInput` options.

## Behaviour

`test()` builds the config, constructs `HtmlContentInput($html, $config)`, runs
`pluginManager->createInstance(PLUGIN_ID)->load($input, 'html')`, and emits the result via
`emitResult()`:

- with `--out`: validates the path (`outputHelper->validateOutputPath()`), writes with
  `writeToFile()`, and reports the byte count;
- without `--out`: prints the HTML, or — when `buildTerminalOutputPlan()` reports the output is
  large (>10 KB) — prints only a **first-1000-character preview** and advises saving to a file.

`DocumentLoaderHtmlProcessorException` and any other `\Throwable` are caught and logged (full
trace only in verbose mode).

## Examples

```bash
drush dlhp:test --content="<article><p>Hello</p></article>" --container=article
drush dlhp:test --content="<html>...</html>" --remove-ads=true --container=article --out=/var/www/html/clean.html
drush dlhp:test --content="<html>...</html>" --remove-ads=google,taboola
drush dlhp:test --content="<div class=\"main\"><p>Hi</p></div>" --container=.main
```
