# openapi_jsonapi — agent start

Bridge module: supplies **one `openapi_generator` plugin, id `jsonapi`**, to the base
[OpenAPI](../../../openapi/2.3.x/agent/start.md) framework. It describes a site's **JSON:API**
endpoints as an OpenAPI (Swagger 2.0) spec. It defines **no** new plugin type, config form,
permission, or Drush command — everything is inherited from OpenAPI + JSON:API.

- Depends on `jsonapi`, `openapi`, `schemata`, `schemata_json_schema` (payload schemas come from Schemata).
- Enabled → download the spec at **`/openapi/jsonapi`** (route `openapi.download`, permission `access openapi api docs`).
- Base path `/jsonapi`; `consumes`/`produces` = `application/vnd.api+json`; generator `getApiName()` = "JSON API".
- Honours JSON:API **read-only mode** (`jsonapi.settings.read_only`): TRUE ⇒ only GET/HEAD/OPTIONS/TRACE documented.

Docs:
- The `jsonapi` generator plugin — what it emits, read-only behaviour, resource exclusion → [plugins/openapi_jsonapi.md](plugins/openapi_jsonapi.md)
- Getting the spec (route, download options, in-code, gotchas) → [api/openapi_jsonapi.md](api/openapi_jsonapi.md)
