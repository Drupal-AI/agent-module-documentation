<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
OpenAPI UI is a **framework** module that defines a plugin system and a render element for embedding an interactive OpenAPI/Swagger API explorer inside a Drupal site. It ships no user interface of its own — the actual renderers (Swagger UI, ReDoc) are provided as separate modules that implement its plugin type.

---

The module defines an `openapi_ui` plugin type (managed by `plugin.manager.openapi_ui.ui`) whose plugins know how to render an OpenAPI document with a specific JavaScript library. It also registers an `openapi_ui` render element that acts as a wrapper: you give it a plugin (`#openapi_ui_plugin`) and an API spec (`#openapi_schema` — an array, a URL/URI string, a `Url` object, a Drupal file entity, or a callback) and the element delegates the actual markup to the chosen plugin's `build()` method during pre-render. A `paramconverter` (service `openapi_ui.parm_parser`) upgrades a route parameter typed `openapi_ui` into a live plugin instance, so modules can build routes like `/api/{ui}` where `{ui}` resolves to a renderer plugin. Because the base module contains no plugins, enabling it alone renders nothing; you install `openapi_ui_swagger` and/or `openapi_ui_redoc` to get concrete renderers, and typically the `openapi` project to generate the spec that feeds the element. Plugin definitions can be altered via `hook_openapi_ui_alter()`. There is no admin UI, no configuration form, no permissions, and no Drush commands — it is purely an integration/API layer for other modules to build on.

---

- Provide a reusable render element (`#type => 'openapi_ui'`) that any module or form can drop in to display API docs.
- Embed a live, interactive API explorer (Swagger UI / ReDoc) inside a node, block, or custom page.
- Render an OpenAPI spec supplied as an inline PHP array converted to JSON at render time.
- Render an OpenAPI spec fetched from a remote URL or URI string.
- Render an OpenAPI spec addressed by a `Drupal\Core\Url` object (e.g. an internal route that emits the spec).
- Render an OpenAPI spec stored as a managed Drupal file entity, with access checks and a private file URL.
- Compute the spec lazily via a callback that receives the render element and returns an array or URL.
- Decouple the *spec source* from the *display library* so you can swap Swagger UI for ReDoc without touching the schema code.
- Define a brand-new API renderer by writing an `openapi_ui` plugin that implements `OpenApiUiInterface::build()`.
- Register a route whose `{parameter}` is typed `openapi_ui` and receives an instantiated renderer plugin via the param converter.
- Let a controller pick the renderer plugin dynamically from a URL segment (e.g. `/apidoc/swagger` vs `/apidoc/redoc`).
- Alter or remove third-party `openapi_ui` plugin definitions with `hook_openapi_ui_alter()`.
- Build a documentation portal for a decoupled/headless Drupal backend's REST or JSON:API endpoints.
- Publish interactive docs for a custom web-service API built with Drupal's REST or a custom module.
- Combine with the `openapi` module to auto-generate and display docs for core and contrib module APIs.
- Give front-end developers a self-service "try it out" console against your site's API without leaving Drupal.
- Serve the same OpenAPI spec through multiple UIs (Swagger for editing/testing, ReDoc for clean reading).
- Provide a base class (`OpenApiUi`) and interface for contrib/custom modules that add new spec-display libraries.
- Standardize how API docs are embedded so multiple modules on one site share a single rendering convention.
- Feed a file-field's uploaded OpenAPI JSON/YAML into a rendered explorer (as done by related field-formatter modules).

