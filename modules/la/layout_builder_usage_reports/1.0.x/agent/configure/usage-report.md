# The Layout Builder Usage report

- **URL:** `/admin/reports/layout/usage` (menu: Reports -> Layout Builder Usage Report).
- **Route:** `layout_builder_usage_reports.report_form` (also the module's `configure` route).
- **Permission:** `access node layout reports` (`restrict access: TRUE`).
- **Form:** `src/Form/ReportForm.php` (`FormBase`; services: `state`, `database`). No config object.

## What it shows

A table with columns: Node ID, Node Title (link to the node), Bundle, Language, Plugin ID, Label,
Provider. One row per component placed in a node's overridden layout.

## How it builds the data

1. If the table `node__layout_builder__layout` exists, selects from it joined to `node_field_data`
   (title, language). When **no** filter is set, the query is limited to 500 rows (and the Reset
   button is hidden).
2. Each row's `layout_builder__layout_section` is `unserialize()`d with an `allowed_classes`
   whitelist: `Drupal\layout_builder\Section`, `...\SectionComponent`,
   `Drupal\Component\Render\FormattableMarkup`, `Drupal\Core\StringTranslation\TranslatableMarkup`.
3. For each `SectionComponent`, reads `getPluginId()` and `get('configuration')`:
   - `inline_block:<type>` -> block type collected into the Block Type filter.
   - `component:<type>` -> paragraph type collected into the Paragraph Type filter (Layout Paragraphs
     style IDs).
   - `configuration['label']` -> Label, `configuration['provider']` -> Provider ("No Provider" if absent).

## Filters (persisted in State)

Selects for Bundle, Provider, Language, Block Type, Paragraph Type. On **Filter** submit, values are
saved to State keys `lbur_bundle`, `lbur_provider`, `lbur_language`, `lbur_block_type`,
`lbur_paragraph_type`; **Reset** deletes them. Because they live in State (not per-user), the active
filter is global/site-wide, not per-session.

## Caveats

- Reports **node** layouts only (queries the node layout table); other entity types with Layout
  Builder are not included.
- Paragraph detection assumes `component:<type>` plugin IDs (Layout Paragraphs).
- Unfiltered view is capped at 500 rows.
