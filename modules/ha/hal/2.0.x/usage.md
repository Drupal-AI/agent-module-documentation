HAL adds a `hal_json` serialization format that encodes Drupal entities as Hypertext Application Language, embedding hypermedia `_links` and `_embedded` relations so REST clients can discover and follow entity relationships.

---

HAL was part of Drupal core through Drupal 9 and moved to this contrib module for Drupal 10, 11 and 12; enable it when you need the `hal_json` format that older decoupled clients and migrations expect. It builds on the core `serialization` module: it registers a set of tagged `normalizer` services (for content entities, fields, field items, entity references, entity-reference revisions, timestamps and files) plus a `hal_json` `encoder`, so the core serializer produces and parses HAL documents. Each normalized entity gains a `_links` section — a `self` link, a `type` link identifying the bundle, and one relation link per field — and referenced entities are nested under `_embedded`. Those URIs are produced by the `hal.link_manager` service, which delegates to a `TypeLinkManager` (bundle/type URIs) and a `RelationLinkManager` (field relation URIs) and can also translate a URI back to internal entity-type/bundle/field IDs when denormalizing. The single config value `hal.settings:link_domain` overrides the domain used when building those link URIs (blank = the site's own domain). Two alter hooks, `hook_hal_type_uri_alter()` and `hook_hal_relation_uri_alter()`, let modules rewrite the generated URIs. It is typically paired with the `rest` module (and optionally Views REST exports) to expose entities over HTTP in `hal_json`.

---

- Serialize a content entity (node, term, user, comment) to `hal_json` for a REST response.
- Provide the `hal_json` format that a legacy decoupled front-end or mobile app already consumes.
- Restore HAL support on a Drupal 10/11/12 site after it was removed from core.
- Expose entities over HTTP with the `rest` module using the HAL normalization.
- Emit a Views REST export in `hal_json` via the serializer style plugin.
- Round-trip entities: denormalize an incoming `hal_json` payload back into a Drupal entity.
- Migrate content between Drupal sites using HAL as the interchange format.
- Embed referenced entities inline under `_embedded` so clients fetch a graph in one request.
- Give each serialized field a stable relation URI that documents what the field represents.
- Identify an entity's bundle to consumers through the `type` link in `_links`.
- Resolve incoming relation/type URIs back to entity-type, bundle and field IDs on write.
- Override the domain used in generated link URIs via `hal.settings:link_domain`.
- Point link URIs at a canonical public domain when the site runs behind a different internal host.
- Rewrite generated type URIs per request with `hook_hal_type_uri_alter()`.
- Rewrite generated relation URIs per request with `hook_hal_relation_uri_alter()`.
- Add a custom normalizer for a bespoke field type in the `hal_json` format.
- Decorate or replace `hal.link_manager` to change how link URIs are built.
- Correctly serialize file entities (including the file URL) through the dedicated file normalizer.
- Serialize timestamp fields as ISO-formatted values via the timestamp normalizer.
- Handle `entity_reference_revisions` (Paragraphs-style) references in HAL output.
- Call `getTypeUri()` / `getRelationUri()` programmatically to build HAL link URIs in custom code.
- Call `getRelationInternalIds()` to map a relation URI to its field on inbound data.
- Deserialize a HAL document received from another service into typed Drupal data.
- Keep an existing REST resource config that declares `hal_json` formats working after upgrade.
