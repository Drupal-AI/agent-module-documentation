# Configure a Markup field

The module has **no** module-level settings, menu, or `configure` route. All setup is done
per field, through Field UI.

## Add the field

1. Go to a bundle's fields, e.g. **Structure → Content types → [type] → Manage fields**
   (`/admin/structure/types/manage/{type}/fields`).
2. **Add field** → choose **Markup** (field type id `markup`, listed under category
   *formatted_text*).
3. On the field settings step, fill the **Markup** element: a `text_format` widget
   (rich-text box + format selector). Type the HTML/markup and pick a text format.
   This value is **required**.

The markup you enter here is the content shown for **every** entity of the bundle — it is
stored in the field's settings, not per entity.

## Field settings (config schema `field.field_settings.markup`)

Stored under the field config's `settings.markup` as a `text_format` mapping:

| Key | Meaning |
|---|---|
| `markup.value` | the raw markup/HTML string |
| `markup.format` | machine name of the text format used to process it (e.g. `full_html`) |

Default field settings: `markup.value = ''`, `markup.format = ''` (the settings form
falls back to `filter_default_format()` when no format is set).

The field-type `isEmpty()` reports empty when `markup.value` is `NULL` or `''`.

## Behavior notes / gotchas

- **Single value only.** The module removes the "number of values" (cardinality) selector
  from the field *storage* edit form, so a Markup field is always cardinality 1.
- **Widget** renders the markup as `processed_text` on the **entity edit form**, so authors
  see it while editing. Keep the field's *form display* widget enabled for that.
- **Formatter** renders the same markup as `processed_text` on the **entity display**.
  To show the markup only to editors (not visitors), set the field's *display* to hidden
  in **Manage display** while keeping the widget in **Manage form display**.
- Because the markup is a field *setting*, it is exported with the field config
  (`field.field.{entity}.{bundle}.{field}.yml`) — change it by editing the field, not by
  editing content.
- Any HTML allowed by the chosen text format is emitted verbatim; the settings form warns
  to wrap visible output in `<div class="form-item">…</div>` to follow form standards and
  to avoid breaking page layout.
