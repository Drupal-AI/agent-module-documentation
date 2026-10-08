<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Content Insights Report Group re-runs the Content Insights Report aggregates and node listing scoped to a single Drupal Group's content, reachable from a per-group Report tab.

---

This submodule of `content_insights_report` reuses the parent's report shape but adds a Group dimension. Its controllers (`ContentInsightsReportGroupController`, `ContentGroupController`) run the same summary, monthly-activity, moderation-state and node-listing queries, except every query inner-joins `group_relationship_field_data` and filters on the current group's id and a `group_node:%` plugin id, so a report only ever counts nodes that are content of that group. Both report routes live under `/group/{group}/reports/...` and share a single custom access callback (`ContentInsightsReportGroupController::access`) that grants access to site admins holding `administer content_insights_report_group settings`, or to group members who also hold `view content_insights_report_group report`. As in the parent module, the underlying node-table queries still apply the viewer's `node access` grants and the listing re-checks `$node->access('view')` per row, and the per-row edit link is gated on the group permission `update any group_node:<bundle> entity`. It has its own settings object (`content_insights_report_group.settings`, same ten keys as the parent) configured at `/admin/config/content/content_insights_report_group/report-settings`. Requires the base module plus `group` and `gnode`.

---

- Produce a content report for one specific Group.
- Give a group's members insight into only their own group's content.
- Break down a group's nodes by content type with percentages.
- See a group's published vs unpublished counts per type.
- Track monthly created/updated/revision activity within a group.
- Review moderation-state counts for a group's content.
- Browse a paged, filterable list of a single group's nodes.
- Filter that list by creation, update or revision date range.
- Filter by title, content type, status or moderation state.
- Reach the report from the group's own Report tab.
- Restrict report access to group members with the view permission.
- Let module administrators view any group's report.
- Edit a listed node inline when you hold the group edit permission.
- Configure the group report separately from the site-wide report.
- Choose how many months of group activity the report covers.
- Compare content activity across different groups.
- Audit a group's content before archiving or restructuring it.
- Support multi-team or multi-department sites where each group owns its content.
