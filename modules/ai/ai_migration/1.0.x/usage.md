<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Migration fetches web pages and uses an AI provider to extract their content into structured Drupal entities, driven by a JSON schema generated from your target content type.

---

AI Migration adds an `ai` data parser to Migrate Plus so a standard `url` migration can turn web pages into structured Drupal content instead of dumping raw HTML into a body field ("fill the fields, not bloat the body"). For each source URL the parser fetches the HTML, optionally cleans and shrinks it with the document_loader_html_processor (Symfony HtmlSanitizer, CSS-container extraction, regex stripping, whitespace minifying), builds a JSON schema for the destination entity type and bundle via the Schemata module, and asks the configured AI chat provider to return a JSON:API-shaped object matching that schema. Ordinary Migrate process plugins then map the returned attributes and relationships onto node/media/taxonomy fields. Prompts are configurable per migration (system/user roles, with append/prepend/replace operations) and default to a built-in web-content-extractor prompt. AI responses are cached in a dedicated `ai_migration` cache bin keyed by prompt+provider+model so identical queries do not incur repeat provider costs. The bundled `ai_migration_example` submodule ships runnable sample migrations (simple blog posts, and a complex book example with media and taxonomy). It requires the AI module, Migrate/Migrate Plus, Schemata and document_loader_html_processor, and supports Drupal 10 and 11.

---

- Convert web pages into structured Drupal nodes rather than raw-HTML body dumps.
- Add an `ai` data parser to any Migrate Plus `url` source migration.
- Populate typed fields (title, author, dates, descriptions) from unstructured page content.
- Generate the extraction JSON schema automatically from the destination content type via Schemata.
- Use AI structured-output mode (JSON schema enforced) or plain chat with a schema-in-prompt.
- Extract relationships — taxonomy terms and media/image references — alongside scalar fields.
- Import book/media examples that pull cover images into media entities (complex example migration).
- Clean and shrink source HTML before the AI call using CSS container selectors (`container`).
- Strip unwanted markup with `strip_regex` and drop attributes via the Symfony sanitizer.
- Cut token cost with `minify: true` and `head_filter: true` on the html_processor.
- Customize the system and user prompts per migration with append/prepend/replace operations.
- Fall back to the built-in web-content-extractor prompt when no prompt is configured.
- Cache AI responses per prompt+provider+model to avoid paying twice for the same page.
- Choose provider, model, temperature and max tokens per migration via the `ai.model` config block.
- Migrate slices of a legacy site page-by-page to support phased migrations.
- Run migrations with drush (migrate_tools) or the Migrate Plus UI.
- Select a specific sub-object of the AI result with `item_selector` (e.g. a media relationship).
- Reuse the site's existing AI provider configuration from `/admin/config/ai`.
- Start from the example submodule's `simple_content_migration.yml` as a template for your own.
- Support both Drupal 10 and Drupal 11 sites.
