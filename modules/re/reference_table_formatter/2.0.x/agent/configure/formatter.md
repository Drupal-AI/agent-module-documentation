# Reference Table Formatter — configuring the formatter

No global settings. You configure it per reference field on the entity's *Manage display* tab
(needs core **Field UI**).

## Enable

1. Go to the entity's display config (e.g. *Structure › Content types › Article › Manage display*).
2. For an `entity_reference` or `entity_reference_revisions` (Paragraphs) field, set the **Format** to
   **Table of Fields**.
3. Open the formatter settings gear and configure the options below; **Save**.

## Settings (schema `field.formatter.settings.entity_reference_table`)

| Setting | Type | Default | Effect |
|---|---|---|---|
| `view_mode` | string | `default` | Which view mode of the **target** entity supplies the columns — only fields enabled (and their weights) in that view mode are rendered. The select only appears when the target entity has configurable view modes. |
| `show_entity_label` | bool | `0` | Add a column with the target entity's label. |
| `hide_header` | bool | `0` | Omit the table header row (`#header`). |
| `empty_cell_value` | string | `''` | Text placed in a cell when that row's entity has no value for the column's field. |

`defaultSettings()` and `settingsForm()` live in `src/FormatterBase.php`; the settings summary reads
"Showing a table of rendered `<view_mode>` entity fields."

## How columns are chosen

Columns are the **union** of display-configurable field content across all referenced entities in the
chosen view mode, sorted by field weight. A field appears only if it is display-configurable for
`view` and present on the entity (`EntityToTableRenderer::fieldIsRenderableContent()`). If a row lacks
a column's field, `empty_cell_value` is shown.

## Supported field types & limitations

- **Field types:** `entity_reference`, `entity_reference_revisions` (Paragraphs). `FieldCollection` is
  in code but marked deprecated and is not offered in the UI.
- **Default handler only:** the reference field must use the **Default** selection handler. A
  non-default handler raises `Using non-default reference handler with reference_table_formatter has
  not yet been implemented`.
- **Single bundle only:** only the first configured target bundle is rendered; an empty
  `target_bundles` handler setting throws `target_bundles setting on the field should not be empty`.
  For bundle-less target entity types, the entity type id is used as the bundle.
- **Access:** only referenced entities the current user can `view` become rows
  (`FormatterBase::getEntitiesToView()`), and each row's `view` access is added to cache metadata.
- **View-mode fallback:** if no `entity_view_display` exists for the target `type.bundle.view_mode`,
  the target bundle's **default** display is used.
