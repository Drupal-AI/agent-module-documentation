Plant Breeding API (BrAPI) turns a Drupal site into a BrAPI-compliant data server that publishes plant-breeding data (germplasm, studies, observations, lists, etc.) over a standard REST API mapped to your Drupal entities.

---

BrAPI 4.0.x is a server-only implementation of the Breeding API v1 (1.2/1.3) and v2 (2.0/2.1) specifications. It ships bundled JSON definition files describing every standard call, data type and field, and lets an administrator (1) enable the v1 and/or v2 endpoints under `/brapi/v1` and `/brapi/v2`, (2) choose which calls and HTTP methods are active, (3) map each BrAPI data type to a Drupal entity type/bundle and map each BrAPI field to a Drupal field (or a JSONPath custom expression / sub-mapping), and (4) grant access via BrAPI permissions and per-call role settings. Clients authenticate with a bearer access token (a `brapi_token` content entity) obtained through the v1 `/login` call or the `/brapi/token` user page. The design is storage-decoupled: because data types map to arbitrary Drupal entities, the underlying data can live in the local database, an external database, flat files or remote services (e.g. via External Entities). Read, create (POST), update (PUT), delete (DELETE) and both immediate and deferred (`/search/*`) calls are supported; deferred searches run after the response is sent via a kernel.terminate subscriber and are cached per user-role set.

---

- Expose an existing Drupal-managed germplasm collection as a standards-compliant BrAPI v2 endpoint for external breeding tools.
- Serve BrAPI v1 (1.2/1.3) to legacy clients while also offering v2 (2.0/2.1) from the same site.
- Map the BrAPI `Germplasm` data type to a custom Drupal content type and its fields.
- Provide a machine-readable `/brapi/v2/serverinfo` describing which calls and methods your server supports.
- Let breeding applications retrieve studies, observation units, observations and variables via GET calls.
- Accept new observations from a field-data-collection app via POST calls.
- Update existing germplasm records through PUT calls keyed by their BrAPI DbId.
- Delete records (e.g. lists) through DELETE calls.
- Run BrAPI `/search/germplasm` (and other search) calls, returning a `searchResultsDbId` for deferred retrieval of large result sets.
- Issue and manage per-user bearer access tokens from the `/brapi/token` page.
- Rotate, expire or delete a user's own API access token.
- Restrict certain calls to specific Drupal roles using per-call access settings.
- Give trusted integration accounts blanket read access with the `use brapi` permission, or read/write with `edit brapi content`.
- Store BrAPI data in an external database or remote service by combining BrAPI mappings with External Entities.
- Adjust default and maximum page sizes for paginated list responses.
- Configure token and deferred-search lifetimes to balance freshness and performance.
- Publish server metadata (contact email, organization, documentation URL, location) through `/serverinfo`.
- Extend or override any call with a custom module using the `hook_brapi_call_*` alter hooks.
- Add support for new BrAPI releases by dropping a new JSON definition file into the module's `definitions/` directory.
- Manage BrAPI list objects (`/lists`, `/lists/{listDbId}`, `/lists/{listDbId}/data`) backed by a Drupal entity.
- Combine BrAPI with Tripal/Chado or any other data model to serve breeding data without duplicating it.
- Provide a browsable landing page (`/brapi`) and a documentation page (`/brapi/doc`) for API consumers.
