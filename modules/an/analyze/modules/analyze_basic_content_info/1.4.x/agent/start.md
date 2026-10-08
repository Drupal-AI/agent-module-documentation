<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Analyze Basic Content Info (analyze_basic_content_info) — agent index

A submodule of **Analyze** that ships **one** `Plugin/Analyze` plugin: `ContentInfo`
(id **`content_info`**). It renders a "Basic Info" summary table with **Word count** and
**Image count** on an entity's Analyze tab. No routes, permissions, services or config of its own.
Depends on `analyze`. Package `Analyze`. Core `^10.3 || ^11`. GPL-2.0-or-later. Version 1.4.x.

- **The plugin, how it counts, and how to enable it** → [plugins/content-info.md](plugins/content-info.md)

## What it actually is

- `src/Plugin/Analyze/ContentInfo.php` — `final class ContentInfo extends AnalyzePluginBase`.
  Annotation `@Analyze(id = "content_info", label = @Translation("Basic Content Info"),
  description = ...)`.
- Injects (beyond the base's helper/current_user/config.factory): `entity_type.manager`,
  `renderer`, `language_manager`.
- `renderSummary()` returns `['#theme' => 'analyze_table', '#table_title' => 'Basic Info',
  '#rows' => [Word count, Image count]]`.
- `getFullReportUrl()` returns `NULL` → summary-only, no full-report tab/link.
- Everything else (tab, route, access, per-bundle toggle) comes from the parent Analyze module.
