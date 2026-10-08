<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Paragraphs table — field formatter & widget

Display and edit a Paragraphs (`entity_reference_revisions`) field as a compact HTML **table**,
one column per configured field, instead of the default stacked paragraph subforms/cards. Requires
the contrib **`paragraphs`** module at runtime (the plugin classes extend Paragraphs base classes);
cm_tools does not declare a hard dependency, so these plugins only load where `paragraphs` is
installed.

## Field formatter — `cm_tools_paragraphs_table_formatter`

Class `Plugin/Field/FieldFormatter/ParagraphsTableFormatter` (extends
`EntityReferenceFormatterBase`). Label "Paragraphs table - CM Tools". Applies to
`entity_reference_revisions` fields whose target entity implements `ParagraphInterface`
(`isApplicable()`).

- **Setting**: `view_mode` (default `default`) — chosen in `settingsForm()` from the target
  paragraph type's view-mode options; schema
  `field.formatter.settings.cm_tools_paragraphs_table_formatter` in `config/schema/cm_tools.schema.yml`.
- **Rendering** (`viewElements()`): for each allowed target bundle it reads that bundle's view
  display for the selected view mode, builds the table header from the display's visible field
  components (weight-sorted via `SortArray::sortByWeightElement`), then renders one row per
  referenced paragraph via `getPreparedRenderedEntities()` (each field rendered with its label
  hidden, `#label_display => 'hidden'`). Output is a `#theme => 'table'` render array with id
  `<targetType>-<bundle>` and class `paragraphs-table`.
- **Access & cache**: entities come from `getEntitiesToView()` (which already applies view access),
  and `cacheMetadata()` adds each entity plus its `view` access result as a cacheable dependency.
- **Alter hook**: invokes `hook_paragraphs_table_formatter_alter(&$table, $table_id)` so other
  modules can post-process each rendered table.

## Field widget — `cm_tools_paragraphs_table_widget`

Class `Plugin/Field/FieldWidget/ParagraphsTableWidget` (extends the Paragraphs module's
`ParagraphsWidget`). Label "Paragraphs table - CM Tools". Also for `entity_reference_revisions`.

- **Settings** (`settingsForm()`): only `form_display_mode` is exposed — all other inherited
  ParagraphsWidget settings are hidden (`#access = FALSE`). Schema reuses
  `field.widget.settings.paragraphs`.
- **Table build** (`formMultipleElements()`): only kicks in when the field has a **single allowed
  target bundle** (more than one bundle falls back to the normal Paragraphs widget). It flags the
  element with `#cm_tools_paragraphsTable`, resolves the bundle's form display (from the configured
  `form_display_mode`), collects that display's field components, and strips field groups from each
  delta's subform.
- **Preprocess** (`cm_tools_preprocess_field_multiple_value_form` → static
  `ParagraphsTableWidget::preprocessFieldMultipleValueForm()`): rearranges the multi-value table
  markup into one column per field. Handles unlimited cardinality (tabledrag weight column,
  caption from the field title), single-cardinality (`#cardinality == 1`, tabledrag removed), and
  new/empty tables. Static helpers `_cm_tools_paragraphs_table_header()`, `_cm_tools_paragraphs_table_row()`,
  `_cm_tools_paragraphs_table_1_row()`, and `_cm_tools_paragraphs_table_hidden_label()` build the
  header/rows and suppress inline field labels (label moves to the column header). The remove/action
  buttons and weight are preserved as trailing columns; the collapse button is removed.

## How to use

1. Have a `paragraphs` reference field on some entity, ideally restricted to **one** paragraph
   bundle (the widget's table layout only engages for a single target bundle).
2. Form display: set the field's widget to **"Paragraphs table - CM Tools"** and pick the paragraph
   **form** display mode whose enabled fields become the editable columns.
3. View display: set the field's formatter to **"Paragraphs table - CM Tools"** and pick the
   paragraph **view** mode whose enabled fields become the display columns.

## Agent notes

- Column set = the fields enabled on the selected paragraph form/view display, in weight order.
  To change columns, edit that display mode, not the formatter/widget.
- Multi-bundle fields silently use the default Paragraphs rendering; keep it single-bundle for the
  table.
