<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# JSON:API Preview Tab (jsonapi_preview_tab) — agent index

**Adds a JSON:API Preview local-task tab to node/media/taxonomy-term/menu-link-content pages showing the entity's serialized JSON:API document.**

- **Version:** 1.0.x  ·  **Core:** ^9–^12  ·  **Package:** Development
- **Depends on:** jsonapi, jsonapi_extras.
- **Routes:** `entity.{node|media|taxonomy_term|menu_link_content}.jsonapi_preview` at `/{type}/{id}/jsonapi-preview`, added by `Routing\RouteSubscriber`; link template set in `hook_entity_type_build`.
- **Controller:** `JsonapiPreviewTabController::build()` serializes via `jsonapi_extras.entity.to_jsonapi` and pretty-prints/highlights.
- **Permission:** `access jsonapi preview tab`.

See [api/preview.md](api/preview.md).