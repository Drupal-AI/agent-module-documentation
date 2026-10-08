# GraphQL Compose: Preview — agent index

Adds a `preview(id, token, langcode)` GraphQL query (returns `NodeUnion`) so a decoupled front end
can read a draft **node preview** using a secret per-preview token. Access = node `in_preview` +
matching token + the `view graphql_compose_preview entity` permission. Depends on `node`, `token`,
`graphql_compose`, `graphql_compose_routes`. No settings page (`configure` null), no config schema,
no Drush.

- **The permission** → [permissions/permissions.md](permissions/permissions.md)
- **The query, token model, node-access enforcement, TokenHelper, the two formatters, env var** →
  [api/preview.md](api/preview.md)

Key facts:
- Query `preview` resolved by data producer `entity_load_preview_token` (schema extension
  `graphql_compose_preview`); also usable via `route(path: "/node/preview/{uuid}/full?token=…")`.
- Token = `Crypt::randomBytesBase64(64)` minted per core preview, stored in the preview tempstore.
  Surfaced via computed node fields `preview_token` / `preview_token_access`, tokens
  `[node:preview:uuid|token|url]`, and formatters `preview_token_link` / `preview_token_iframe`.
- Access gate: `graphql_compose_preview_node_access()` grants view only when `in_preview` +
  `TokenHelper::access()` (token matched) + `view graphql_compose_preview entity` permission; otherwise
  neutral (normal unpublished-node rules apply).
- Container swaps (`GraphqlComposePreviewServiceProvider`): `tempstore.private`,
  `keyvalue.expirable.database`, `access_check.node.preview`.
- Front-end base URL: per-formatter setting or env `GRAPHQL_COMPOSE_PREVIEW_URL`.
