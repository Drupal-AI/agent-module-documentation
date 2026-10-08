# Configure a Typed Link field

No global settings page (`configure` null). Everything is per-field, on the field's storage
settings, **Manage form display**, and **Manage display** tabs.

## 1. Add the field
On any fieldable bundle, add a field of type **Typed Link** (`typed_link`). It behaves as a core
Link field with one extra required property, `link_type`.

## 2. Define allowed link types (field STORAGE settings)
`TypedLinkItem::storageSettingsForm()` delegates to a core `ListStringItem`, so the storage
settings form is identical to a **List (text)** field. Set either:

```yaml
# field.storage.<entity>.<field>  -> settings (schema: field.storage_settings.typed_link)
allowed_values:
  pdf: 'PDF document'
  video: 'Video'
  external: 'External site'
allowed_values_function: ''   # OR a callback returning options (mutually exclusive with the list)
```

Keys are stored in the `link_type` column (varchar 255, indexed); labels are shown in the widget
and formatter.

## 3. Field (instance) settings
Inherited from core Link (`field.field_settings.typed_link`):

| Key | Meaning |
|---|---|
| `title` | Whether link text is disabled / optional / required (core Link values). |
| `link_type` | Allowed link type per instance (core Link URL-type value; distinct from the option). |

## 4. Widget — `typed_link`
Extends core `LinkWidget`; adds a `link_type` **select** built from
`getFieldStorageDefinition()->getOptionsProvider('link_type', $entity)->getSettableOptions($user)`
(so options can be limited per user), passed through `hook_options_list_alter`, label-sanitised
(`strip_tags` + decode entities), and flattened. The select is made `#required` on the client
(`#states`) whenever the URI input is filled.

Widget settings (`field.widget.settings.typed_link`): `placeholder_url`, `placeholder_title`.

## 5. Formatter — `typed_link`
Extends core `LinkFormatter`; renders the link normally, then appends a `type` sub-element:

```php
$output = $options[$value] ?? $value;   // label, or raw stored key if no longer allowed
$elements[$delta]['type'] = ['#markup' => $output, '#allowed_tags' => FieldFilteredMarkup::allowedTags()];
```

So it prints the option **label**, falling back to the raw stored value, filtered to Drupal's
standard allowed tag set. Inherited settings (`field.formatter.settings.typed_link`):
`trim_length`, `url_only`, `url_plain`, `rel` (e.g. `nofollow`), `target` (e.g. `_blank`).
A separate settings group `typed_link_separate` reuses the full core link formatter settings.

## Notes
- `link_type` is the field's **main property** and is `#required` — a value is always expected.
- The stored key is indexed, so it is efficient to filter/group on in Views or entity queries.
- `generateSampleValue()` produces a random core-link value plus a random allowed `link_type`.
