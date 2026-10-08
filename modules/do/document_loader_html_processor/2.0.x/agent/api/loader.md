<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The HTML Processor loader plugin & API

## Install & enable

```bash
composer require drupal/html_processor drupal/document_loader_html_processor
drush en document_loader_html_processor -y
```

Requires `document_loader >=2.0` and `html_processor ^1.0` (both must be enabled). No sub-modules
are required; `document_loader_html_processor_url` is optional and off by default. This module
ships **no permissions, no routes, no config objects, and no config schema** — `services.yml` is
empty. It only registers plugins with the `document_loader` framework.

## The plugin

`src/Plugin/DocumentLoader/HtmlProcessorLoader.php` (`class HtmlProcessorLoader extends
DocumentLoaderBase`, `use HtmlProcessorTrait`). Attribute:

- id: `document_loader_html_processor.html_processor`
- label: *HTML Processor*
- `document_loader_types: ['document_loader_type:html_content']`
- `output_types: ['html']`

`create()` injects the `html_processor` facade (`$container->get(HtmlProcessorInterface::class)`)
and `document_loader.type_factory`. `load(DocumentLoaderInputInterface $input, string
$output_format = 'html')`:

1. rejects any `$output_format` not in `getSupportedOutputTypes()` (only `html`) —
   throws `DocumentLoaderHtmlProcessorException`;
2. reads `$html = $input->getContent()` and `$config = $input->getMetadata()['options'] ?? []`;
3. calls `processHtml($html, $config)` (the trait);
4. returns `typeFactory->createOutput('html', $processed, $input->getMetadata())` (an `HtmlOutput`).

### The input type & input classes

- `src/Plugin/DocumentLoaderType/HtmlContentType.php` — `DocumentLoaderType` plugin id
  `document_loader_type:html_content`, `input_class: HtmlContentInput::class`.
- `src/DocumentLoaderType/Input/HtmlContentInput.php` — constructor
  `__construct(string $html, array $options = [])`. `getContent()` returns the HTML;
  `getMetadata()` returns `['options' => $this->options]`; `validate()` fails only on an empty
  string; `checkAccess()` returns `AccessResult::allowed()` (content is already in memory).
- `src/DocumentLoaderType/Input/HtmlProcessorInput.php` — an alternative value object mirroring
  core `HtmlInput`: options live under `metadata['config']` and are read by `getConfig()`. Also a
  pure value object (no I/O).

Both input classes implement the static tool methods `getToolInputSchema()`,
`getToolCategoryLabel()`, `getToolCategoryDescription()` so that `document_loader`'s tool
deriver can surface "Process HTML content" as an AI tool.

## The pipeline (HtmlProcessorTrait)

`src/Traits/HtmlProcessorTrait.php` — shared by this loader and the URL submodule's loader.

- `getLoaderOptionsSchema()` returns `htmlProcessor->getPipelineOptionsSchema()`, tagging each key
  with `hide_from_llm_by_default` (only `container`, `remove_ads`, `base_url`, `head_filter`,
  `minify` are LLM-visible).
- `processHtml(string $html, array $config): string`:
  1. throws if `strlen($html) > MAX_HTML_BYTES` (**10 MB**);
  2. `$pipelineConfig = array_intersect_key($config, $this->getLoaderOptionsSchema())` — **any key
     not declared by the schema is dropped** (prevents option bleed / sanitizer-key collision in
     the facade);
  3. if the filtered config is empty, injects `output_full_document => FALSE` so a no-options call
     deterministically returns the input unchanged instead of falling back to site-wide
     `html_processor` settings;
  4. sets `$pipelineConfig['content'] = $html`;
  5. expands the `sanitizer` shorthand via `normalizeSanitizerOptions()`;
  6. calls `htmlProcessor->process($pipelineConfig)`, translating a facade
     `HtmlProcessorException` into `DocumentLoaderHtmlProcessorException`.
- `normalizeSanitizerOptions(mixed $value)`: an array passes through unchanged; `'safe'` →
  `['allowSafeElements' => TRUE]`; `'static'` → `['allowStaticElements' => TRUE]`; anything else
  → `[]` (facade treats it as "no sanitizer").

## Processing options

Passed as the second `HtmlContentInput` constructor argument (a **flat** array — not nested under
`config`):

| Key | Meaning |
|---|---|
| `container` | CSS selector(s) to extract. Comma-separated string; selectors extracted and concatenated in order. |
| `strip_regex` | Regex pattern(s) to remove. String or array of strings (admin-trusted input). |
| `remove_ads` | `TRUE` (common patterns), a network slug (`'google'`, `'doubleclick'`, `'taboola'`, `'outbrain'`, `'media.net'`), `['networks' => [...]]`, or `['custom_patterns' => [...], 'include_common' => bool]`. |
| `base_url` | http/https URL used to rewrite relative `href`/`src` to absolute. |
| `sanitizer` | Symfony `HtmlSanitizer` options array, or shorthand `'safe'` / `'static'`. |
| `output_full_document` | `TRUE` wraps the result in DOCTYPE/html/head/body. |
| `minify` | `TRUE` reduces whitespace to lower token count. |

The authoritative set of recognised keys is whatever `html_processor`'s
`getPipelineOptionsSchema()` declares; unrecognised keys are silently discarded (see the trait).

## Programmatic usage

```php
use Drupal\document_loader_html_processor\DocumentLoaderType\Input\HtmlContentInput;

$loader = \Drupal::service('plugin.manager.document_loader')
  ->createInstance('document_loader_html_processor.html_processor');

$input = new HtmlContentInput($html, [
  'container'   => 'article',
  'remove_ads'  => TRUE,
  'base_url'    => 'https://example.com/page',
  'sanitizer'   => 'safe',
]);

$processed = $loader->load($input, 'html')->getContent();
```

Prefer routing through `document_loader.manager` (`DocumentLoaderManager::loadFromInput()` /
`loadFromData()`) when you want the framework's validation, access check, and pre/post-load hooks
to run.

## Errors

`DocumentLoaderHtmlProcessorException` (`src/Exception/…`, extends `\Exception`) is thrown for an
unsupported output format, an over-size payload, or an invalid pipeline/sanitizer option (wrapped
from the facade's `HtmlProcessorException`).
