<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Content Type Audit — the audit form

Everything lives in one class: `Drupal\content_type_audit\Form\ContentReport` (extends `FormBase`).
There is no settings/config object, no config schema, and no extra permission.

## Install / enable / reach it
- `drush en content_type_audit -y` (no dependencies beyond core node).
- Go to **Reports → Content Type Audit**, or directly to `/admin/reports/content-type`.
- Route `content_type_audit.content_report` (`*.routing.yml`): `_form` = the class above,
  `_title` = "Content Type Audit", requirement `_permission: 'administer content types'`.
- Menu link `content_type_audit.content_report` (`*.links.menu.yml`) hangs off `system.admin_reports`.
- `info.yml` sets `configure: content_type_audit.content_report`, so the audit doubles as the
  module's "Configure" link.

## The form (`buildForm`)
- `status` — a `select` with options `any` / `published` / `unpublished` (default `any`, read from
  `$form_state->get('status')`).
- `filter_date` container with two `date` fields: `start_date`, `end_date`.
- `submit` "Apply Filters" — an `#ajax` submit; callback `[$this, 'updateTable']`, wrapper `table-div`.
- `table` — `#type => markup`, initial content from `getTable($status, 0, 0)`.
- Attaches library `content_type_audit/content_type_audit.content_report` (table CSS).
- `submitForm()` is a no-op; all refresh happens through the AJAX callback.

## AJAX refresh (`updateTable`)
Reads `status`, `start_date`, `end_date` from form state and validates the date pair:
- only one of start/end set → error markup "Incorrect/Missing Start Date and End Date";
- `start_date > end_date` → error markup "Start date cannot be greater than end date";
- both set → `getTable($status, strtotime($start.' 00:00:00'), strtotime($end.' 23:59:59'))`;
- neither → `getTable($status, 0, 0)`.

## The query and table (`getTable`)
- Uses `Database::getConnection()` (set in the constructor) — `select('node_field_data', 'nfd')`.
- Adds field `nfd.type`, expressions `COUNT(DISTINCT nfd.nid)` and `MIN(nfd.nid)`, `groupBy('nfd.type')`.
- Conditions: `nfd.status = 1` (published) or `= 0` (unpublished) when status ≠ any; created-range
  `nfd.created >= start` / `<= end` when both dates are given. All values pass through the query
  builder's `condition()` (parameterized) — no string-concatenated SQL.
- Content types come from the constructor: `entity_type.manager` → `node_type` storage
  `loadMultiple()`, stored on `$this->contentTypes`. Counts are merged into
  `array_fill_keys(array_keys($this->contentTypes), '0')`, so every type appears even with 0 nodes.
- Renders an HTML `<table class="content_type_list">`: columns Content Type + Number of Pages
  (plus a "Link" column when no date range is active), one row per type showing `->label()` and the
  count, then a **Total** row (`array_sum`).
- With no date range, each non-zero row gets a "View All Pages" `<a target="_blank">` to
  `/admin/content/?type=<machine>` with `&status=1` (published), `&status=2` (unpublished) or
  `&status=All`.

## Notes for agents
- Read-only feature: it never writes, deletes, or mutates anything.
- Only content-type **labels** and aggregate **counts** are shown — no node titles, bodies, authors,
  or URLs. Access is the fairly high core permission `administer content types`.
- Nothing to configure beyond the on-screen filters; the module ships no config entities or schema.
