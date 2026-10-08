<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Analyze adds an "Analyze" tab to entities and a plugin API for putting information on it, plus (new in 1.3.0) a centralized batch system, Drush commands and per-bundle settings — with submodules supplying content statistics, page views and Google Analytics data.

---

The problem it solves is where per-entity information goes. An editor looking at an article may want to know how many times it has been viewed, how readable it is, whether its images have alt text, how it performs in search, when it was last reviewed, or how many internal links point at it — and each of those currently arrives as a separate module adding a separate block, a separate tab, or a column in a listing somewhere else. A shared tab with a plugin API means each of those is an `@Analyze` plugin rather than an interface decision, and the editor learns one place to look. **Version 1.3.0** (branch `1.3.x`) on core **`^10.3 | ^11`** — note the single pipe, which is not valid Composer OR syntax and is worth checking behaves as intended. 1.3.0 is a substantial minor over 1.2.x: it adds a **centralized batch pipeline** (`BatchableAnalyzerInterface` + `AnalyzeBatchService`, a `/admin/config/content/analyze-batch` form, and the `analyze:batch` Drush command with exponential backoff on AI rate limits), **AI skill files** installable via `analyze:setup-ai`, **per-entity-type/bundle analyzer settings** injected into bundle edit forms, a **Content Intel** integration plugin, and a `analyze_select` Views filter. Two things still worth attaching. **The tab is per entity and the data usually is not free**: a plugin fetching analytics for the entity being viewed makes an external request on an administrative page load, so caching and a failure path belong in the plugin rather than being assumed. And **an Analyze tab is a good place for information and a poor place for a control** — its value is that an editor can look without changing anything, so a plugin that offers actions is competing with the entity's own operations rather than complementing them.

---

- Show page views on an article's tab.
- Display content statistics per entity.
- Show Google Analytics data for a node.
- Add a readability score to the Analyze tab.
- Give editors per-entity insights.
- Show internal link counts for a page.
- Add SEO information to an entity.
- Display last-reviewed information.
- Build a custom analysis plugin.
- Batch-analyze all articles from the CLI with `drush analyze:batch`.
- Check analysis coverage per bundle with `drush analyze:batch --status`.
- Force re-analysis of the first N entities with `--limit` and `--force`.
- Make an analyzer batch-capable via `BatchableAnalyzerInterface`.
- Enable analyzers per entity type and bundle from the settings form or bundle edit form.
- Install AI coding-assistant skill files with `drush analyze:setup-ai`.
- Expose analyzer summaries to the Content Intel framework.
- Show accessibility findings per node.
- Add word count to an entity's tab.
- Show engagement data to editors.
- Provide one place for entity information.
- Add a content audit plugin.
- Show media usage for a node.
- Display translation status per entity.
- Add a custom metric to the Analyze tab.
- Give editors context before editing.
