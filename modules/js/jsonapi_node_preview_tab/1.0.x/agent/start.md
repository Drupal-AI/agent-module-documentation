<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# JSON:API Node Preview Tab (jsonapi_node_preview_tab) — agent index

**Adds a per-node "JSON:API" tab that embeds the node's JSON:API individual endpoint in an iframe for inspection.**

- **Version:** 1.0.x (release 1.0.2)
- **Core:** ^8 || ^9 || ^10 || ^11
- **Dependencies:** node, jsonapi
- **Route:** `entity.node.json_preview` → `/node/{node}/json-preview` (controller `JsonapiNodePreviewTabController::build`)
- **Local task:** `jsonapi_node_preview_tab.preview` (tab on `entity.node.canonical`)
- **Permission:** `access jsonapi preview tab` (gates both the tab and the entity-operation link)
- **Key hooks:** `hook_entity_type_build` (adds `json-preview` link template), `hook_entity_operation`

**Security:** View-only. The tab is permission-gated (`access jsonapi preview tab`); the framed URL is the standard `jsonapi.node--{bundle}.individual` endpoint, so JSON:API's own entity-access checks still apply and the tab does not bypass node access or leak unpublished content. No mutating or anonymous endpoints.
