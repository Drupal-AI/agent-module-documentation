<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Apigee API Catalog (apigee_api_catalog) — agent index

Publishes API reference documentation on a Drupal developer portal. Enabling the module creates an
`apidoc` node type ("OpenAPI Doc") whose OpenAPI spec is either an uploaded file or fetched from a
remote URL, then rendered on the node with Apigee's SmartDocs field formatter. Ships two Views for
the catalog listing, a per-node **Re-import** operation, and a `SpecFetcher` service.

- No `configure` route (operate it through the `apidoc` node type, its Manage display, and the two Views).
- No permissions of its own — access is ordinary node access on the `apidoc` bundle (contrib node-access modules apply).
- No drush commands, no config schema, no plugin managers of its own.
- Dependencies (info.yml): `text`, `entity`, `file`, `user`, `node`, `path`, `options`, `file_link`, `apigee_edge`.

Submodules shipped in the project (separate modules, each defining its own node type; enable
individually — not documented here):
- `apigee_asyncapi_doc` — AsyncAPI docs (`asyncapi_doc` node type).
- `apigee_graphql_doc` — GraphQL docs (`graphql_doc` node type).
- `apigee_freeform_doc` — free-form docs (`freeform_doc` node type).

What you'd do:
- **Understand the `apidoc` node type, its fields, and how to change the spec renderer** → [fields/apidoc.md](fields/apidoc.md)
- **Fetch/re-import a spec from a URL; call the SpecFetcher service** → [api/spec-fetcher.md](api/spec-fetcher.md)
- **Hook into the apidoc node lifecycle as an integrator** → [hooks/node-lifecycle.md](hooks/node-lifecycle.md)
- **Work with the catalog listing pages, `/api/{id}` aliases, breadcrumb and 404 redirect** → [views/catalog.md](views/catalog.md)

Key facts (real machine names):
- Node type: `apidoc` (label "OpenAPI Doc"), `new_revision: true`.
- Fields on `node.apidoc`: `field_apidoc_spec` (file, ext `yaml json`, `public://apidoc_specs`),
  `field_apidoc_spec_file_source` (list_string, values `file`/`url`), `field_apidoc_file_link`
  (file_link, ext `yaml json`), `field_apidoc_spec_md5` (string), `field_apidoc_fetched_timestamp`
  (timestamp), `field_api_product` (entity_reference → `api_product`), plus core `body`.
- Service ids: `apigee_api_catalog.spec_fetcher` (`SpecFetcher`), `apigee_api_catalog.updates`
  (`UpdateService`), `apigee_api_catalog.page_not_found_subscriber`, `apigee_api_catalog.breadcrumb`,
  `logger.channel.apigee_api_catalog`.
- Field formatter plugin: `apigee_api_catalog_smartdocs` (`SmartDocsFormatter`, for `file` fields).
- Validation constraint plugin: `ApiDocFileLink` (added to `field_apidoc_file_link`).
- Reimport route: `entity.node.reimport_spec_form` → `/node/{node}/reimport`, form op `node.reimport_spec`.
- Views: `view.apigee_api_catalog.page_1` at `/apis` (public "API Catalog"), `view.api_catalog_admin.page_1`
  at `/admin/content/apis` (admin "API catalog").
- `SpecFetcherInterface` constants: `SPEC_AS_FILE='file'`, `SPEC_AS_URL='url'`; statuses
  `STATUS_UPDATED`, `STATUS_UNCHANGED`, `STATUS_ERROR`.
- Conflicts with the deprecated `apigee_edge_apidocs` module (install-time requirement check).
