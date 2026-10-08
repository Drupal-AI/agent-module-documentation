# Configuration

Blizz Table Field is configured in two places: on the field itself (through Field
UI) and, for module-wide options, on the module's settings form.

## Add a table field

1. Go to the **Manage fields** screen of the content type (or other fieldable
   entity) you want to add the table to — for example **Structure → Content types →
   [type] → Manage fields**.
2. Add a new field of the **Blizz Table** type and save the field settings.

## Set the editing widget

On **Manage form display** for that bundle, the Blizz Table field uses the
**Handsontable** spreadsheet-style widget. Editors then enter rows and columns in a
familiar grid when creating or editing content, rather than writing table markup by
hand. Because the field depends on core Filter, cell contents can carry formatted
text (and media, via File/Image) subject to the text format applied.

## Set the display

On **Manage display**, choose the table formatter so the stored rows and columns
render as a table on the rendered entity.

## Module settings form

The module also provides a settings form (`blizz_table_field.settings_form`) for
module-wide options governing the table field and its Handsontable widget. Review
it after installing to confirm the defaults suit your site.
