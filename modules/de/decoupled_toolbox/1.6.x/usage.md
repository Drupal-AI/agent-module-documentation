Decoupled Toolbox exposes Drupal entity content as JSON on a dedicated collection path, configured entirely through the Field UI via a generated "Decoupled" view mode.

---

Installing the module creates a `Decoupled` view mode (machine id `decoupled`) on every fieldable content entity type and bundle. On that view mode you place fields and assign the module's *decoupled* field formatters; whatever you configure there is exactly what a `GET /decoupled-api/{entity_type}/{bundle}/collection` request serializes to JSON. A query-string layer adds paging (`offset`, `limit`), display selection (`display`) and per-field filtering (`filter[i][f|v|c]`, wrapping Drupal entity queries with operators like `=`, `IN`, `CONTAINS`, `BETWEEN`). Each formatter can rename its JSON key and relocate its value anywhere in the output tree through the *location solver* (token-aware). A matching REST resource plugin exposes the same collection through core REST, and an events layer (`EVENT__ALTER_QUERY`, `EVENT__PROCESSABLE_CHECK`, rendered-output events) lets custom code alter the query, veto requests, or post-process the JSON. Optional sub-modules extend it to Comment, Color Field, Duration Field, Weight, Redirect, Group / Group Content Menu, and OpenAPI documentation. It is a read-only "pull content from Drupal" tool; the maintainers position it for server-to-server delivery and stress that entity/field permissions must be enforced before serving frontends directly.

---

- Stand up a headless content feed for a Next.js / Nuxt / static-site build without writing a custom REST resource.
- Expose article nodes as JSON at `/decoupled-api/node/article/collection` after placing fields on the Decoupled view mode.
- Rename Drupal field machine names to clean API keys (e.g. `field_subtitle` -> `subtitle`) using the Decoupled field key setting.
- Reshape flat field output into a nested JSON structure (e.g. `parent/subparent/title`) with the Decoupled field location setting.
- Page through large result sets with `?offset=0&limit=10` and adjust the default/required limit in module settings.
- Filter a collection by field value, e.g. `filter[0][f]=title&filter[0][v]=Hello`.
- Filter with multi-value `IN` conditions, e.g. `filter[1][f]=field_tag&filter[1][v][]=10&filter[1][v][]=1337&filter[1][c]=IN`.
- Serve several JSON shapes of one bundle by creating extra view displays and selecting them with `?display=<machine_name>`.
- Emit an API version number in each record and bump it (minor/major) directly from the view-display edit form.
- Expose entity reference fields either as nested embedded entities (`decoupled_entity_reference`) or as bare target IDs (`decoupled_entity_reference_id`).
- Output image and file fields as absolute URLs, optionally with MIME type or inlined file content.
- Include a node's path alias in the feed with the Path alias decoupled formatter.
- Convert boolean/integer/float fields to correctly typed JSON values instead of strings.
- Output raw or JSON-decoded field values with the generic-raw and JSON decoupled formatters.
- Consume the same collection through core REST (`deoupled_toolbox_collection` resource) when you prefer REST negotiation and authentication.
- Alter the entity query per request from custom code via the `EVENT__ALTER_QUERY` event (add extra conditions, sorts).
- Veto or restrict specific requests via the `EVENT__PROCESSABLE_CHECK` event returning a forbidden access result.
- Post-process assembled JSON per entity type via the rendered-output events before it is returned.
- Add decoupled support for a contrib field type by writing a small formatter plugin that extends `GenericDecoupledFormatter`.
- Expose Color Field, Duration Field and Weight field values in the feed by enabling the matching sub-modules.
- Expose Redirect source paths as a computed field on canonical-linked entities via the Redirect sub-module.
- List entities belonging to a specific Group at `/decoupled-api/group/{gid}/{type}/{bundle}/collection` with the Group sub-module.
- Generate OpenAPI 3.0 documentation for your decoupled endpoints and browse it with Swagger UI / ReDoc via the OpenAPI sub-module.
- Skip dangling references gracefully by enabling "Ignore missing entity references" in settings.
