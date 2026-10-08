<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Manages outbound web-service calls as configuration: define endpoints with headers, params and field mappings, then import the JSON/XML responses into Drupal entities on cron, on node render, or save the raw response to a file.

---

An **endpoint** config entity holds the base URL, HTTP method, response type (json/xml), a parent element path, save-to-entity / save-to-file flags, and multilingual options. Child config entities add **headers**, **params** and **field mappings** (source path in the response → destination field, with per-field options: id/unique field, value field, lowercase, reference-by-distant-id, use-on-delete). `WebServiceManager::endpointCall()` performs the Guzzle request, decodes JSON (via a UTF-16→UTF-8 fixer) or XML (`simplexml_load_string`), then `saveEntity()` creates/updates entities matched on the unique field, converting datetime/image/entity_reference field types (images are downloaded to `public://wsm/images/`) and optionally deleting entities no longer present. Two multilingual modes are supported: `[LANG]` in a source path (one response, per-language paths) or `[LANG]` in the URL (one call per language). A cron task calls all save-enabled endpoints, and a `wsm_endpoint` entity-reference field formatter calls the API live when a referencing node is rendered and themes the result.

All admin routes are gated by `administer wsm`; **endpoint URLs, headers and params are admin-configured only**, and server-side fetches (including image downloads from response URLs) use the Guzzle client with its defaults. XML is parsed with `simplexml_load_string`. Credentials/tokens for the remote API are placed in header/param values.

---
- Configure a REST/JSON endpoint as Drupal configuration.
- Configure an XML web-service endpoint.
- Add custom request headers to an endpoint.
- Add query/body parameters to an endpoint.
- Map a response JSON path to a destination entity field.
- Use a wildcard `*` in a source path to iterate a list.
- Import API results as nodes on cron.
- Import API results into any entity type/bundle.
- Create-or-update entities matched on a unique id field.
- Download image URLs from responses into file entities.
- Convert response strings into datetime field values.
- Resolve entity references by a distant id field.
- Delete local entities absent from the latest API response.
- Save the raw API response to a file.
- Render a live API call on node view via the `wsm_endpoint` field formatter.
- Import multilingual content via `[LANG]` in the source path.
- Import multilingual content via `[LANG]` in the URL (one call per language).
- Export/import endpoint configuration between environments.
- Lowercase mapped values during import.
- Strip a parent wrapper element before mapping.
- Schedule regular imports without writing custom Migrate code.
