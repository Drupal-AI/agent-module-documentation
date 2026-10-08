# Configure Google Map Field

## Global API-key settings

Route `gmap.field.settings` → `/admin/config/services/gmap-field-settings`
(permission `administer site configuration`). Form: `GmapFieldSettingsForm`, config object
`google_map_field.settings`:

| Key | Meaning |
|---|---|
| `google_map_field_auth_method` | `1` = plain **API Key**, `2` = **Google Maps API for Work** (client ID) |
| `google_map_field_apikey` | Google Maps JavaScript API key (used when method = 1) |
| `google_map_field_map_client_id` | Google Maps API for Work client ID (used when method = 2) |

Read/write via drush:

```bash
drush cget google_map_field.settings google_map_field_apikey
drush cset google_map_field.settings google_map_field_apikey 'YOUR_KEY' -y
```

The Google-based widget/formatters need a valid key to load tiles. The OpenLayers widget
(`olmap_field`) and formatter (`google_map_field_open_layers`) render without a Google key.

## Attach a map field to a bundle

The field type is `google_map_field`. Add it like any field (Manage fields UI, or in code):

```php
use Drupal\field\Entity\FieldStorageConfig;
use Drupal\field\Entity\FieldConfig;

FieldStorageConfig::create([
  'field_name' => 'field_map', 'entity_type' => 'node', 'type' => 'google_map_field',
])->save();
FieldConfig::create([
  'field_name' => 'field_map', 'entity_type' => 'node', 'bundle' => 'article', 'label' => 'Map',
])->save();
```

### Widgets (Manage form display)

| Widget id | Notes |
|---|---|
| `google_map_field_default` | Google Maps picker (drag marker, set zoom/type); needs API key |
| `olmap_field` | OpenLayers picker; authors coordinates without a Google key |

### Formatters (Manage display)

| Formatter id | Renders |
|---|---|
| `google_map_field_default` | Interactive Google map (default) |
| `google_map_field_embed` | Google Maps Embed "place" iframe |
| `google_map_field_open_layers` | OpenLayers map (no Google key needed) |

Set them in `core.entity_form_display.*` / `core.entity_view_display.*` components exactly like
any other field widget/formatter, e.g.:

```php
\Drupal::entityTypeManager()->getStorage('entity_view_display')
  ->load('node.article.default')
  ->setComponent('field_map', ['type' => 'google_map_field_embed'])
  ->save();
```
