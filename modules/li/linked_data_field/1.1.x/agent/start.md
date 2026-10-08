<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Linked Data Lookup Field (linked_data_field) — agent index

**Autocomplete field/widget backed by admin-defined SPARQL / LoC / URL-argument linked-data endpoints, storing label+URI.**

- **Version:** 1.1.x (from `1.1.1`) · **Package:** Islandora
- **Core:** ^9.3 || ^10 || ^11
- **Config entity:** `linked_data_endpoint` (collection under Structure; add/edit/delete via `LinkedDataEndpointHtmlRouteProvider`).
- **Endpoint-type plugins:** `SparqlQuery`, `LoCAuthority`, `URLArgument` (`plugin.manager.linked_data_endpoint_type_plugin`).
- **Route:** `linked_data_lookup.autocomplete` `/linked-data-lookup/{linked_data_endpoint}` — `_role: 'authenticated'`, JSON.
- **Field:** field type/widget/formatter + `LinkedDataSelection` EntityReferenceSelection.
- **Security:** autocomplete gated to authenticated role. Outbound fetches use Guzzle default TLS verification (not disabled). SSRF surface is bounded — the fetched host is the admin-configured endpoint `base_url`, users supply only the query string.

See [configure/endpoints.md](configure/endpoints.md).
