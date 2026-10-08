<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Data Field provides a single composite field type (`data_field`) whose storage columns you define yourself — a multi-value, multi-column "spreadsheet" field rendered in a table form, similar to Triple Field / Paragraphs Table but configurable per sub-column with its own storage type, widget and formatter.

---

You add one `data_field` field to an entity, then on the field's *storage* settings define an arbitrary set of sub-columns (each with a machine name and a storage type: string, text, JSON, integer, float, decimal, boolean, email, telephone, URI, date ISO, MySQL date/time/year, timestamp, entity reference to node/user/taxonomy, or file/image). Cardinality is usually unlimited so each entity holds a table of rows. For every sub-column you pick a widget (textfield, textarea, number, range, select/radios/checkbox, autocomplete/select entity reference, file/image/media-library, date/time/month/week/year, color, password, hidden, hierarchical select, etc.) and a formatter (string, numeric, boolean, date, entity-reference label/id/entity, file/image, mail-to, telephone link, twig, timestamp-ago, JSON, key). The whole field renders through a wrapping formatter — Table (with Bootstrap-table / DataTables options and per-column sub-formatters), Chart (Google Charts / Highcharts), Details, ordered/unordered List, or JSON export. The module ships its own three plugin systems (`Plugin/DataField/FieldType`, `FieldWidget`, `FieldFormatter`) with plugin managers, plus a table field widget, editing forms reachable at `/datafield/...` routes (add/edit/clone/delete rows, gated by an entity `update` + field-edit access check), AJAX autocomplete/search JSON endpoints, a Feeds target, GraphQL Compose field-type plugins, token support, and REST normalizers. The `data_field` storage is not a real Drupal entity field per sub-value, so core field widgets/formatters do not apply to the sub-columns — everything is driven by this module's own plugins and config schema (`field.storage_settings.data_field`, `field.field_settings.data_field`, widget/formatter settings).

---

- Store a repeating table of structured rows (e.g. line items, specifications, contacts) in a single field instead of Paragraphs.
- Define custom sub-columns with individual storage types (string, integer, decimal, boolean, date, JSON, etc.).
- Build a product-attributes field with a name column, a numeric value column and a unit select.
- Add an entity-reference sub-column that autocompletes nodes, users or taxonomy terms.
- Add a file or image sub-column with the media library or file widget inside the table.
- Render the field as a responsive Bootstrap-table or DataTables grid with sorting/paging.
- Render numeric sub-columns as a Google Chart or Highchart directly from field data.
- Present the rows as an HTML definition list, ordered/unordered list, or collapsible Details.
- Export the field's rows as JSON for a decoupled front end via the JSON export formatter.
- Use a JSON editor widget to edit a sub-column that stores raw JSON.
- Constrain a sub-column to an allowed-values list rendered as select, radios or checkboxes.
- Capture ISO-8601 dates or MySQL date/datetime/time/year values with matching date widgets.
- Add a telephone sub-column rendered as a click-to-call link, or an email rendered as mailto.
- Let editors add, duplicate (Ctrl+D), reorder (arrow keys) and delete rows inline in the table widget.
- Provide inline search/autocomplete that fills sibling columns from previously entered data.
- Build a hierarchical taxonomy select where child terms load by AJAX as the parent changes.
- Import rows into a data_field via Feeds using the provided Feeds target.
- Expose a data_field to GraphQL via the bundled GraphQL Compose plugins.
- Replace tokens with data_field sub-values in text using the module's token integration.
- Apply a Twig template formatter to render a sub-column with custom markup.
- Show timestamp sub-columns as "time ago" or formatted dates.
- Add unsigned/precision/scale controls for numeric storage columns.
- Reuse one field definition across bundles while customising widgets/formatters per form/view display.
- Give editors keyboard shortcuts (Alt+N new row, Ctrl+D duplicate) for fast data entry.
- Store a color value per row with the color widget.
