<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# jsonld — agent start

**Serializer back end, not an end-user feature.** Registers a `jsonld` format (tagged
normalizers priority 10–20 + an encoder) that turns any `ContentEntity` into a JSON-LD
`@graph`. Output is driven by the **core RDF module's field/bundle mappings**: only fields
that have an `rdf_mapping` are emitted, `@type` comes from the bundle's `rdf:type`, and
field-level `view` access is enforced. Depends on `serialization`, `hal`, `rdf`.
No `configure` key in info.yml; settings live at `/admin/config/search/jsonld`.

Enabling it exposes nothing on its own — you get JSON-LD by calling the `serializer`
service or by requesting an entity route with `?_format=jsonld`.

- Produce JSON-LD for an entity (serializer service, `?_format=jsonld`, normalization
  context keys, context endpoint) → [api/serialize.md](api/serialize.md)
- Customize the output — alter the normalized array, map field types to datatypes, add
  RDF namespaces (`hook_jsonld_alter_normalized_array`, `hook_jsonld_field_mappings`,
  `hook_rdf_namespaces`) → [hooks/hooks.md](hooks/hooks.md)
- Settings form: strip `?_format=jsonld` suffix, register RDF namespaces → [configure/settings.md](configure/settings.md)

Key names: format id `jsonld`; service `serializer` (or normalizer
`serializer.normalizer.entity.jsonld` = `ContentEntityNormalizer`); context service
`jsonld.contextgenerator`; URI helper `jsonld.normalizer_utils` (`getEntityUri()`);
routes `jsonld.context` (`/jsonld/context/{entity_type}/{bundle}`, perm `access content`)
and `system.jsonld_settings` (`/admin/config/search/jsonld`); config object
`jsonld.settings` (`remove_jsonld_format`, `rdf_namespaces`).
