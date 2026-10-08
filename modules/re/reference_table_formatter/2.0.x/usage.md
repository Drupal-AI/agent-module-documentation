Reference Table Formatter adds a single field formatter, "Table of Fields" (`entity_reference_table`), that renders the fields of the entities targeted by a reference field as an HTML table — one referenced entity per row, one field per column — instead of the default rendered-entity list.

---

The module registers one `@FieldFormatter` plugin (`entity_reference_table`) that applies to
`entity_reference` and `entity_reference_revisions` fields (the latter covers Paragraphs; legacy
Field Collection support exists in code but is not selectable in the UI). You choose it on an entity's
*Manage display* tab. It has four settings (schema `field.formatter.settings.entity_reference_table`):
`view_mode` (which view mode's enabled/weighted fields become the columns), `show_entity_label`
(include the target entity's label column), `hide_header` (omit the `<thead>`), and `empty_cell_value`
(string for cells a row has no value for). The heavy lifting is a reusable service,
`reference_table_formatter.renderer` (`EntityToTableRenderer::getTable()`): it renders each referenced
entity in the chosen view mode, keeps only display-configurable field content, sorts fields by weight,
unions all rows' fields into the column set, and builds a `#theme => 'table'` render array with proper
cacheable-dependency metadata. The formatter only lists referenced entities the current user may
`view`, so access is respected. A notable constraint: the field must use the **Default** reference
selection handler and, currently, only a **single target bundle** is supported — using a non-default
handler throws "Using non-default reference handler … has not yet been implemented", and an empty
`target_bundles` setting throws an exception. Requires no modules beyond core (Field UI to configure).

---

- Show a node's referenced "team members" (Paragraphs or nodes) as a table of their fields.
- Render an entity-reference-revisions (Paragraphs) field as a comparison table.
- Display referenced product/spec entities as rows with each field in its own column.
- Turn a list of referenced events into a table of date/location/price columns.
- Pick which fields appear as columns by choosing a dedicated view mode and enabling fields there.
- Reorder table columns by changing field weights in the selected view mode.
- Include the referenced entity's label as the first column via "Display Entity Label".
- Hide the table header for a compact, headerless layout.
- Set a placeholder (e.g. "—" or "N/A") for cells where a row has no value.
- Present taxonomy-term references and their fields in tabular form.
- Build a simple spec-sheet display without writing a custom Twig template or Views.
- Reuse the `EntityToTableRenderer` service to build an entity table in custom code.
- Keep per-user view access intact — rows for entities the user can't view are omitted.
- Render media reference fields' metadata fields as a table.
- Show user-reference fields (e.g. authors) with selected profile fields as columns.
- Provide a consistent tabular display across multiple reference fields by reusing one view mode.
- Display Paragraphs "table row" content authored inline as an actual HTML table.
- Swap the default "rendered entity" formatter for a scannable table on content-heavy pages.
- Generate cache-metadata-correct tables that invalidate when a referenced entity changes.
- Fall back to the target bundle's default view display when the chosen view mode has no config.
