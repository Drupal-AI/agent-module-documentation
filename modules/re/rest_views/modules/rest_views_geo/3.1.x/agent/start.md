<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# REST Views Geo — agent index

Submodule of **rest_views**. Exports a `geolocation` field as `{lat, lng}` JSON in a Views REST
Export display. Requires `rest_views` + `geolocation`. No config/route/permissions/Drush.

- **Export a geolocation field: the formatter + serializable handler** →
  [configure/geo-export.md](configure/geo-export.md)

Key facts: field formatter id **`geolocation_latlng_formatter_export`** (class
`GeolocationLatLngExportFormatter`, field type `geolocation`) emits
`SerializedData(['lat'=>…, 'lng'=>…])`. A `hook_views_data_alter()` adds a `field_export`
("(serializable)") handler for `geolocation_field` handlers. The formatter only works with the
`field_export` handler. See the parent module doc for the serialization mechanism.
