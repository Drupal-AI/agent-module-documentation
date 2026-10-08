# Node lifecycle hooks (`apigee_api_catalog.module`)

All hooks are scoped to the `apidoc` bundle; other node types are untouched. Relevant if you extend
or integrate with the catalog.

| Hook | What it does |
|---|---|
| `hook_entity_type_build` | On the `node` entity type, registers form class `reimport_spec` → `ApiDocReimportSpecForm` and link template `reimport-spec-form` → `/node/{node}/reimport`. |
| `hook_entity_bundle_field_info_alter` | Adds the `ApiDocFileLink` constraint to `field_apidoc_file_link` on `node.apidoc`. |
| `hook_ENTITY_TYPE_presave` (`_node_presave`) | For `apidoc` nodes: if source is `url`, calls `apigee_api_catalog.spec_fetcher->fetchSpec($node)` (fetches/updates the spec in memory before save); if source is `file`, recomputes `field_apidoc_spec_md5 = md5_file()` of the uploaded file. |
| `hook_ENTITY_TYPE_insert` (`_node_insert`) | Delegates to `_node_update`. |
| `hook_ENTITY_TYPE_update` (`_node_update`) | For `apidoc` nodes with no existing alias, creates a `path_alias` mapping `/node/{nid}` → `/api/{nid}` in the node's language. This `/api/{id}` pattern is what the SmartDocs renderer and the 404 redirect expect. |
| `hook_entity_operation` | Adds the "Re-import OpenAPI spec" operation (weight 100, with a `destination` query) to `apidoc` nodes the user can update. |
| `hook_form_FORM_ID_alter` (`_form_node_form_alter`) | On the `apidoc` node form: adds `#states` so `field_apidoc_spec` (file) is visible/required only when source is `file`, and `field_apidoc_file_link` only when source is `url`; appends `_apigee_api_catalog_form_node_form_validate`. |
| `hook_help` | Help text on `help.page.apigee_api_catalog`. |

`_apigee_api_catalog_form_node_form_validate` enforces that the field matching the chosen source is
non-empty: source `file` requires `field_apidoc_spec`, source `url` requires `field_apidoc_file_link`
(else a form error on the relevant field).

## Services beyond the fetcher

Declared in `apigee_api_catalog.services.yml`:

- `apigee_api_catalog.breadcrumb` (`ApigeeApiCatalogBreadcrumbBuilder`, tag `breadcrumb_builder`,
  priority 1000) — for any `apidoc` node route it sets the breadcrumb to Home → API Catalog
  (link to `view.apigee_api_catalog.page_1`).
- `apigee_api_catalog.page_not_found_subscriber` (`EventSubscriber\PageNotFoundEventSubscriber`) — see
  [../views/catalog.md](../views/catalog.md).
- `apigee_api_catalog.updates` (`UpdateService`) — backs the `hook_update_N` steps 8802–8810 in
  `apigee_api_catalog.install` (migrating the legacy 1.x `apidoc` *entity* to the `apidoc` *node type*,
  adding `field_api_product`, and restricting spec uploads to `yaml json`). Not part of the runtime API.

## Install-time note

`hook_requirements` blocks installation while the deprecated `apigee_edge_apidocs` module is enabled
(`REQUIREMENT_ERROR`) — uninstall that module first.
