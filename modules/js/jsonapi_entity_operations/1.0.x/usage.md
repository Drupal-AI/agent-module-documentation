<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
JSON:API Entity Operations adds a **"See JSON:API resource"** link to the operations dropbutton of entities (of admin-selected entity types), pointing an editor straight at that entity's JSON:API individual resource URL.
---
Despite the name, this version does not add create/update/delete write operations to JSON:API — it is a convenience/administration helper. `hook_entity_operation()` adds the extra operation link only when the current user has the `view jsonapi_entity_operations` permission and the entity's type is in the configured `entity_types` list (default: `node`); the link is built from the standard `jsonapi.{type}--{bundle}.individual` route and opens in a new tab. A preprocess hook strips query args from the link. All actual JSON:API access control (who can read/write the resource) remains governed by core JSON:API and entity access — this module only surfaces a link, it does not change authorization or expose any mutation endpoint of its own.

Setup: enable the module (requires core `jsonapi`), grant `view jsonapi_entity_operations` to roles that should see the link, and choose which entity types show it at *Configuration > Web services > JSON:API > Entity Operation Settings* (`administer jsonapi_entity_operations configuration`).
---
- Add a JSON:API resource link to node operation dropbuttons
- Let editors jump from an entity to its JSON:API resource
- Choose which entity types show the link
- Restrict who sees the link via a dedicated permission
- Debug/inspect a decoupled site's JSON:API output quickly
- Open the JSON:API resource in a new browser tab
- Discover the individual resource URL for an entity
- Speed up headless/decoupled development workflows
- Verify a bundle's JSON:API URL from the admin UI
- Limit the link to content types only (default: node)
- Grant reviewers read-only visibility of API resources
- Configure allowed entity types via the settings form- Surface API endpoints to content reviewers safely
- Add the link only for permitted roles
- Restrict the feature to chosen entity types
- Support decoupled QA by exposing resource URLs
