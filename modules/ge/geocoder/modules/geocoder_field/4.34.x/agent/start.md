# geocoder_field — agent start

Wires the Geocoder engine into entity fields: on entity presave, geocode a source field into a
target field (or reverse). Configured as **third-party settings on the field config edit form**
(Field UI → your field → settings). Depends on core `field` + `geocoder`. Base for the
geofield/address submodules.

- Configure per-field geocoding + the plugin types it adds → [configure/field-geocoding.md](configure/field-geocoding.md)
