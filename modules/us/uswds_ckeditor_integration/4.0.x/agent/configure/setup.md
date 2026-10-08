# Configure USWDS Ckeditor Integration

## Enable the plugins/filters on a text format

1. Go to *Configuration → Content authoring → Text formats and editors*
   (`admin/config/content/formats`) and edit a CKEditor 5 format.
2. Drag the desired buttons into the **Active toolbar**: **USWDS Grid**, **USWDS Accordion**,
   the table **USWDS** content-toolbar item, and (via `embedded_content`) the embedded-content
   button for Alerts/Process List/Summary Box/Accordion components.
3. Some plugins expose settings below the toolbar (see per-format config below).
4. Enable the responsive-table **filters** under *Enabled filters* if you use USWDS tables:
   - **USWDS Sortable Table Attributes CK5** (`filter_uswds_table_sortable`)
   - **USWDS Stacked Table Attributes CK5** (`filter_table_attributes`)
   Both are `TYPE_TRANSFORM_REVERSIBLE`; place them appropriately in the filter order.
5. Ensure your **Limited/Full HTML** allows the elements these plugins emit (the ckeditor5.yml
   declares `elements` per plugin, e.g. accordion `<div class id aria-multiselectable
   data-start-collapsed>`, `<button …>`; grid `<div class data-*>`; table `<th scope data-label
   data-sortable role>`, `<td data-label data-sort-value>`).

## Per-format CKEditor plugin settings

Defined in `uswds_ckeditor_integration.ckeditor5.yml`:
- **USWDS Grid** (`uswds_ckeditor_integration_grid`, class `UswdsGrid`): choose `available_columns`
  and `available_breakpoints` for this format — that scopes what the grid dialog offers.
- **USWDS Table Toolbar Items** (`UswdsTableContentItems`): conditioned on
  `requiresConfiguration: table_content_items: true` and the core `ckeditor5_table` plugin; adds a
  `tableUswds` content-toolbar entry so editors mark a selected table sortable/stacked.
- **USWDS Accordion** (`UswdsAccordion`): adds the accordion widget + its content toolbar
  (add above/below, remove, properties).
- **USWDS Overrides** (`UswdsOverrideDefaults`, `elements: false`): tweaks default link/list/table
  editing behavior; no new elements.

## Grid settings form (site-wide layout matrix)

- Route `uswds_ckeditor_integration.settings` → `admin/config/content/ckeditor_uswds_ck_grid`.
- Permission: **`administer uswds_ckeditor_integration_grid`**.
- Config object `uswds_ckeditor_integration.settings` key `breakpoints`. The shipped
  `config/install` seeds a large default matrix: breakpoints `card`, `card_lg`, `mobile`,
  `mobile_lg`, `tablet`, `tablet_lg`, `desktop`, `desktop_lg` (+ `widescreen` selectable in the
  form), each with column counts 1–12 and layout presets (Equal Width, Auto, percentage splits,
  Full Width). The form (`src/Form/Settings.php`) lets you rename breakpoint labels, add/remove
  layout presets (draggable weight table), and set each column count's default layout
  (`none` or `order` = top preset by weight).

## The grid dialog (authoring flow)

- Route `uswds_ckeditor_integration.dialog` → `/uswds_ckeditor_integration/dialog/{editor}`,
  permission `access content`; form `src/Form/GridDialog.php`.
- Three AJAX steps: **select** (number of columns) → **layout** (per-breakpoint layout radios,
  add-container / no-gutter toggles) → **advanced** (container/row/per-column utility classes).
- On save it computes USWDS grid classes (`grid-container`, `grid-row`, `grid-col*`,
  `<breakpoint>:grid-col*`) and returns them via `EditorDialogSave` to be inserted into the
  editor content as `<div class data-*>` markup. The dialog changes no server state — it only
  returns a form and the computed classes to the client; the markup is persisted as part of the
  filtered node body.

## Assets / hooks

`src/Hook/UswdsCkeditorIntegrationHooks.php`: `hook_ckeditor_css_alter` adds
`css/uswds_ckeditor.css` to the editing surface; `hook_page_attachments_alter` attaches the
front-end accordion library (`uswds_accordion.frontend`) on all pages; `hook_theme` registers the
four component templates (see plugins/components.md).
