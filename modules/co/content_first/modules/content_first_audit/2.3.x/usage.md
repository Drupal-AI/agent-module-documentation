Content First Audit analyses the rendered content of nodes for heading-structure, image-alt and metatag problems, stores the results, and reports them in a Views table and on the status page.

---

The submodule registers an Entity Registry consumer (`ContentAuditConsumer`) that, whenever a tracked node is created/updated (processed via the Entity Registry queue/cron), renders the node translation through the Content First builder, extracts headings via XPath, runs every `ContentAuditCheck` plugin, and (with Metatag) checks metatag presence/length. Results are upserted one row per entity+language into the `content_first_audit` table: `h1_count`, `hierarchy` valid flag, per-check violation counts (`empty_block_count`, `missing_alt_count`, `empty_alt_count`, `invalid_heading_count`), and metatag length/presence columns. It defines its own attribute-based plugin type, `ContentAuditCheck` (manager `content_first_audit.check_manager`, alter `content_first_audit_check_info`), with four shipped checks (empty block tags, missing alt attribute, empty non-decorative alt, invalid heading content). A Views-based report at `/admin/reports/content-first-audit` (permission `administer content_first`) lists audited content with issue columns coloured via a preprocess hook, a per-node audit overview at `/node/{node}/content-first/audit`, and a status-report summary via `hook_requirements()`. Which node bundles are tracked is chosen at `/admin/config/content/content-first-audit/settings` (`administer site configuration`); changing it queues a batch that clears stale data and re-tracks matching content. Reports and settings are all behind admin-only permissions.

---

- Find nodes that have no H1 heading.
- Find nodes with multiple H1 headings.
- Detect broken heading hierarchies (e.g. H2 followed by H4).
- Detect headings with invalid block content or no readable text.
- Find images missing an `alt` attribute entirely.
- Find images with empty `alt` not marked decorative (no `role=presentation`/`aria-hidden`).
- Detect empty block-level tags left in content.
- Audit metatag presence: title, description, og:title, og:description, og:image, og:url, og:type, og:site_name.
- Audit metatag length against recommended limits (title/description/og:title/og:description).
- Review all audited content in a filterable Views table at `/admin/reports/content-first-audit`.
- See a per-node audit overview with the offending markup snippets.
- Get a heading/metatag issue summary on the Drupal status report page.
- Restrict auditing to specific node bundles.
- Re-track and re-audit all content after changing the tracked bundles.
- Add a custom content check by implementing a `ContentAuditCheck` plugin.
- Alter registered checks via `hook_content_first_audit_check_info_alter()`.
- Drive an accessibility remediation backlog from stored audit counts.
- Prioritise SEO metatag fixes from length/missing counts.
- Track audit coverage as content is added (queued via Entity Registry/cron).
- Clear all stored audit data via the consumer's clear action.
- Link each report count straight to the filtered audit table.
