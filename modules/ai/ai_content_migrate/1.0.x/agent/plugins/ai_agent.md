<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The AI Content Migrate agent (`ai_content_migrate_agent`)

`src/Plugin/AiAgent/AiContentMigrate.php` — class `AiContentMigrate extends AiAgentBase implements
AiAgentInterface`, declared with `#[AiAgent(id: 'ai_content_migrate_agent', label: ...)]`. It is an
`ai_agents` plugin, driven from the **AI Agents Explorer** (route `ai_agents_explorer.explorer`,
`agent_id=ai_content_migrate_agent`), not from a route this module registers. `isAvailable()`
requires the `node` and `media` modules. It injects `entity_type.manager`, `entity_field.manager`,
`entity_display.repository`, `file.repository`, `http_client`, `logger.factory`, `state`,
`datetime.time`, `queue`.

## Task lifecycle (AiAgentBase contract)

- `determineSolvability()` → calls `determineTaskType()`, appends `['action' => $taskType]` to the
  data, returns `JOB_SOLVABLE` (applySchema), `JOB_NEEDS_ANSWERS` (question / discoverSource /
  discoverSitemap) or `JOB_NOT_SOLVABLE` (fail).
- `determineTaskType()` — runs the **`RouterCall`** sub-agent (`prompt` = task description +
  existing model) to classify intent and extract `urls`. Branches: `refineModel`, `DryRunImport`
  (sets dry-run state), `analyzeSitemap`, `analyzeParagraphs`, else import. For a single URL it
  renders the page (`retrieveContentHtml()`) and runs the **`modelProposal`** (or
  **`modelProposalParagraphs`**) sub-agent; for a sitemap it runs `discoverSitemap()`.
- `askQuestion()` / `answerQuestion()` — render an HTML preview of the proposed model
  (`formatProposedModel()` / `formatProposedModelForSitemap()`), values escaped with `Html::escape()`.
- `solve()` — on `applySchema` calls `createContentTypesAndFields()`; on `discoverSource` returns ''.

Sub-agent prompt templates live in `prompts/ai_content_migrate_agent/` (`RouterCall.yml`,
`modelProposal.yml`, `modelProposalParagraphs.yml`); the agent config default is
`install/ai_agents.ai_agent.ai_content_migrate_agent.yml`.

## The model JSON

The unit of work is a **model** array with `content_types[]` (each `type`, `label`, `fields[]` with
`name`/`type`/`xpaths[]`/`cardinality`/`required`), `taxonomies[]` (`vocabulary`, `terms[]`) and
`media_bundles[]` (`bundle`, `items[]` with `url`/`alt`). Loose LLM JSON is repaired by `fixJson()` /
`decodeModelPayload()` / `removeOuterBracketsAndEnsureClosingBrace()`. The chosen model is persisted
in **state** keys (`ai_content_migrate.last_model`, `.last_model_sitemap`, `.html_page`, `.pages`,
`.dry_run`, `.saved_import_ids`), reset by the reset controller.

## Applying a model

`importFromJson($data)` creates, when missing: vocabularies + terms; media types; node types; fields
(`FieldStorageConfig`/`FieldConfig` — image/file field types are remapped to `entity_reference` →
media, and any `field_name` containing `tags` is forced to a `taxonomy_term` reference); and form/view
display components via a `widgetByType`/`formatterByType` map. All writes are skipped when dry-run is on.

`importContent($html, $model)` (private; mirrors the `Importer` service, see
[../api/importer.md](../api/importer.md)) builds one node per content type: downloads media URLs into
files/Media, creates term references, and fills scalar fields from the first matching XPath
(`title` special-cased). `retrieveContentHtml($url)` renders a page with **headless Chromium** via
`HeadlessChromium\BrowserFactory` (binary path from `getenv('CHROME_PATH')`, default
`/usr/bin/chromium`), navigates to the URL and reads back `document.documentElement.outerHTML`.

## Sitemap discovery

`discoverSitemap($sitemap)` fetches a sitemap URL (or accepts inline text), parses XML
(`urlset`/`sitemapindex`, recurses one level) or plain-text URL lists, caps at **200 URLs**, then for
each URL renders the page, scores existing/recent models by XPath match count (threshold 3), asks the
`modelProposal` sub-agent when no model fits, and creates one `ai_model` + one `ai_import` per URL,
remembering import ids in state.

## Queueing / grouping

`createQueue()` groups remembered `ai_import` entities (or, legacy fallback, the discovered pages)
into a single `ai_migration` entity. The actual background execution is the
`ai_content_migrate.import_content` queue worker + the enqueue admin form
([../config/entities-routes.md](../config/entities-routes.md)).
