<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Word Monitor lets you maintain a list of words or expressions that should not appear in your content and be warned when any of them show up on your site.
---
Sites accumulate outdated names, deprecated terminology, or forbidden phrases across many entities, and there is no easy way to be alerted when they resurface. Word Monitor solves this with a small pluggable core: you enter a list of banned words at `/admin/content/words` (form `AdminForm`, gated by `administer site configuration`), and the `word_monitor` service — backed by a `WordMonitorPluginManager`/`WordMonitorPluginCollection` — asks each enabled monitor plugin which entities currently contain those words. The base module (`WordMonitor`, working over `@state`) provides the framework and admin list; the actual detection lives in submodules so you enable only what you need.

Two submodules ship with it: `word_monitor_search` integrates with **core Search** to find entities containing the banned words (so the site must be fully indexed at `/admin/config/search/pages` for results to appear), and `word_monitor_status_warning` surfaces a warning on `/admin/reports/status` whenever any banned word is present. The module is entirely local — all analysis runs against your own indexed content and there are **no external HTTP calls, credentials, API keys, or outbound requests** anywhere in the codebase. Its only route is the admin word-list form (permission-gated), and it is extensible: developers can add their own `@WordMonitorPluginAnnotation` plugins (see the `word_monitor_search` submodule as a template) to monitor other data sources. Security posture is minimal and clean — an admin-permission-gated settings form plus read-only content scanning.
---
- Define a list of banned words or expressions to watch for
- Get warned when an outdated brand/product name reappears on the site
- View the entities that currently contain a banned word at `/admin/content/words`
- Add a warning to `/admin/reports/status` when banned words are present (status-warning submodule)
- Use core Search to locate entities containing monitored words (search submodule)
- Enable only the base module for framework-only, behind-the-scenes functionality
- Restrict word-list configuration to `administer site configuration` holders
- Periodically audit content for forbidden terminology
- Catch deprecated legal/compliance phrasing across content
- Ensure the site is fully indexed so monitoring returns results
- Extend detection by writing a custom `WordMonitorPlugin`
- Model a new data source to scan by cloning the `word_monitor_search` submodule
- Combine the search and status-warning submodules for both listing and alerting
- Keep monitoring fully local with no external services or API keys
- Access the monitor service programmatically via the `word_monitor()` helper
- Track when a discouraged term is introduced during editorial review
- Report banned-word presence as part of a site health check
