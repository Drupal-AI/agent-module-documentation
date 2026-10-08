# Routes, permissions & the report flow

## Permissions (`ps.permissions.yml`) — both `restrict access: true`

| Permission | Gates |
|---|---|
| `access paragraphs stats report` | main report, drill-downs, per-paragraph usage, CSV export |
| `administer paragraphs stats configuration` | the "Update the data structure" action |

## Routes (`ps.routing.yml`)

| Path | Controller method | Permission |
|---|---|---|
| `/admin/reports/paragraphs-stats-report` | `showStatsMainReport` | access report |
| `/admin/reports/paragraphs-stats-report/drill-down/{contentType}/{paragraph}/{bundle}` | `showStatsDrillDownReport` | access report |
| `/admin/reports/paragraphs-stats-report/drill-down/paragraph/{paragraph}` | `showParagraphUsage` (`{paragraph}` = `entity:paragraph`) | access report |
| `/admin/reports/paragraphs-stats-report/update-structure` | `updateStructure` | administer config |
| `/admin/reports/paragraphs-stats-report/export/csv` | `exportCsv` | access report |

## Flow

1. **Update the data structure** (`updateStructure()`): truncates `paragraphs_stats_inuse`, then walks
   every entity type/bundle field whose `getSetting('target_type') == 'paragraph'` and inserts one row
   per `(paragraph_name, entity_type, bundle, field_name)`. This is the metadata the report needs; the
   main report shows a "Please update the data structure" notice until it is populated. The button is
   only shown to user 1 or holders of `administer paragraphs stats configuration`.
2. **Main report** (`showUtilizationReport()` -> `getUtilizationTabularData()`): builds a matrix of
   paragraph type (rows) x content-type/entity bundle (columns). Counts come from SQL over
   `paragraphs_item_field_data` joined to the parent table; each count is bucketed into a `usage_level`
   0-4 from the min/max range and rendered with a `v-<level>` CSS class. Cells with counts link to the
   drill-down.
3. **Drill-down** (`getDrillDownTable()`): lists the parent entities for one paragraph/bundle/content
   type with occurrence counts and edit links; inputs are `Xss::filter()`-ed and bound as SQL
   `:placeholders`.
4. **Per-paragraph usage** (`showParagraphUsage()`): given a paragraph entity, lists everywhere that
   exact paragraph id is referenced (node/block_content/paragraph), with a running total.
5. **CSV export** (`exportCsv()`): same tabular data as a `text/csv` attachment; `<a>` cells are
   rewritten to `=HYPERLINK(...)` formulas by `setCsvHyperlink()`.

## Notes

- Supported parent entity types are whitelisted to `node`, `paragraph`, `block_content`
  (`getSqlBundle()`), so the interpolated `parent_type` in the query is not attacker-controlled.
- Counts ignore access (`getEntityCount()` uses `accessCheck(FALSE)`) - this is a report for trusted
  (restricted-permission) staff.
