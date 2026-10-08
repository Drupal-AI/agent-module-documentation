<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Content Type Audit (content_type_audit) — agent index

Adds one admin **report** listing the node count per content type, with published-status and
created-date filters. Version dir `2.0.x` (installed 2.0.1). Core `^8 || ^9 || ^10 || ^11`.
No module dependencies, no composer requirements.

## What it provides
- **Route** `content_type_audit.content_report` — path `/admin/reports/content-type`, renders the
  form `\Drupal\content_type_audit\Form\ContentReport`, permission `administer content types`.
- **Menu link** under Reports (`system.admin_reports`), from `content_type_audit.links.menu.yml`.
- **Library** `content_type_audit/content_type_audit.content_report` — table CSS only
  (`css/content_audit.css`); attached by the form.
- No permissions.yml, services, plugins, config entities/schema, hooks, or Drush commands.

## How it works
`ContentReport` (a `FormBase`) builds a status `select` (any/published/unpublished) plus optional
start/end `date` fields; **Apply Filters** is an AJAX submit whose callback `updateTable()` re-renders
`getTable()`. `getTable()` runs one aggregate query on `node_field_data`
(`COUNT(DISTINCT nid)` grouped by `type`, optional status + created-range conditions) and emits an HTML
table of every content type label, its count, a grand total, and (when no date range) a
"View All Pages" link to `/admin/content`. Unused types show 0.

## Solution docs
- Audit form, route, filters and query: [`agent/config/audit.md`](config/audit.md)
