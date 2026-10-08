<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Content Migrate (ai_content_migrate) — agent index

AI-agent-driven migration of legacy HTML into Drupal **nodes** and **media**. An LLM proposes a
content model (content types, fields, taxonomies, media bundles) with **XPath** field mappings from
a sample page; on approval the module builds the bundles/fields and imports the scraped content.
Version **1.0.0**, package `Custom`, core `^10.3 || ^11`, PHP `>=8.1`, license GPL-2.0-or-later.

- **Dependencies:** core `node`, core `media`, contrib **`ai_agents`** (`^1.2`, pulls in `drupal/ai`).
  Uses `chrome-php/chrome` (require-dev) + a system `chromium` binary for headless page rendering.
  No provider API keys handled directly — all model calls go through `ai_agents` sub-agents.

## What it provides

- **AI agent plugin** `ai_content_migrate_agent` — `src/Plugin/AiAgent/AiContentMigrate.php`
  (extends `AiAgentBase`). Router → model proposal → schema apply → single-page import or queue.
  Details: [plugins/ai_agent.md](plugins/ai_agent.md).
- **Importer service** `ai_content_migrate.importer` (`src/Importer.php`) — turns HTML + a JSON model
  into a node, downloading media and creating terms. Details: [api/importer.md](api/importer.md).
- **Queue worker** `ai_content_migrate.import_content` (`src/Plugin/QueueWorker/ImportContentQueue.php`)
  — cron worker that fetches a URL's HTML and calls the Importer. See [api/importer.md](api/importer.md).
- **Content entities** `ai_model`, `ai_import`, `ai_migration` (`src/Entity/*`) with admin CRUD, plus
  two forms and a reset controller. Details: [config/entities-routes.md](config/entities-routes.md).
- **Migrate process plugins** (for the generated `migrate_plus` migrations): `download_or_skip`,
  `get_full_path`, `empty_coalesce` (`src/Plugin/migrate/process/*`). See [api/importer.md](api/importer.md).

## Routes & access

All routes and all three entities are gated by the single permission **`administer ai content
migrate`** (`ai_content_migrate.permissions.yml`). Routes (`ai_content_migrate.routing.yml`):
`/admin/content/ai-import/enqueue` (form), `/admin/content/ai-import/reset` (controller). Entity
collections live under `/admin/content/ai-model`, `/ai-import`, `/ai-migration`. There is no settings
form (`configure` is null); the agent itself is used through the AI Agents Explorer UI.

See [config/entities-routes.md](config/entities-routes.md) for entity fields, forms and the
migrate-export flow.
