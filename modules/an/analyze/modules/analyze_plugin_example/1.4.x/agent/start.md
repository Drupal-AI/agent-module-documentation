<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Analyze Plugin Example (analyze_plugin_example) — agent index

A **developer-reference** submodule of **Analyze**: a worked, copy-paste example Analyze plugin,
`Example` (id **`example`**, label *"Example Entity Reports"*). Its `README.md` says it should
**not** be installed on a live site — use it as a template for writing your own analyzer.
Depends only on `analyze`. Package `Example`. Core `^10.3 || ^11`. GPL-2.0-or-later. Version 1.4.x.

- **The example plugin, method by method, as a copy-paste starting point** →
  [plugins/example-plugin.md](plugins/example-plugin.md)

## What it actually is

- `src/Plugin/Analyze/Example.php` — `final class Example extends AnalyzePluginBase`
  (`Drupal\analyze\AnalyzePluginBase`). Annotation `@Analyze(id = "example",
  label = @Translation("Example Entity Reports"), description = ...)`. The doc-block notes the base
  module auto-creates a summary page for every entity with a canonical URL, plus a full-report URL
  for every enabled plugin that does not override `getFullReportUrl()`.
- Overrides five methods as a template:
  - `renderSummary()` → an `analyze_table` with three placeholder rows (the summary is capped at
    three pieces of info; larger data belongs in the full report).
  - `renderFullReport()` → an `analyze_gauge` render element (example gauge 0..1, value 0.5).
  - `isApplicable('node', 'article')` → TRUE only for the `article` bundle.
  - `access()` → `hasPermission('access content')`.
  - `extraSummaryLinks()` → one "Global Report" link to `https://example.com/global-report`.
- No `*.routing.yml`, `*.services.yml`, `*.permissions.yml`, `*.install`, `config/**`. `README.md`
  documents its "do not install" intent (note: the `.info.yml` sets `hidden: false`, so it is
  **not** actually hidden from the module list despite the README's wording).
- Provides no data of its own; all rows/values are hard-coded placeholders to be replaced.
