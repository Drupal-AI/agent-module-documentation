<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Usage Explorer (entity_usage_explorer) — agent index

Shows **where a content entity is referenced** across the site. Version **1.3.0**. Package
*Tools*. Core `^10 || ^11`. License GPL-2.0-or-later. **Depends on Drupal core only** (Views
integration is core Views; Paragraphs support is optional and auto-detected).

## What it provides

- **Overview page** — route `entity_usage_explorer.usage_page`,
  `GET /admin/usage/{entity_type}/{entity_id}`, permission **`access entity usage dashboard`**.
  Controller `UsageOverviewController` renders `#theme => 'entity_usage_overview'`
  (template `templates/entity-usage-overview-page.html.twig`).
- **Permission** — `access entity usage dashboard` (`entity_usage_explorer.permissions.yml`).
- **Views field plugin** — `BaseEntityUsageField` (`@ViewsField("base_entity_usage_views_field")`),
  registered via `hook_views_data()`; renders the usage **count** as plain text or a link.
- **Operations link** — `hook_entity_operation()` adds a "Usage" action to every
  `ContentEntityInterface` row for users with the permission.
- **Service** — `entity_usage_explorer.usage` (`UsageService`): reference discovery and counting.
- **Twig extension** — `entity_usage_explorer.twig.UsageHelper` (`UsageHelper`): six Twig
  functions used by the overview template.

No config objects, no config schema, no Drush commands, no submodules, no install hooks.

## Solution docs

- **Overview page, service, and the reference-discovery mechanism** →
  [api/usage-service.md](api/usage-service.md)
- **The `Base Entity Usage` Views field + the operations link** →
  [fields/views-field.md](fields/views-field.md)
