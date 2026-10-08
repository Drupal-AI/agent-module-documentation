<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Builder UI (eb_ui) is the browser editing layer for Entity Builder: a CodeMirror-enhanced YAML editor for definitions, shared AJAX endpoints for validate/preview/discovery, and a pluggable grid-provider discovery system.

---

Entity Builder UI (`eb_ui`) is a sub-module of the Entity Builder (`eb`) project that supplies the web front-end for authoring `eb_definition` entities. It renders a YAML editor form (`EbUiYamlForm`) with CodeMirror 5 syntax highlighting (loaded from a CDN, with a plain-textarea fallback) at the Add/Edit definition routes, and exposes four shared AJAX API endpoints (`EbUiApiController`) that the editor — and any richer grid editor — calls to validate content, generate an operation preview, list bundles for an entity type, and fetch a bundle's field configuration. A hook-based discovery system (`hook_eb_ui_grid_provider_info`, managed by `GridProviderManager`) lets modules such as Entity Builder AG-Grid register a spreadsheet UI; when none is installed, or when the user switches to Source view, the YAML editor is the fallback. Editing runs on Entity Builder's Tier 1 ownership-based permissions via a custom access checker (`DefinitionEditAccess`) plus the entity access handler, and the API endpoints enforce authentication, a CSRF token header, and an XMLHttpRequest header. This documented release is `1.0.0-alpha1`, a pre-release.

---

- Create a new Entity Builder definition by typing or pasting YAML in a syntax-highlighted editor at `/admin/config/development/eb/definitions/add`.
- Edit an existing definition's YAML at `/admin/config/development/eb/definitions/{id}/edit`, with ownership enforced.
- Validate a definition from the browser without a page reload via `POST /eb/api/validate`.
- Generate an operation preview from the browser via `POST /eb/api/preview` before saving or applying.
- Let non-developers author content models in the browser with only Tier 1 permissions (create/edit own definitions).
- Toggle between a rich grid editor (e.g. AG-Grid) and raw YAML source using the grid-provider system.
- Provide autocomplete/data to editing UIs by listing an entity type's bundles via `GET /eb/api/bundles/{entity_type_id}`.
- Populate field pickers by fetching a bundle's configurable fields via `GET /eb/api/entity-config/{entity_type_id}/{bundle}`.
- Save a definition and immediately jump to the Apply form ("Save and Apply") when the user has apply access.
- Choose the default editor (YAML, auto, or a specific grid provider) and the YAML editor type (CodeMirror CDN or plain textarea) at `/admin/config/development/eb/settings/ui`.
- Run the editor with no external assets by selecting the plain-textarea mode (air-gapped sites).
- Build a custom spreadsheet or form-based front-end for Entity Builder by implementing `hook_eb_ui_grid_provider_info()` and reusing the shared API endpoints.
- Serve as the required base for the Entity Builder AG-Grid extension module.
