OpenAPI Decoupled toolbox generates OpenAPI 3.0 documentation for your Decoupled Toolbox endpoints.

---

A sub-module that integrates Decoupled Toolbox with the contrib OpenAPI module. You create `openapi_decoupled_toolbox` config entities (each naming an entity type, one or more bundles, and one or more view displays) to declare which decoupled endpoints to document; OpenAPI generator plugins (`DecoupledToolboxGenerator`, `DecoupledToolboxRestGenerator`, with a deriver) then produce an OpenAPI 3.0 spec that can be viewed via openapi_ui (Swagger UI / ReDoc). It ships an admin settings form (`/admin/config/services/openapi/decoupled-toolbox`), an entity list/add/edit/delete UI, a menu block, and an event subscriber. Requires the contrib OpenAPI module (>=8.x-2.0-rc1); its composer.json applies a patch to OpenAPI.

---

- Auto-generate OpenAPI 3.0 docs for `/decoupled-api/...` endpoints.
- Declare, per entity type/bundle/display, which endpoints appear in the spec.
- Browse the API interactively with Swagger UI or ReDoc (openapi_ui).
- Hand frontend developers a machine-readable contract for the decoupled feeds.
- Manage documentation targets as config entities under Config → Services → OpenAPI.
- Keep API docs in sync with the fields placed on each Decoupled display.
- Configure general behaviour on the settings form.
- Add a new documented endpoint from the entity collection's 'Add' action.
