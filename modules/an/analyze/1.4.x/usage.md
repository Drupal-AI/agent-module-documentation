<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Analyze adds an "Analyze" tab to every content entity that has a canonical URL and provides an "Analyze" plugin type so modules can put per-entity insights (summaries and full reports) on that tab.

---

Analyze is a small framework, not an analytics tool in itself. It defines the `Analyze` plugin type (`Plugin/Analyze`), a plugin manager, an `AnalyzePluginBase` base class and an `AnalyzeInterface`, plus the machinery that surfaces the results: a route subscriber that dynamically creates `entity.<type>.analyze` and per-plugin `analyze.<type>.<plugin>` routes for every entity type with a `canonical` link template, an `AnalyzeController` that renders the enabled plugins' summaries (gauge or table) and full reports, a `_analyze_access` access check, an "Analyze" local task with a "Summary" plus one secondary tab per plugin, and a per-content-type settings UI (a global form at `/admin/config/content/analyze-settings` and an "Analyze settings" section injected into each bundle edit form). Analyzer plugins ship in submodules: Basic Content Info (word/image counts), Node Views (core statistics), Google Analytics (GA data per URL) and an example plugin that documents the API. Editors enable analyzers per entity type/bundle; each enabled analyzer renders a summary on the tab with an optional link to a full report. A `drush analyze:batch` command runs analyzers across many entities, and `drush analyze:setup-ai` installs an Agent Skills file so AI assistants can trigger analysis in natural language. Configuration lives in `analyze.settings` (which analyzers are on, per type/bundle), `analyze.plugin_settings` and `analyze.entity_settings`.

---

- Give content editors a single "Analyze" tab on nodes, users, taxonomy terms, media and any other canonical entity instead of scattered per-module blocks.
- Show word count and image count for a piece of content (via the Basic Content Info submodule).
- Surface Google Analytics page views, views-per-user and bounce rate for the entity's own URL (via the Google Analytics submodule).
- Display core statistics "total/today views" per node (via the Node Views submodule).
- Build a custom analyzer (SEO score, readability, link health, alt-text coverage, last-reviewed date) by writing one `Plugin/Analyze` plugin.
- Render a spectrum score as a linear or circular gauge using the `analyze_gauge` / `analyze_circular_gauge` theme hooks.
- Render key/value metrics as a two-column table using the `analyze_table` theme hook.
- Provide a deeper "full report" page per analyzer, linked from the summary tab.
- Enable or disable each analyzer independently per entity type and per bundle from the bundle edit form's "Analyze settings" section.
- Manage all analyzer toggles centrally at Configuration > Content > Content Analysis (`administer analyze`).
- Restrict who can read the Analyze tab with the `view analyze reports` permission.
- Restrict who can change analyzer configuration with the `administer analyze` permission.
- Run analyzers in bulk across a whole content type using the Batch Analysis form or `drush analyze:batch`.
- Filter a batch run by analyzer, entity type and entity count.
- Let AI coding assistants (Claude Code, Codex, Gemini CLI, Copilot, Cursor) run analysis in natural language after `drush analyze:setup-ai`.
- Alter the list of available analyzers with `hook_analyze_info_alter()`.
- Make an analyzer applicable only to certain entity types/bundles by overriding `isApplicable()`.
- Add per-analyzer access control by overriding `access()` (e.g. tie it to another module's permission).
- Expose extra summary links from an analyzer (e.g. a link to a sitewide report) via `extraSummaryLinks()`.
- Point a full report at an external/overridden URL, or suppress the full-report link entirely, via `getFullReportUrl()`.
- Add configurable per-analyzer settings (rendered on the bundle form) via `getConfigurableSettings()`.
- Ship analysis as part of a distribution (Analyze is included in DXPR CMS) so editors get content insights out of the box.
