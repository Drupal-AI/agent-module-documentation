# openapi — agent start

Generates an OpenAPI (Swagger 2.0) specification for a Drupal site's web-service API. It is a
**framework**: it defines the `openapi_generator` plugin type but ships **no generators** — install
[OpenAPI REST](https://www.drupal.org/project/openapi_rest) and/or
[OpenAPI JSON:API](https://www.drupal.org/project/openapi_jsonapi) to describe real endpoints. Only
dependency is core `serialization`. No config form (`configure` is null); admin landing page is
**Admin → Config → Web services → OpenAPI** (`/admin/config/services/openapi`, route `openapi.downloads`).
Download a spec at `/openapi/{generator}` (JSON). Rendering docs in a UI needs the separate `openapi_ui` project.

- Routes, spec download URLs, generator options, spec structure → [api/openapi.md](api/openapi.md)
- Define a custom generator (the `openapi_generator` plugin type) → [plugins/openapi.md](plugins/openapi.md)
- Permission that gates viewing/downloading docs → [permissions/openapi.md](permissions/openapi.md)
