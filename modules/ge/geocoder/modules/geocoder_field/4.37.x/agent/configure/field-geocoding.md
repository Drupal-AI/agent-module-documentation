<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Per-field geocoding + plugin types

## Configure (no admin page — it's on the field)
Edit any field at **Structure → … → Manage fields → (field) → Edit**. Geocoder Field injects a
`third_party_settings.geocoder_field` section (`geocoder_field_form_field_config_edit_form_alter`)
with (schema `config/schema/geocoder_field.schema.yml`):

| Setting | Meaning |
|---|---|
| `method` | `geocode`, `reverse_geocode`, or `none` (disabled). |
| `geocode.field` / source field(s) | Which field's value to read (address text, coordinates, file…). |
| `field` | Target field to geocode to/from, depending on `method`. |
| `providers` | Ordered list of `geocoder_provider` entity ids to try (sequence). |
| `dumper` | Output format written to the target field (geojson/wkt/…). |
| `delta_handling` | How multi-value input is treated. |
| `skip_not_empty_value` | Skip the operation when the target already has a value. |
| `failure` | Geocoding-failure handling (`handling`, `status_message`, `log`). |

On `hook_entity_presave` (`geocoder_field_entity_presave` → `_geocoder_field_process`) the source
is read, `geocoder->geocode()`/`->reverse()` is called, and the result is dumped into the field.
Config is exportable with the field.

Field formatters also ship (`Plugin/Field/FieldFormatter/GeocodeFormatter`,
`FileGeocodeFormatter`, base `GeocodeFormatterBase`) to geocode on display, plus a
`Plugin/QueueWorker/GeocoderField` QueueWorker for deferred/bulk geocoding and an
`EventSubscriber/WorkspacePublishingSubscriber` for workspace publishing.

## Plugin types it defines
- **GeocoderField** — `@GeocoderField` (`Annotation/GeocoderField`), manager
  `GeocoderFieldPluginManager`, namespace `Plugin/Geocoder/Field`. Declares how a given field type
  is geocoded/read (e.g. `DefaultField`); implements `GeocoderFieldPluginInterface`
  (`getSettingsForm` etc.).
- **GeocoderPreprocessor** — `@GeocoderPreprocessor` (`Annotation/GeocoderPreprocessor`), manager
  `PreprocessorPluginManager`, namespace `Plugin/Geocoder/Preprocessor`. Normalizes raw field
  input before geocoding (bundled: `Text`, `File`; `Geofield` and `Address` added by the sibling
  submodules). Extend `PreprocessorBase` (`PreprocessorInterface`).

## Hooks (`geocoder_field.api.php`)
- `hook_geocode_source_fields_alter(array &$source_fields_types)` — register field types usable
  as a geocode source.
- `hook_reverse_geocode_source_fields_alter(array &$source_fields_types)` — same for reverse.
- `hook_geocode_entity_field_address_string_alter(&$address_string, FieldItemListInterface $field)`
- `hook_reverse_geocode_entity_field_coordinates_alter(&$lat, &$lng, FieldItemListInterface $field)`
