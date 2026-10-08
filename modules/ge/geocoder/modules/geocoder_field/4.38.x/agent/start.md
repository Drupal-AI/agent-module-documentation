<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Geocoder Field (geocoder_field) — agent index

Wires the Geocoder engine into entity fields: on entity presave, geocode a source field into a
target field (or reverse). Configured as **third-party settings on the field config edit form**
(Field UI → your field → settings). Depends on core `field` + `geocoder`. Base for the
geofield/address submodules. Defines two plugin types (GeocoderField, GeocoderPreprocessor),
geocode field formatters, and a queue worker.

- Configure per-field geocoding + the plugin types it adds → [configure/field-geocoding.md](configure/field-geocoding.md)
