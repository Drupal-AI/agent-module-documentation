AI Content Migrate is an AI-assisted migration toolkit that ingests legacy content from three kinds of source — a single HTML page, a whole site via its sitemap, or an exported application database dump (Confluence, BookStack, …) — proposes a Drupal content model (content types, fields, taxonomies, media, Canvas templates) with XPath/field mappings, and generates runnable `migrate_plus` migrations that import the content into nodes, media and custom records.

---

Version 1.1.0 is a large expansion of the 1.0 "single agent" module into three distinct migration flows that share one content-model/XPath representation and one `migrate_plus` generator. (1) The **legacy HTML/agent flow** keeps the `ai_content_migrate_agent` (`ai_agents` plugin) driven from the AI Agents Explorer plus the `Importer` service, `ai_model`/`ai_import`/`ai_migration` entities and the enqueue/reset admin pages. (2) A new **sitemap flow** (`/admin/content/ai-drupalcms-cm/import`, `SitemapImportForm`) parses a sitemap (XML/`sitemapindex`/TXT, capped at 200 URLs), renders each page with headless Chromium (`HtmlFetcher`), asks the `ai_content_migrate_content_model_agent` to propose a model per distinct template, groups pages by XPath similarity into `content_model` + `sitemap_analysis` entities, offers a Kanban board to re-assign pages, then generates migrations/Canvas templates. (3) A new **database flow** (`DatabaseMigrationWizardForm`, under `administer site configuration`) uploads a SQL dump + attachments; a `database_source_profile` plugin (shipped: Atlassian Confluence) recognizes the schema from its table names and maps it deterministically, or — when no profile matches — the `SchemaProfiler` describes the dump locally and the AI drafts a *declarative* YAML source profile (saved as the `aicm_source_profile` config entity) that `ProfileVerifier` checks against the whole dump before approval. A stated privacy boundary is that dump rows are never sent to the AI: only schema metadata, value *shapes*, and short code-column values (`SchemaProfiler::anonymizeRows()`); there is a `PrivacyBoundaryTest`. The module also adds the `ai_content_xpaths_map`/`ai_content_xpaths_map_item` config-bridge entities (with an inline XPath tester endpoint), reusable migrate source (`ai_content_migrate_dataset`, `HtmlImages`) and process plugins (`dom`, `get_full_path`, `download_or_skip`, `empty_coalesce`, `ai_content_migrate_local_file`, `flatten_extract`, `media_lookup_all`), SDC components and a wiki breadcrumb/theme. It depends on core `node`/`media`/`migrate`, plus `ai`, `ai_agents`, `migrate_plus` and `inline_entity_form`; headless Chromium (`chrome-php/chrome`, require-dev, `CHROME_PATH` or `/usr/bin/chromium`) is needed for page rendering.

---

- Migrate a legacy static/HTML site into Drupal nodes and media without writing custom migration code.
- Point the tool at a `sitemap.xml` and have it analyze every page (up to 200) and propose content models.
- Recurse a `sitemapindex`, a plain-text URL list, or a multilingual sitemap (hreflang alternates reused across translations).
- Let an LLM propose content types, fields and XPath field mappings from a representative legacy page.
- Group many pages that share a template into one reusable `content_model`, minimizing AI calls.
- Re-assign pages between proposed content types on a drag-and-drop Kanban board before generating migrations.
- Render JavaScript-heavy / decoupled (Next.js, React, Vue) pages with headless Chromium before scraping, waiting for network idle.
- Test an XPath expression live against a fetched page from the XPath-map entity form.
- Build `ai_content_xpaths_map` entities that bridge source extraction (URL + XPath items) to a `migrate_plus` migration target.
- Migrate an Atlassian Confluence (Server/Data Center) export: spaces and pages become wiki nodes with page tree, labels, attachments, authors and 301 redirects.
- Convert Confluence storage-format bodies (panels, code, expand, status, layouts, tasks) into HTML with the `wiki_html` text format.
- Generate a Canvas (Experience Builder) template per migrated content type, with breadcrumb, byline, labels, body, attachments and child-page views blocks.
- Migrate an arbitrary application database no profile knows by having the AI draft a declarative YAML source profile from local schema metadata only.
- Keep dump data out of the AI: send only schema shapes, relations and short code-column values (anonymized sampling).
- Verify a drafted source profile against the full dump (importing nothing) and review a page-tree preview before approving it.
- Save an approved source profile as the `aicm_source_profile` config entity and export it to recognize that application on every future dump with no AI call.
- Run or roll back generated database migrations from the review page via Batch API (25 rows/request) or `drush migrate:import --group=ai_content_migrate_database`.
- Import a single legacy URL into one node through the `ai_content_migrate_agent`, previewing the model first.
- Download remote images referenced in a page into managed files and Media entities during import.
- Create Drupal content types, fields, vocabularies/terms and media bundles automatically from an approved model.
- Run a dry run to validate the model and mappings before creating any content (agent flow).
- Enqueue imports for background (cron queue) processing via the `ai_content_migrate.import_content` queue worker.
- Export a migration as downloadable `migrate_plus` YAML + CSV (a ZIP) for review or manual `drush migrate:import`.
- Reuse the module's custom migrate process plugins (`download_or_skip`, `get_full_path`, `empty_coalesce`, `ai_content_migrate_local_file`) in hand-written migrations.
- Add support for a new wiki-like application by subclassing `WikiSourceProfileBase`, or a new markup format by adding a `BodyConverter`.
- Manage AI Models, Imports, Migrations, Content Models, Sitemap/Database Analyses and Migrated Records from admin collection pages.
- Stand up a proof-of-concept migration quickly for content editors to review before committing to a full build.
