Extends Drupal's node preview to GraphQL Compose so a decoupled front end can fetch an unsaved/draft node preview over GraphQL using a secret per-preview token, enabling headless "draft mode" without exposing unpublished content publicly.

---

The module adds a `preview(id: UUID, token: String, langcode: String)` query to the GraphQL Compose schema, returning a `NodeUnion`. When a content editor opens Drupal's core node preview, the module intercepts the private tempstore/key-value backends (via a service provider that reswaps `tempstore.private`, `keyvalue.expirable.database`, and the `access_check.node.preview` class) and mints a cryptographically random 64-byte `preview_token` (`Crypt::randomBytesBase64(64)`) tied to that preview entry. That token is surfaced through two computed node base fields (`preview_token`, `preview_token_access`), Drupal tokens (`[node:preview:uuid|token|url]`), and two field formatters (`preview_token_link`, `preview_token_iframe`) you can add to the node display to render a tokenized preview link or an iframe pointing at your front end (base URL configurable per-formatter or via the `GRAPHQL_COMPOSE_PREVIEW_URL` env var). Access is enforced in `hook_node_access()`: a preview is only viewable when the node is `in_preview`, the request carries the matching token (making `preview_token_access` TRUE), **and** the account holds the `view graphql_compose_preview entity` permission. The same token also works on the core preview route (`/node/preview/{uuid}/full?token=…`) and through GraphQL Compose's `route()` query. There is no admin settings page; setup is: enable the module, grant the permission to the roles that consume previews, add the display formatter, and query with the token.

---

- Fetch an unsaved node preview over GraphQL for a decoupled/headless front end.
- Implement Next.js / Nuxt "draft mode" backed by Drupal's native preview.
- Let editors preview draft content in the real front-end app before publishing.
- Generate a shareable tokenized preview link an editor can send to a reviewer.
- Embed a live front-end preview inside the Drupal node edit page via an iframe formatter.
- Query a preview by UUID plus a secret token: `preview(id: "…", token: "…") { … }`.
- Resolve a preview through GraphQL Compose's `route(path: "/node/preview/…?token=…")` query.
- Preview a specific translation by passing a `langcode` argument.
- Keep unpublished content private — access requires both the secret token and a dedicated permission.
- Point preview links/iframes at any front-end URL using per-formatter tokens or an env var.
- Use `[node:preview:url]`, `[node:preview:token]`, `[node:preview:uuid]` tokens in other config.
- Add a "Preview with Token" link to a content type's display for editors.
- Give reviewers who can't log in a token link (grant the permission to the anonymous role if desired).
- Hide the core preview view-mode switch bar when viewing via a token.
- Build a preview toolbar/button in a decoupled CMS editor experience.
- Avoid publishing draft content just to see it rendered by the front end.
- Serve preview data with the same GraphQL Compose types as production content.
- Rotate/expire previews automatically (tokens live in the expirable preview tempstore).
- Integrate preview into an existing GraphQL Compose decoupled site with minimal wiring.
