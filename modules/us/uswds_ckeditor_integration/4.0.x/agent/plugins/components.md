# USWDS plugins, components & filters

## CKEditor 5 plugins (`src/Plugin/CKEditor5Plugin/`)

| Class | ckeditor5.yml id | Purpose |
|---|---|---|
| `UswdsGrid` | `uswds_ckeditor_integration_grid` | Grid builder; opens the modal `GridDialog`; per-format `available_columns`/`available_breakpoints`. |
| `UswdsAccordion` | `uswds_ckeditor_integration_accordion` | Inline accordion widget + content toolbar. |
| `UswdsTableContentItems` | `…_table_content_items` | Adds `tableUswds` content-toolbar item to mark tables sortable/stacked (needs core table plugin). |
| `UswdsOverrideDefaults` | `…_ckeditor5_overrides` | Overrides default link/list/table editing; emits no new elements. |

JS lives in `js/ckeditor5_plugins/*` (built to `js/build/*`).

## EmbeddedContent components (`src/Plugin/EmbeddedContent/`)

Surfaced via the `embedded_content` module's CKEditor button. Each has a config form + a Twig
template (`hook_theme` in `src/Hook/UswdsCkeditorIntegrationHooks.php`, templates in
`templates/embedded-content/`). All are block-level (`isInline()` → FALSE).

| Plugin id | Class | Config fields | Template / theme hook |
|---|---|---|---|
| `uswds_accordion` | `Accordion` | repeatable items (heading + `text_format` body, full_html/plain_text), bordered, multiselect, startcollapsed | `accordion.html.twig` / `uswds_ckeditor_accordion` |
| `uswds_alerts` | `Alerts` | severity (informative/warning/error/success), slim, no_icon, heading, body | `alerts.html.twig` / `uswds_ckeditor_alert` |
| `uswds_process_list` | `ProcessList` | repeatable items (heading + `text_format` body) | `process-list.html.twig` / `uswds_ckeditor_process_list` |
| `uswds_summary_box` | `SummaryBox` | heading, body (textarea) | `summary-box.html.twig` / `uswds_ckeditor_integration_summary_box` |

- Accordion/ProcessList bodies use `#type => processed_text` render arrays (so the body runs
  through the chosen text format's filters). Alerts/SummaryBox heading & body are plain
  form values rendered via Twig `{{ heading }}` / `{{ body }}`.
- The four config plugins ship default embedded-content buttons in
  `config/install/embedded_content.button.uswds_*.yml`.

## Responsive-table filters (`src/Plugin/Filter/`)

Both are `TYPE_TRANSFORM_REVERSIBLE` and operate on the already-filtered HTML with
`Html::load()` + `DOMXPath`:

- **`filter_uswds_table_sortable`** (`FilterUswdsTableSortable`): for
  `table.usa-table--sortable`, sets `scope`/`role`/`data-sortable` on header cells, `scope`/`role`
  on row `<th>`, `data-sort-value` = cell text on `<td>`, and wraps the table in a scrollable
  container + an `aria-live` announcement region. Logs and shows an error if a sortable table has
  no `<caption>` (accessibility).
- **`filter_table_attributes`** (`FilterUswdsTableStacked`): for `table.usa-table--stacked`, sets
  `scope=col` on headers and `data-label` (from the matching header text) + `scope=row` on cells.
  Logs a warning if a stacked table has no header row.

Both only **set attributes / wrap markup** via the DOM API (`setAttribute`, which escapes values)
and re-serialize with `Html::serialize()`; they do not echo raw strings.

## Security trace

Reviewed for XSS / injection while documenting:
- **Embedded components** render through Twig (`{{ heading }}`, `{{ body }}`, `{{ item['#heading'] }}`)
  which **auto-escapes**; no `|raw`. Accordion/ProcessList bodies go through `processed_text`
  (text-format filtered). The configuring actor is a content author using a format that has the
  embedded-content button, and output is escaped — no untrusted-input XSS sink.
- **Table filters** only add DOM attributes (`data-sort-value` = `$node->nodeValue` via
  `setAttribute`, which encodes); no raw HTML emitted.
- **Grid dialog** (`access content` route) returns a form and computes CSS class strings client-side
  via `EditorDialogSave`; it performs no state change and exposes no sensitive data. The class
  strings become `<div class>` on content the user is already authoring.
- **Settings/grid config** is behind `administer uswds_ckeditor_integration_grid` (admin config).
