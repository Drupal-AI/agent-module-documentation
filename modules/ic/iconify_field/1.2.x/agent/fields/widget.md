# Widget: `iconify_field_icon_picker`

Class: `Drupal\iconify_field\Plugin\Field\FieldWidget\IconPicker` (extends `WidgetBase`,
implements `ContainerFactoryPluginInterface`, injects `iconify_field.icon_resolver`). The only
widget for the `iconify_field_icon` field type and its default. It renders the reusable
`#type => iconify_field` form element plus an **Advanced** details fieldset for the per-item
options.

## Widget settings (`field.widget.settings.iconify_field_icon_picker`)

`defaultSettings()`:

| Key | Type | Default | Effect |
|---|---|---|---|
| `default_collection` | string | `''` | Collection the picker pre-selects. `''` = first available. |
| `collections` | sequence of string | `[]` | Allowed collections. Empty = all collections available. |

The settings form (`settingsForm()`) builds both selects from
`IconResolver::getIconifyCollections()` — a `category => [id => "Name - License"]` map from the
bundled `collections.json`. `default_collection` is a single select (with a "First available"
option); `collections` is a `#multiple` select of allowed sets. `settingsSummary()` prints the
chosen default and the allowed list (or "All").

## The form element (`formElement()`)

For each delta the widget:

1. Attaches libraries `iconify_field/icon-preview` and `iconify_field/icon-picker`.
2. Builds `value` as `#type => iconify_field` with `#default_collection`, `#collections` (from
   the widget settings) and `#default_value` = the stored `collection:name`. This element (see
   [../api/api.md](../api/api.md)) shows the current icon preview + a "Pick an icon" button that
   opens the modal picker and a "Clear icon" button.
3. Adds an **Advanced** `details` (weight 999) with:
   - `classes` — textfield, "Additional classes".
   - `decorative` — checkbox "Decorative image" (default TRUE).
   - `arialabel` — textfield "Accessible name", `#states`-hidden unless `decorative` is unchecked.

`massageFormValues()` folds the Advanced values back onto the item (`classes`, `decorative`,
`arialabel`) and **clears `arialabel` when `decorative` is TRUE**.

## How selection actually happens (no server autocomplete)

The "Pick an icon" button is a `use-ajax` modal link to route `iconify_field.icon_picker`
(`/admin/iconify_field/menu-icons/picker`, requires permission **`access administration
pages`**). That page renders a Vue 3 app (`frontend/dist/index.js`) that fetches the JSON API
(`/api/iconify_field/collections`, `/api/iconify_field/icons/{collection}`), lets the user
search/browse, and dispatches an `iconify-field-pick-icon` DOM event. `js/pick-icon.js` catches
it and writes the chosen `collection:name` into the field's hidden input and updates the inline
preview. The modal-path query carries `selector`, `default_collection`, and the comma-joined
`collections` so the picker respects the field's allowed sets.

## Set the widget in PHP

```php
\Drupal::service('entity_display.repository')
  ->getFormDisplay('node', 'article', 'default')
  ->setComponent('field_icon', [
    'type' => 'iconify_field_icon_picker',
    'settings' => [
      'default_collection' => 'mdi',
      'collections' => ['mdi', 'tabler'],
    ],
  ])
  ->save();
```
