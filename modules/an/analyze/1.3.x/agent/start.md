<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Analyze (analyze) — agent index

Adds an **"Analyze" tab to entities** (any entity type with a `canonical` link template) and a
**plugin API** (`@Analyze` plugin type) for putting information on it. Version **1.3.0** (`1.3.x`),
core **`^10.3 | ^11`** (single pipe — not valid Composer OR syntax, worth verifying).
Submodules: `analyze_basic_content_info`, `analyze_page_views` (Node Statistics),
`analyze_google_analytics`, `analyze_plugin_example` (documents the API).

**What it is.** A shared per-entity tab plus a plugin API so per-entity information (views,
readability, alt-text coverage, SEO, last-reviewed, inbound links) becomes **a plugin rather than an
interface decision**, and the editor learns **one place to look**. Summaries are restricted to a
gauge or a 3-row table; full reports (secondary tabs) are unrestricted.

**New in 1.3.0 (vs the 1.2.x docs):** centralized **batch** pipeline, **Drush** commands, AI **skill
files**, **per-bundle analyzer settings**, a **Content Intel** plugin, and an `analyze_select` Views
filter. See the solution docs.

**Two design cautions:** (1) the tab is per entity and the data usually is not free — a plugin
fetching analytics makes an external request on an admin page load, so caching and a failure path
belong **in the plugin**; (2) an Analyze tab is for **information, not controls**.

## Solution docs
- **Plugins** — the `@Analyze` plugin type, interface/base class, summary render rules, and making a
  plugin batch-capable: [plugins/analyze-plugins.md](plugins/analyze-plugins.md)
- **Configure** — settings form, routes, config objects, enabling per entity/bundle, permissions:
  [configure/settings.md](configure/settings.md)
- **Drush** — `analyze:batch` and `analyze:setup-ai`: [drush/commands.md](drush/commands.md)
- **API** — helper/batch services, plugin manager, Content Intel & Views filter integrations:
  [api/services.md](api/services.md)
