# Preview API: query, token model, formatters

## The GraphQL query
Schema type plugin `PreviewToken` adds to `Query`:
```graphql
preview(id: ID!, token: String, langcode: String): NodeUnion
```
- `id` — the node **UUID**.
- `token` — the secret preview token.
- `langcode` — optional; sets the response language for the whole query.

Resolved by data producer `entity_load_preview_token` (wired in `PreviewSchemaExtension`). Its
`resolve()` stashes the token on the request (`_graphql_compose_preview_token` attribute) and then
delegates to graphql_compose_routes' `RouteEntityExtra::resolvePreview('node', ['node_preview' =>
$uuid], …)` (via reflection) to load the preview entity from the preview tempstore.

Example:
```graphql
{ preview(id: "da02328a-…", token: "ABC123FB9dsOKU") { ... on NodePage { title status } } }
```
Also works through graphql_compose_routes:
```graphql
route(path: "/node/preview/da02328a-…/full?token=ABC123FB9dsOKU") {
  ... on RouteInternal { entity { ... on NodePage { title status } } }
}
```

## Token model (how a preview is minted & matched)
- `GraphqlComposePreviewServiceProvider::alter()` reclasses three core services:
  `keyvalue.expirable.database` → `KeyValueDatabaseExpirableTokenFactory`, `tempstore.private` →
  `PrivateTempStoreTokenFactory`, `access_check.node.preview` → `NodePreviewAccessCheckToken`.
- When core writes a node preview into the expirable `tempstore.private.node_preview` collection,
  `DatabaseStorageExpirableToken::doSetWithExpire()` attaches a fresh
  `preview_token = Crypt::randomBytesBase64(64)` to the stored value.
- On read, `PrivateTempStoreToken::get()` takes the request token
  (`TokenHelper::getRequestToken()` — from `?token=` query or the `_graphql_compose_preview_token`
  attribute), looks up the store key by token (`getKeyByToken()`, a parameterised `LIKE` with the token
  sanitized to `[a-z0-9_-]` and then an exact `preview_token === token` re-check), and sets the two
  computed node fields: `preview_token` = stored token, `preview_token_access` = `token && key match`.

## Access enforcement
`graphql_compose_preview_node_access()` (see `permissions/permissions.md`): view is granted only when
the node is `in_preview`, `TokenHelper::access($node)` is TRUE (the request's token matched), **and**
the account holds `view graphql_compose_preview entity`. Otherwise the hook returns neutral and normal
node access applies (so unpublished content is not exposed without a valid token + permission).
`NodePreviewAccessCheckToken` similarly upgrades the core `/node/preview/{uuid}/{view_mode}` route to a
plain `view` access check when a token is present.

## Computed node fields (`hook_entity_base_field_info`)
- `preview_token` (computed, field type `preview_token`) — the token value; display-configurable, with
  formatters below. `no_ui` field type; empty unless the node `in_preview` and has a token.
- `preview_token_access` (computed boolean) — TRUE when the current request reached the node via a
  matching token.

## Drupal tokens (`hook_token_info` / `hook_tokens`)
`[node:preview:uuid]`, `[node:preview:token]`, `[node:preview:url]` — the last is a full preview URL
with `?token=` appended (built by `TokenHelper::url()`).

## Field formatters (add on a node display)
Both take a base URL and support the tokens above; the base URL is forced to
`getenv('GRAPHQL_COMPOSE_PREVIEW_URL')` when that env var is set (field then disabled).
- `preview_token_link` — renders a tokenized `<a>` (theme `token_preview_link`). Settings: `title`,
  `link_url`, `class`. Default link_url empty → uses the internal preview route URL.
- `preview_token_iframe` — renders an `<iframe>` (theme `token_preview_iframe`). Settings: `iframe_url`
  (default `https://my.frontend/preview/[node:preview:uuid]/[node:preview:token]`), `class`, `width`,
  `height`, `allow`, `transparency`.

`hook_form_node_preview_form_select_alter()` hides core's preview view-mode switch bar when the preview
is being viewed via a token.

## TokenHelper service (`graphql_compose_preview.token_helper`)
`token($node)`, `access($node)` (reads `preview_token_access`), `url($node)` (preview URL with token),
`getRequestToken()`, `getLooseKey($key)`, `getPreviewEntity($formState)`.

## Security posture (sound — no separate finding)
Access needs both a 64-byte CSPRNG token bound to the specific preview **and** the dedicated permission;
token lookup is parameterised and re-verified exactly, so there is no injection or partial-match bypass,
and no token ⇒ neutral ⇒ normal unpublished rules. Granting the (non-restricted) permission to
anonymous is the documented headless pattern and still requires the secret token per preview.
