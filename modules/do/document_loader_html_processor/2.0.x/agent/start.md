<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Document Loader: HTML Processor (document_loader_html_processor) — agent index

A **bridge** `DocumentLoader` plugin for the `document_loader` framework. It takes an in-memory
HTML string plus options and runs it through the **`html_processor`** module's pipeline
(container extraction, regex stripping, ad removal, relative-URL rewriting, Symfony
HtmlSanitizer, full-document wrap, minify), returning cleaned HTML. The plugin holds **zero HTML
logic itself** — everything is delegated to `HtmlProcessorInterface::process()`.

- Package `Document Loader Plugins`. Core `^10.4 || ^11`. PHP `>=8.2`. License GPL-2.0-or-later.
  Version 2.0.x (installed 2.0.0-rc2). Security advisory: **not covered**.
- Depends on `document_loader:document_loader (>=2.0)` and `html_processor:html_processor`.
- **No routes, no permissions, no config, no config schema, no admin form.** `services.yml` is
  empty (`services: {}`). Configuration is entirely code-driven.
- Ships one opt-in submodule → **`document_loader_html_processor_url`** (fetch HTML from a URL),
  documented in its own nested tree.

## Solution docs

- **The loader plugin, input types, the pipeline trait, and every processing option** →
  [api/loader.md](api/loader.md)
- **The `dlhp:test` Drush command** → [drush/commands.md](drush/commands.md)

## What it actually provides (from source)

- `DocumentLoader` plugin **`document_loader_html_processor.html_processor`** —
  `src/Plugin/DocumentLoader/HtmlProcessorLoader.php`, extends `DocumentLoaderBase`, uses
  `HtmlProcessorTrait`. `document_loader_types: ['document_loader_type:html_content']`,
  `output_types: ['html']`. `load()` reads the HTML from `$input->getContent()` and options from
  `$input->getMetadata()['options']`.
- `DocumentLoaderType` plugin **`document_loader_type:html_content`** —
  `src/Plugin/DocumentLoaderType/HtmlContentType.php`, `input_class: HtmlContentInput::class`.
- Input value objects — `src/DocumentLoaderType/Input/HtmlContentInput.php` (used by the type;
  flat `options` array) and `HtmlProcessorInput.php` (mirror of core `HtmlInput`; options under a
  `config` metadata key). Both implement the tool-schema statics
  (`getToolInputSchema`/`getToolCategoryLabel`/`getToolCategoryDescription`) so
  `document_loader`'s tool integration can expose the transform to AI agents.
- `HtmlProcessorTrait` — `src/Traits/HtmlProcessorTrait.php`. `processHtml()` enforces the
  `MAX_HTML_BYTES` (10 MB) cap, `array_intersect_key`-filters options to
  `getLoaderOptionsSchema()`, normalizes the `safe`/`static` sanitizer shorthands, and calls the
  facade. `getLoaderOptionsSchema()` reads `htmlProcessor->getPipelineOptionsSchema()` and flags
  which keys are LLM-visible.
- Exception `DocumentLoaderHtmlProcessorException` (`src/Exception/…`) wraps the facade's
  `HtmlProcessorException`.
- Drush command class `HtmlProcessorTestCommands` (`src/Drush/Commands/…`) — `dlhp:test`.

## Notes

- The base module **never fetches a URL**. Pass already-resolved HTML via `HtmlContentInput`; the
  Drush command refuses URL input. To fetch from a URL, enable the `document_loader_html_processor_url`
  submodule.
- A call with **no recognised options** deterministically returns the input unchanged (a no-op
  `output_full_document => FALSE` is injected so the facade does not fall back to site-wide
  settings).
- All HTML parsing/sanitizing happens inside the separate `html_processor` module — not in this
  module's code.
