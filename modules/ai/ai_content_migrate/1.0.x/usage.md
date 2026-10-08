AI Content Migrate is an AI-agent-driven tool that analyzes legacy HTML pages, proposes a Drupal content model (content types, fields, taxonomies, media bundles) with XPath selector mappings, and imports the scraped content into nodes and media.

---

AI Content Migrate ships an `ai_agents` agent plugin (`ai_content_migrate_agent`) that you drive from the AI Agents Explorer like any other agent. You give it one or more source URLs (a single page, a list of pages, or a sitemap); it renders each page with a headless Chromium browser, asks a sub-agent (LLM) to propose a content model with field-to-XPath mappings, and shows you the proposal for approval. On approval it creates the matching node types, fields, vocabularies and media types, then either imports a single page immediately or stores `ai_model` / `ai_import` / `ai_migration` entities and queues the pages for background import. The `Importer` service turns a page's HTML plus a JSON model into a node, downloading referenced images into Media entities and creating taxonomy terms on the fly. An admin form can also export the collected imports as `migrate_plus` YAML + CSV packages (optionally running them immediately). Everything is gated behind the single `administer ai content migrate` permission and is intended for trusted site builders migrating content from sources they control.

---

- Migrate an old static/HTML site into Drupal nodes without writing custom migration code.
- Let an LLM propose a content type and field set by looking at a representative legacy page.
- Auto-generate field-to-XPath mappings (e.g. `title` → `//h1`, `field_image` → `//img[.../@src]`).
- Import a single legacy URL into one node, previewing the model first.
- Bulk-import many pages listed one-per-line or discovered from a `sitemap.xml`.
- Discover URLs from a `sitemapindex` (recurses one level) or a plain-text URL list.
- Render JavaScript-heavy legacy pages with headless Chromium before scraping.
- Reuse a previously approved model across similar pages (XPath match scoring).
- Create Drupal content types and fields automatically from an approved model.
- Create taxonomy vocabularies and terms referenced by the model.
- Create image/media bundles and attach imported files to media entities.
- Download remote images referenced in a page into managed files and Media entities.
- Run a dry run to validate the model and mappings before creating any content.
- Group multiple imports into an `ai_migration` entity for batch processing.
- Enqueue imports for background (cron queue) processing via the `ai_content_migrate.import_content` queue worker.
- Export a migration as downloadable `migrate_plus` YAML + CSV (a ZIP package) for review or manual `drush migrate:import`.
- Optionally execute the generated `migrate_plus` migration immediately from the admin form.
- Map scraped taxonomy labels to term references, creating missing terms automatically.
- Populate a node body/summary from the first non-empty matching selector.
- Reset the agent's remembered state (last model, sitemap models) from the reset route.
- Manage `AI Models`, `AI Imports` and `AI Migrations` from admin collection pages under Content.
- Provide reusable custom migrate process plugins (`download_or_skip`, `get_full_path`, `empty_coalesce`) for the generated migrations.
- Stand up a proof-of-concept migration quickly for content editors to review before a full build.
