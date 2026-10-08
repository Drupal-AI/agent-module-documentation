<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Content Insights Report adds two admin pages that summarise a site's node content by type, status, monthly activity and moderation state, plus a filterable content listing.

---

The module reads directly from the node tables (`node_field_data`, `node_revision`, and, when Content Moderation is on, `content_moderation_state_field_data`) and renders the aggregates through its own themed templates — there is no new entity, field or storage. The **Content Insights Report** page (`/admin/reports/content-insights-report`) shows a per-content-type breakdown with percentages, a month-by-month grid of created/updated/revision counts for a configurable number of months, and (optionally) a workflow moderation-state summary. The **Content Report** page (`/admin/reports/content-insights-report/content`) is a paged, sortable list of individual nodes with date-range filters (creation, update, revision) plus title, content-type, status and moderation-state filters, stored per user in the private tempstore. All queries respect the viewer's `node access` grants and each listed node is re-checked with `$node->access('view')`, so the report only ever aggregates content the viewer is entitled to see. An optional `content_insights_report_group` submodule reproduces both pages scoped to a single Group. Everything is configured from one settings form; the module ships sensible defaults in `config/install`.

---

- Get a per-content-type count and percentage breakdown of all nodes.
- See how many nodes of each type are published vs unpublished.
- Base the percentage on all nodes, only published, or only unpublished nodes.
- Track how many nodes were created each month over the last N months.
- Track how many nodes were updated (changed) each month.
- Track revision volume per content type per month.
- Review a workflow moderation-state summary (draft/published/etc.) per content type.
- Spot content stuck in a particular moderation stage.
- Choose how many months of activity the report covers (default 6).
- Sort the summary by content-type name, machine name, or total percentage.
- Browse a paged list of every node with type, status, dates and revision count.
- Filter that list by creation, update or revision date range.
- Filter the node list by title, content type, status or moderation state.
- Jump straight to a node's edit form from the list (when permitted).
- Show or hide each report section from the settings form.
- Hide empty result sections to keep large reports readable.
- Show a "created by / date" stamp of when the report was run.
- Print a selected report section with the built-in print icon.
- Restrict who can view the report via the dedicated view permission.
- Produce a per-Group version of both reports with the group submodule.
- Give group members insight into only their own group's content.
- Use it as the data source for a content-audit or spring-clean exercise.
- Feed a redesign or migration inventory from the type/activity breakdown.
