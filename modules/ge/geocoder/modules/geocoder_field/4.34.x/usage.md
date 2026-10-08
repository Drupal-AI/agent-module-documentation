Geocoder Field connects the Geocoder engine to entity fields: it geocodes the content of one field (e.g. a text address) into another field (e.g. coordinates) — or reverse-geocodes the other way — automatically when the entity is saved.

---

This submodule adds the field-level glue that most sites actually configure. On the "field settings" (field config edit) form of a target field it injects Geocoder third-party settings where you choose a **method** (geocode, reverse geocode, or none), the **source field(s)** to read from, the ordered list of **providers** to use, and, for output, the **dumper** format. On `hook_entity_presave` it reads the source, calls the Geocoder service, and writes the result into the field — so saving a node with an address populates its coordinate field with no code. It defines two more plugin types: **GeocoderField** (maps how a given field type is geocoded/read — e.g. `DefaultField`) and **GeocoderPreprocessor** (normalizes raw field input such as `Text` and `File` before geocoding). It also ships geocode field formatters (`GeocodeFormatter`, `FileGeocodeFormatter`) that geocode on display, a queue worker for deferred/bulk geocoding, and a workspace publishing subscriber. A set of alter hooks let you register new source field types and tweak the address string or coordinates per field. It depends on core Field and the base Geocoder module and is itself the dependency for the Geofield and Address integration submodules.

---

- Geocode a plain-text address field into a coordinates field on save.
- Reverse-geocode a coordinates field into an address field on save.
- Choose which provider(s) run for a specific field.
- Pick the dumper/output format written into the target field.
- Populate map coordinates automatically when editors add an address.
- Geocode a field's value on display via a geocode field formatter.
- Geocode the contents of an uploaded file (GPX/KML/etc.) field.
- Defer heavy geocoding to a queue worker for bulk operations.
- Disable geocoding on a field by setting its method to "none".
- Register a custom field type as a geocode source via a hook.
- Preprocess/normalize raw field text before geocoding.
- Add a Preprocessor plugin for a new input field type.
- Add a GeocoderField plugin to control how a field type is read.
- Keep geocoding config as field third-party settings (exportable).
- Alter the per-field address string before geocoding.
- Alter the per-field coordinates before reverse geocoding.
- Re-geocode entities in bulk by re-saving them through the queue.
- Handle multi-value fields with per-delta geocoding.
- Integrate geocoding with inline entity forms.
- Respect workspace publishing when geocoding revisioned content.
