# Configure Geocoder Autocomplete

## Global settings

Form: `GeocoderAutocompleteSettingsForm` at `/admin/config/system/geocoder_autocomplete`
(route `geocoder_autocomplete.adminSettings`, permission `administer geocoder autocomplete`).
Stored in config object `geocoder_autocomplete.settings` (schema
`config/schema/geocoder_autocomplete.schema.yml`):

| Key | Type | Meaning |
|---|---|---|
| `api_key` | string | Google Cloud API key with the **Geocoding API** enabled and billing configured. Sent as `key` on every lookup. |
| `region_code_bias` | string (maxlength 2) | Optional ISO 3166-1 2-letter region code used to bias results (sent as `region`). |

Both default to `''` (`config/install/geocoder_autocomplete.settings.yml`).

```bash
drush config:set geocoder_autocomplete.settings api_key '<google-api-key>' -y
drush config:set geocoder_autocomplete.settings region_code_bias 'us' -y
```

## Put the widget on a field

The widget is chosen per field on *Manage form display*, not on the global form. For a `string`
field, set its form-display component `type` to `geocoder_autocomplete`. Widget settings
(schema `field.widget.settings.geocoder_autocomplete`):

| Setting | Default | Meaning |
|---|---|---|
| `size` | `60` | Textfield size. |
| `placeholder` | `"Digit a place"` | Placeholder text. |
| `autocomplete_route_name` | `geocoder_autocomplete.autocomplete` | Route backing the autocomplete. |

```php
// drush php:eval — put the geocoder widget on node.place field_address
$fd = \Drupal::entityTypeManager()->getStorage('entity_form_display')->load('node.place.default');
$fd->setComponent('field_address', [
  'type' => 'geocoder_autocomplete',
  'region' => 'content',
  'settings' => ['size' => 60, 'placeholder' => 'Enter an address', 'autocomplete_route_name' => 'geocoder_autocomplete.autocomplete'],
])->save();
```

The widget only attaches the autocomplete behaviour when the current user has
`access geocoder autocomplete`; otherwise it renders as a plain textfield.
