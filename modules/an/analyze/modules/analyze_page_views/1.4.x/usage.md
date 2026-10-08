<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Analyze Node Statistics adds one Analyze plugin that shows a node's total page views and today's view count, read from core's Statistics module, on the node's Analyze tab.

---

This submodule of Analyze provides a single `Plugin/Analyze` plugin, `NodeViews` (id `node_views`, label "Node Page Views Reports"). On a node's Analyze tab it renders a two-row "Node views" table: "Total views" and "Today's count". Both numbers come from core's **Statistics** module — the plugin injects the `statistics.storage.node` service (`Drupal\statistics\NodeStatisticsDatabaseStorage`) and calls `fetchView($entity->id())`, which reads the core `node_counter` table; `getTotalCount()` and `getDayCount()` supply the two rows. `isApplicable()` restricts the plugin to `node` entities only (statistics are recorded per node). `getFullReportUrl()` returns `NULL`, so there is no separate full-report page. `access()` requires the Statistics module's `view post access counter` permission (on top of the parent Analyze tab's `view analyze reports`). It defines no routes, services or config of its own; the tab, per-bundle toggle and route access come from the parent Analyze module. Requires `analyze`, `node` and `statistics`, and depends on core Statistics being configured to count content views.

---

- See a node's lifetime total page views without leaving the node.
- See how many times a node has been viewed today.
- Give editors a quick popularity signal on the Analyze tab alongside other analyzers.
- Surface core Statistics `node_counter` data in the Analyze UI instead of the Statistics reports pages.
- Enable page-view reporting per content type/bundle from the bundle edit form's "Analyze settings" section.
- Toggle it centrally at Configuration > Content > Content Analysis.
- Restrict who sees the counts by granting/withholding `view post access counter`.
- Combine view counts with Basic Content Info word/image counts in one Analyze tab.
- Compare relative popularity of articles by opening each node's Analyze tab.
- Confirm core Statistics is actually recording views (a zero total signals it is not counting).
- Provide a node-only analyzer that cleanly no-ops on non-node entity types.
- Use it as a reference for injecting a core service (`statistics.storage.node`) into an Analyze plugin.
- Use it as a reference for gating an analyzer with a module-specific permission via `access()`.
- Show a summary-only analyzer (no full report) driven by an existing core data source.
- Spot content with no engagement (total views of 0) directly from the Analyze tab.
