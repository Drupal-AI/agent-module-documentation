# Configure the "Link text from field" formatter

No admin settings page. You select the formatter per file field on the entity's **Manage display**
tab and choose which text field supplies the link text.

## Enable on a field (UI)

1. Go to *Manage display* for the bundle (`admin/structure/.../display`).
2. For a single-value **File** field, set the format to **"Link text from field"** (`file_fieldtext`).
3. Open the format's cog and set **"Use field value as link text"** to a `string` field on the same
   bundle, or **"Disabled"** to keep the default filename.

## Settings

| Key | Type | Default | Meaning |
|---|---|---|---|
| `use_field_as_link_text` | string | `0` | Machine name of a sibling `string` field whose `->value` becomes the link text. `0` = disabled (use filename). |

Schema: `field.formatter.settings.file_fieldtext` (single key `use_field_as_link_text`). The settings
form only lists fields whose type is `string` (plus the "Disabled" option) for the current
`getTargetEntityTypeId()` / `getTargetBundle()`.

Example component in `core.entity_view_display.*`:

```yaml
content:
  field_document:
    type: file_fieldtext
    settings:
      use_field_as_link_text: field_document_title
```

## Applicability & render behaviour

- `isApplicable()` returns TRUE only when the file field's storage **cardinality is 1**; multi-value
  file fields will not offer this formatter.
- `viewElements()` builds a `#theme => 'file_link'` element per referenced file (via
  `getEntitiesToView()`), attaching the file's cache tags.
- When `use_field_as_link_text` is set, `#description` is `$entity->{$fieldname}->value`; otherwise
  `#description` is `NULL` and core renders the filename as the link text.
- Any file item `_attributes` are merged onto the element and then unset so they are not
  double-rendered by the field template.
- `settingsSummary()` appends "Use field value as link text: <field label>" when a field is chosen.

## Notes

- The referenced text field's `value` is passed straight through as the link description; core's
  `file_link` theming handles output. Choose a plain-text (`string`) field — the UI only offers
  `string`-type fields.
- No code API, hooks, services, or Drush commands are provided.
