# Per-field geocoding + plugin types

## Configure (no admin page — it's on the field)
Edit any field at **Structure → … → Manage fields → (field) → Edit**. Geocoder Field injects a
`third_party_settings.geocoder_field` section (`geocoder_field_form_field_config_edit_form_alter`)
with:

| Setting | Meaning |
|---|---|
| `method` | `geocode`, `reverse_geocode`, or `none` (disabled). |
| source field(s) | Which field's value to read (address text, coordinates, file…). |
| `providers` | Ordered list of `geocoder_provider` entity ids to try. |
| `dumper` | Output format written to the target field (geojson/wkt/…). |
| delta / handling | How multi-value and existing values are treated. |

On `hook_entity_presave` (`geocoder_field_entity_presave` → `_geocoder_field_process`) the source
is read, `geocoder->geocode()`/`->reverse()` is called, and the result is dumped into the field.
Schema: `config/schema/geocoder_field.schema.yml`. Config is exportable with the field.

Field formatters also ship (`GeocodeFormatter`, `FileGeocodeFormatter`) to geocode on display,
plus a `GeocoderField` QueueWorker for deferred/bulk geocoding.

## Plugin types it defines
- **GeocoderField** — `@GeocoderField`, manager `GeocoderFieldPluginManager`, namespace
  `Plugin/Geocoder/Field`. Declares how a given field type is geocoded/read (e.g.
  `DefaultField`); implements `GeocoderFieldPluginInterface` (getSettingsForm etc.).
- **GeocoderPreprocessor** — `@GeocoderPreprocessor`, manager `PreprocessorPluginManager`,
  namespace `Plugin/Geocoder/Preprocessor`. Normalizes raw field input before geocoding
  (bundled: `Text`, `File`; `Geofield` and `Address` added by the sibling submodules). Extend
  `PreprocessorBase`.

## Hooks (`geocoder_field.api.php`)
- `hook_geocode_source_fields_alter(array &$source_fields_types)` — register field types usable
  as a geocode source.
- `hook_reverse_geocode_source_fields_alter(array &$source_fields_types)` — same for reverse.
- `hook_geocode_entity_field_address_string_alter(&$address_string, FieldItemListInterface $field)`
- `hook_reverse_geocode_entity_field_coordinates_alter(&$lat, &$lng, FieldItemListInterface $field)`
