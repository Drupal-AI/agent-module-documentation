<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search Web Components (search_web_components) — agent index

**Lit web components (search box, results, facets, sort, pager) that consume a search_api_decoupled JSON endpoint and render a client-side search UI, placeable as blocks.**

- **Version:** 1.0.x (1.0.0-alpha6)
- **Core:** `^10 || ^11`
- **Dependency:** `search_api_decoupled:search_api_decoupled`
- **Submodules:** `search_web_components_block`, `search_web_components_facets`, `search_web_components_layout`.

Key surfaces:
- Routes (both `administer search_api_endpoint`): `search_web_components.results_mapping.mapping_form` and `..mapping_delete_form` under `/admin/config/search/search-api/endpoints/{endpoint}/...`.
- Services: `search_api_web_components.endpoint_subscriber` (+ facets `endpoint_subscriber`) on `SEARCH_RESULTS_ALTER` — inject SWC config / built facets into the endpoint JSON.
- Form alter on `search_api_endpoint` edit form (sorts, page sizes, displays, result mappings as third-party settings).
- ~15 blocks in the "Search Components" category; facet widgets `swc_dropdown|dropdown_html|button|checkbox`; Layout Builder layouts `search_web_components_onecol|twocol`.

**Security:** No findings. Both routes are gated by `_permission: administer search_api_endpoint` (config-editing forms, not `_access: TRUE`). `Json::decode()` runs only on admin-entered settings, not request input; no outbound HTTP in PHP (components fetch client-side), no TLS override, no SQL, no weak tokens. (Minor: a leftover `\Drupal::logger('test')->info('here')` debug line in the .module — noise, not a vuln.)
