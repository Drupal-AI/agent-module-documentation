<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Apigee API Catalog publishes API reference documentation on a Drupal developer portal: an `apidoc` ("OpenAPI Doc") node type holds an OpenAPI specification — uploaded as a file or fetched from a remote URL — and renders it interactively with Apigee's SmartDocs field formatter, with a per-node re-import operation and two Views for the catalog listing.

---

The module installs an `apidoc` node type whose fields carry the spec and its provenance: `field_apidoc_spec` (the stored spec file), `field_apidoc_spec_file_source` (choose `file` or `url`), `field_apidoc_file_link` (the remote URL when fetched), `field_apidoc_spec_md5` (checksum of the last-stored spec), `field_apidoc_fetched_timestamp` (last fetch time, used for `If-Modified-Since`) and `field_api_product` (an Apigee Edge API Product reference — the module now depends on `apigee_edge`). The `apigee_api_catalog.spec_fetcher` service (`SpecFetcher::fetchSpec()`) does a conditional GET over the HTTP client and rewrites the spec file only when the md5 actually changes; node hooks wire it in (`hook_node_presave/insert/update`, a source-aware `hook_form_node_form_alter`, and a `hook_entity_operation` that adds a **Re-import OpenAPI spec** action guarded by ordinary node update access). The default view display renders the spec with the `apigee_api_catalog_smartdocs` formatter — which hands the file URL to Google's external SmartDocs Angular app — but because the spec is a plain file field you can swap in the Swagger UI formatter via Manage display. A breadcrumb builder, a `/api/{id}` alias created per node, and a 404-redirect subscriber round out the front end, while two Views (`/apis` public, `/admin/content/apis` admin) list the catalog. Access is standard node access, so any contrib node-access module restricts which docs a role can see. Three experimental submodules extend the catalog to AsyncAPI, GraphQL and free-form docs.

---

- Publish OpenAPI/Swagger reference docs for your APIs to developers.
- Host an API catalog on a Drupal-based developer portal.
- Upload a specification file (YAML or JSON) per API.
- Fetch a specification from a remote URL instead of uploading it.
- Re-import a spec on demand when the upstream definition changes.
- Skip needless rewrites with a conditional GET and an MD5 comparison.
- Record when each specification was last fetched from its URL.
- Render the interactive docs with Apigee's SmartDocs formatter.
- Switch the renderer to Swagger UI (or any file-field formatter) via Manage display.
- Associate an API doc with an Apigee Edge API Product.
- Restrict re-import to users who can edit the node.
- Restrict which docs a role sees using a contrib node-access module.
- Expose a public "APIs" listing page at `/apis`.
- Give staff an admin catalog listing at `/admin/content/apis`.
- Give each API its own node with normal Drupal permissions and revisions.
- Add editorial body content around the generated reference docs.
- Serve a helpful redirect for deep `/api/*/*` SmartDocs sub-paths.
- Show a Home → API Catalog breadcrumb on every doc page.
- Migrate a legacy 1.x apidoc-entity collection to the apidoc node type.
- Document event-driven APIs with the AsyncAPI submodule.
- Document GraphQL APIs with the GraphQL submodule.
- Publish free-form API documentation with the free-form submodule.
- Let API teams self-serve documentation updates.
- Combine API docs with other site content in one CMS.
- Keep spec revisions through node revisioning.
