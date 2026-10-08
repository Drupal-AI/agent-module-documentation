<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI agents, function calls, source-profile plugin type & migrate plugins

## AI agents (`ai_agents` plugins, `src/Plugin/AiAgent/`)

- **`ai_content_migrate_agent`** — `AiContentMigrate extends AiAgentBase` (`#[AiAgent(id:
  'ai_content_migrate_agent', …)]`). The legacy-HTML agent, driven from the AI Agents Explorer.
  Router → model proposal → schema apply → single-page import or queue (dry-run supported). Injects
  entity/field managers, display repo, `file.repository`, `http_client`, `logger.factory`, `state`,
  `datetime.time`, `queue`. Renders pages with headless Chromium (`HeadlessChromium\BrowserFactory`,
  `CHROME_PATH` or `/usr/bin/chromium`). Persists the chosen model in `state` keys
  (`ai_content_migrate.last_model`, `.last_model_sitemap`, …), reset by `ResetController`. Prompt
  templates in `prompts/ai_content_migrate_agent/` (`RouterCall.yml`, `modelProposal.yml`,
  `modelProposalParagraphs.yml`, `modelProposal-v2.yml`); default config
  `install/ai_agents.ai_agent.ai_content_migrate_agent.yml`.
- **`ai_content_migrate_content_model_agent`** — `ContentModelAgent extends AiAgentBase` (label "AI
  DrupalCMS CM Agent"). Used by the sitemap flow (`SitemapImportForm::processUrl`): fetches a URL's
  rendered HTML, proposes a content model + XPath mappings for that page. Prompts in
  `prompts/tools/*.md` and `prompts_ai_drupalcms_cm/tools/`.

### The model JSON

The unit of work is a **model** array: `content_types[]` (`type`, `label`, `fields[]` with
`name`/`type`/`xpaths[]`/`cardinality`/`required`), `taxonomies[]` (`vocabulary`, `terms[]`),
`media_bundles[]` (`bundle`, `items[]` with `url`/`alt`). Loose LLM JSON is repaired before use.
Applying a model creates missing vocabularies/terms, media types, node types, fields (image/file
field types remapped to `entity_reference`→media; any `field_name` containing `tags` forced to a
`taxonomy_term` reference) and form/view display components. All writes skipped under dry-run.

## AI function calls (`ai` plugins, `src/Plugin/AiFunctionCall/`)

- **`ai_content_migrate:html_from_url`** (`HtmlFromUrl`) — group `content_migration`; takes a `url`
  context and returns the page's fully-rendered HTML via `HtmlFetcher::fetch()` (headless Chromium).
- **`ai_content_migrate:propose_content_model`** (`ProposeContentModel`).
- **`ai_content_migrate:propose_database_content_model`** (`ProposeDatabaseContentModel`).
- **`ai_content_migrate:validate_xpaths`** (`ValidateXPaths`).

## `database_source_profile` — the module's own plugin type

Manager service `plugin.manager.ai_content_migrate.database_source_profile`
(`DatabaseSourceProfileManager extends DefaultPluginManager`): discovery dir
`Plugin/DatabaseSourceProfile`, interface `DatabaseSourceProfileInterface`, attribute
`#[DatabaseSourceProfile]` (`src/Attribute/DatabaseSourceProfile.php`: `id`, `label`, `description`,
`required_tables`, `optional_tables`, `deriver`), alter hook
`ai_content_migrate_database_source_profile_info`. `detect($table_names)` scores every profile by its
table-name match and returns the best over `MIN_SCORE = 0.5`. A profile recognizes a known
application's schema deterministically and maps it to Drupal content without per-table AI guessing.

Shipped profiles (`src/Plugin/DatabaseSourceProfile/`): **`Confluence`** (Atlassian Confluence
Server/Data Center) and **`Declarative`** (+ `DeclarativeProfileDeriver`) — the engine that runs any
approved YAML source profile (`aicm_source_profile`) as `declarative:{id}`. Wiki-like applications
extend `WikiSourceProfileBase` (implement `extract()`, `convertBody()`, `findUnknownElements()`,
`legacyUrls()`); body formats are `BodyConverter` plugins-by-convention (`html`,
`confluence_storage`, `plain_text`).

## Migrate source & process plugins (`src/Plugin/migrate/`)

Reusable inside generated `migrate_plus` definitions (run via Drush / migrate_plus):

- **Sources:** `ai_content_migrate_dataset` (`Dataset` — reads source-profile dataset rows from the
  key/value store), `ai_content_migrate_html_images` (`HtmlImages`).
- **Process:** `dom_select_html` (`DomSelectHtml`), `get_full_path` (`GetFullPath`), `download_or_skip`
  (`DownloadOrSkip`, extends core `Download`; throws `MigrateSkipRowException` on failure),
  `empty_coalesce` (`EmptyCoalesce`, extends core `NullCoalesce`), `ai_content_migrate_local_file`
  (`LocalFile` — copies an extracted attachment to a fixed URI, returns its file id),
  `ai_content_migrate_media_lookup_all` (`MediaLookupAll`), `migrate_process_html`
  (`MigrateProcessHtml`), `flatten_extract` (`FlattenExtract`, `handle_multiples`), `file_import`
  (`FileMediaImport`, `@MigrateProcessPlugin`).

## Queue worker

`ai_content_migrate.import_content` (`ImportContentQueue`, `cron={"time"=60}`) — `processItem($data)`
GETs `$data['url']` HTML and calls `importer->importContent()`; fetch failures are logged and
re-thrown for retry. See [../api/services.md](../api/services.md).
