<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# JSON:API Node Preview — agent index

Adds a `/preview` endpoint to every JSON:API **node** resource so a decoupled client can fetch the
preview (unsaved/draft) version of a node the current user just previewed. No config, no UI, no
permissions, no Drush (`configure` null). Depends on core `node` + `jsonapi`.

- **The endpoint pattern, request workflow, access model, and the services it overrides** →
  [api/endpoint.md](api/endpoint.md)

Key facts:
- Route: `GET {jsonapi_base}/{node_path}/{node_preview}/preview` (e.g.
  `/jsonapi/node/article/{UUID}/preview`). `{node_preview}` = node **UUID**.
- `{node_preview}` is resolved by core's `node_preview` param converter → the current user's private
  **preview tempstore** (only nodes the caller personally previewed this session).
- Access = core `_node_preview_access` (create/update on the node) **and** JSON:API field-level
  access checking. No access-bypass: cannot read arbitrary unpublished nodes.
- Overrides `jsonapi.include_resolver`, the entity resource controller, and
  `jsonapi.normalization_cacher` only to pass an `$in_preview` flag through `?include=` resolution.
- Responses uncached (`mergeCacheMaxAge(0)`); unknown/never-previewed UUID or no access → `404`.
