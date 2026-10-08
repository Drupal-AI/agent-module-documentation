<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Content Type Audit adds an admin report showing the number of nodes for each content type on the site.

---

Content Type Audit provides a single admin report (at `/admin/reports/content-type`, route `content_type_audit.content_report`, under Reports) that lists every node content type with a count of its nodes and a grand total. The report is an AJAX form: you choose a published status — Any, Published, or Unpublished — and optionally a created-date range (start and end date), then click **Apply Filters** to refresh the table without a page reload. Content types with no matching nodes are still listed with a count of 0, which makes unused types easy to spot for cleanup or migration planning. When no date range is set, each row with a non-zero count also gets a "View All Pages" link into the core content overview (`/admin/content`), pre-filtered by that content type and the chosen status. Counting is done with a single aggregate `COUNT(DISTINCT nid)` query grouped by node type against the `node_field_data` table. The whole feature is one class, `Drupal\content_type_audit\Form\ContentReport`, and it is gated by the core `administer content types` permission. There are no extra permissions, services, plugins, config entities, or Drush commands — the only shipped asset besides the form is a small CSS file for table styling.

---

- See how many nodes exist for each content type on the site.
- Get a grand total node count across all content types.
- Identify unused content types (count of 0) as candidates for removal.
- Plan a content cleanup by spotting low-usage types.
- Scope a content migration by understanding per-type content volume.
- Filter the counts to only Published nodes.
- Filter the counts to only Unpublished nodes.
- Filter the counts to any published status.
- Count only nodes created within a specific date range (start/end date).
- Audit how much draft/unpublished content is sitting in each type.
- Jump from a content type row to its filtered core content overview via "View All Pages".
- Open the filtered content list in a new tab to review actual nodes.
- Refresh the report in place with AJAX after changing filters.
- Provide site owners a quick content-distribution snapshot without SQL.
- Support content audits during a site redesign or IA review.
- Confirm a content type is safe to delete because it has zero nodes.
- Report content growth over a period using the created-date filter.
- Give editors/admins a one-screen overview of content composition.
- Verify migration results by checking per-type counts after an import.
- Reach the report from the admin Reports menu (Reports -> Content Type Audit).
