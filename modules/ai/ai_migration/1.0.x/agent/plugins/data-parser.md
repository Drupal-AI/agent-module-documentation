<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Migration — `ai` data parser & migration YAML

Class: `Plugin/migrate_plus/data_parser/Ai.php` (`@DataParser id = "ai"`, extends `DataParserPluginBase`). Used as `data_parser_plugin: ai` under a Migrate Plus `url` source.

## Source configuration (migration YAML)
```yaml
source:
  plugin: url
  data_fetcher_plugin: http        # migrate_plus HTTP fetcher gets the raw HTML
  data_parser_plugin: ai           # this module
  skip_count: true
  urls:                            # one or more page URLs (authored by the migration developer)
    - https://example.com/post/1
  ai:
    model:                         # optional; else site default chat provider is used
      provider_id: anthropic
      model_id: claude-sonnet-4-5-20250929
      config: { temperature: 0, max_tokens: 8096 }
      structured_output: false
    prompt:                        # optional per-role overrides (see prompts.md)
      - { role: system, operation: append, prompt: "Return minified JSON only." }
    html_processor:                # optional; document_loader_html_processor options
      container: [ 'head', '#main-content' ]
      strip_regex: [ '/<script\b[^>]*>.*?<\/script>/is' ]
      minify: true
      head_filter: true
      sanitizer:                   # Symfony HtmlSanitizer options (NESTED under sanitizer:)
        allowStaticElements: true
        dropAttribute: [ [ 'style', [ '*' ] ] ]
  types:
    - node:article                 # entity_type:bundle -> drives schema generation
  ids:
    url: { type: string }
process: { … map attributes/* and relationships/* onto fields … }
destination:
  plugin: 'entity:node'
```
`container` and `strip_regex` stay top-level; all Symfony sanitizer method names moved under `sanitizer:` in the document_loader_html_processor integration (top-level sanitizer keys are now silently ignored).

## Constructor wiring (`__construct`)
Reads `configuration['urls']`, `item_selector`, `configuration[ai]['html_processor']`, and `configuration[ai]['prompt']`. If html_processor options exist it resolves `document_loader_html_processor.html_processor` once (must implement `DocumentLoaderInterface`). If a prompt block exists it calls `promptManager->setConfig()`. `create()` injects the migrate_plus data-fetcher manager, `ai_migration.ai_migrator`, `plugin.manager.document_loader`, `ai_migration.prompt_manager`, and the `ai_migration` logger.

## Per-URL flow — `openSourceUrl(string $url)`
1. `getDataFetcherPlugin()->getResponseContent($url)` — HTTP GET of the source page (migrate_plus http fetcher).
2. Split `types[0]` into `[$entity_type, $bundle]`.
3. If html_processor configured: wrap in `HtmlContentInput($sourceData, $htmlProcessorOptions)` and run `documentLoaderPlugin->load(...)->getContent()` (sanitize/clean); failures log and return FALSE.
4. `aiMigrator->convert($promptManager, $url, $sourceData, $entity_type, $bundle, $configuration['ai']['model'] ?? [])` → structured array.
5. If `item_selector` set, walk it slash-by-slash into the AI result (used by the media example to pick `relationships/field_cover/data/0`).

`fetchNextRow()` yields a single item per URL: `['url' => $currentUrl, ...$aiResults]`. `url` is the migration id key.

## Pipeline notes
- The AI result is JSON:API-shaped: process mappings read `attributes/<field>` and `relationships/<field>/data/...` with standard Migrate process plugins (`get`, `default_value`, `sub_process`, `migration_lookup`, `entity_generate`, `skip_on_empty`, and migrate_file's `image_import`).
- Text fields are written through a **text format** chosen in the migration (the examples use `basic_html`) so imported HTML is filter-sanitized on render; the examples also default `status: 0` (unpublished) so imported nodes are reviewed before publishing. These are migration-author choices — set an appropriate format and published state for your content.
- Operated only via drush/`migrate_tools` or the Migrate Plus UI; source URLs are fixed in the migration YAML, not taken from an end-user request.
