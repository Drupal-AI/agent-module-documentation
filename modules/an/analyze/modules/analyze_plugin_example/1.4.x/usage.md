<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Analyze Plugin Example is a developer-reference submodule of Analyze: a worked, copy-paste Analyze plugin showing how to build your own, not meant for production.

---

This submodule ships one example `Plugin/Analyze` plugin, `Example` (id `example`, label "Example Entity Reports"), in `src/Plugin/Analyze/Example.php`, extending `Drupal\analyze\AnalyzePluginBase`. Its README says it "should not be installed on a live site, but used as a reference for creating your own module to provide an Analyze plugin." The class is a template that exercises the full Analyze plugin API: `renderSummary()` returns an `analyze_table` with three example rows (the base module renders a summary page for every entity with a canonical URL); `renderFullReport()` returns an `analyze_gauge` render element (shown on the plugin's auto-generated full-report page); `isApplicable()` scopes the plugin to `article` nodes; `access()` gates it on `access content`; and `extraSummaryLinks()` adds a "Global Report" link to an external URL. It defines no routes, services, permissions or configuration of its own and depends only on `analyze`. Use it as the starting point when writing a real analyzer — copy the class, rename the namespace/id/label, and replace the placeholder data with your own logic.

---

- Learn the Analyze plugin API from one small, complete, commented example.
- Copy `Example.php` as the skeleton for a new custom Analyze plugin.
- See the exact `@Analyze(id, label, description)` annotation an analyzer needs.
- See how `renderSummary()` returns an `analyze_table` (max three rows of label/data).
- See how `renderFullReport()` returns an `analyze_gauge` for the full-report page.
- Learn that the base module auto-creates a summary page for any entity with a canonical URL.
- Learn that a full-report URL is auto-generated for every enabled plugin that does not override `getFullReportUrl()`.
- Copy the `isApplicable($entity_type, $bundle)` pattern to scope a plugin to a bundle (here: `article`).
- Copy the `access()` pattern to gate an analyzer on a permission.
- Copy the `extraSummaryLinks()` pattern to add custom links to the summary.
- Understand which methods to override vs. inherit from `AnalyzePluginBase`.
- Demonstrate the Analyze tab on a dev/training site using article nodes.
- Reference the render arrays (`analyze_table`, `analyze_gauge`) that the Analyze theme provides.
- Scaffold a module quickly by pairing this class with your own `.info.yml`.
- Teach new contributors how Analyze summary vs. full-report rendering differ.
