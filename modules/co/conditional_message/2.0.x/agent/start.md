<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Conditional Message (conditional_message) — agent index

**Shows a configurable coloured banner (top/bottom) gated by role (server-side), path/content-type/session/close (client-side).**

- **Version:** 2.0.x (info.yml `2.0.0`)
- **Core:** ^8 || ^9 || ^10 (Drupal 10 contrib; no D11 release)
- **Dependencies:** `node` (core).
- **Configure:** `/admin/content/conditional-message` — `entity.conditional_message.collection` (`view conditional message overview`).
- **Entity:** `conditional_message` (translatable, publishable); permissions `add|edit|delete|administer conditional message entities`, `view conditional message overview`.
- **Route:** `conditional_message.json_endpoint` `GET /conditional_message_data_output` → `ConditionalMessageController::jsonOutput` (`_permission: 'access content'`), backed by service `conditional_message.endpoint` (`ConditionalMessageEndpoint::getEndpointData`).
- **JS:** `js/conditional_message.js` reads the endpoint + `localStorage` (session/close hashes).

**Security:** the `access content` JSON route is **read-only** — access-checked entity query (`accessCheck(TRUE)`), no request parameters, no state mutation, so no CSRF concern (`src/Endpoint/ConditionalMessageEndpoint.php:52` getEndpointData). Minor: it discloses published messages' configured paths/roles/content-types to anonymous users (`src/Controller/ConditionalMessageController.php:34`), but that is front-end display metadata by design. Admin/CRUD routes are permission-gated.
