<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Content Migrate (ai_content_migrate) — agent index

AI-assisted migration of legacy content into Drupal **nodes, media and custom records**. Three flows
share one content-model/XPath representation and one `migrate_plus` generator: (1) a legacy-HTML
**agent** flow, (2) a **sitemap** flow that analyzes a whole site, and (3) a **database** flow that
maps an exported application dump (Confluence, BookStack, …) via source profiles. Version **1.1.0**,
package `Custom`, core `^10.3 || ^11`, PHP `>=8.1`, license GPL-2.0-or-later.

- **Dependencies:** core `node`, `media`, `migrate`; contrib `ai`, `ai_agents` (`^1.2`),
  `migrate_plus` (`^6.0`), `inline_entity_form` (`^3.0@RC`); `symfony/dom-crawler`. Headless page
  rendering uses `chrome-php/chrome` (require-dev) + a system `chromium` (`CHROME_PATH` or
  `/usr/bin/chromium`). Provider API keys are never handled here — model calls go through `ai`/
  `ai_agents`.

## What it provides (by area)

- **AI agents & AI function calls** — `ai_content_migrate_agent` (legacy HTML) and
  `ai_content_migrate_content_model_agent` (sitemap); function calls `html_from_url`,
  `propose_content_model`, `propose_database_content_model`, `validate_xpaths`. Plus the module's own
  **`database_source_profile`** plugin type (manager + `#[DatabaseSourceProfile]` attribute; ships
  Confluence + a Declarative deriver) and reusable **migrate source/process** plugins. Details:
  [plugins/ai_agents.md](plugins/ai_agents.md).
- **Entities, routes, permissions, forms** — content entities `ai_model`, `ai_import`,
  `ai_migration`, `sitemap_analysis`, `content_model`, `database_migration_analysis`,
  `migrated_record`(+type), `ai_content_xpaths_map`(+item); config entity `aicm_source_profile`;
  the sitemap import wizard, the database migration wizard, the enqueue/reset pages, and a settings
  form. Details: [config/entities-routes.md](config/entities-routes.md).
- **Services** — `Importer`, `ContentMigrator`, `SitemapParser`, `HtmlFetcher`,
  `DatabaseProfileMigrator`, `SchemaProfiler`, `ProfileDrafter`, `ProfileVerifier`,
  `CanvasTemplateGenerator`, `MigrateFileGeneration`. Details: [api/services.md](api/services.md).

## Permissions & gating (from routing.yml / permissions.yml)

- `administer ai content migrate` — legacy agent entities, enqueue/reset, dialog, settings form.
- `administer site configuration` — the whole database flow and the sitemap-analysis/content-model
  admin pages (`/admin/content/ai-drupalcms-cm/…`).
- `administer ai_content_xpaths_map`, `administer ai_content_xpaths_map_item`, `administer migrated
  records` — the XPath-map entities + the test-xpath POST endpoint (all `restrict access: true`).
- `access content` — the sitemap import wizard form (`ai_content_migrate.import`).

See area docs for the per-route table, the model JSON shape, and the database source-profile flow.
