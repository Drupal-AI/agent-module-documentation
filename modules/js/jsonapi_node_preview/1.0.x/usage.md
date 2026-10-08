<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
JSON:API Node Preview adds a `/preview` endpoint to every JSON:API node resource so a decoupled front end can fetch the **preview** (unsaved/draft) version of a node an editor just previewed, instead of the stored version.

---

The module has no config, no UI, and no permissions of its own (`configure` null). It defines dynamic
routes (`Routes::routes` extends JSON:API's route builder) that add `/{node_preview}/preview` to each
node resource path — e.g. `GET /jsonapi/node/article/{UUID}/preview`. The `{node_preview}` slug is a
node **UUID** resolved by core's `node_preview` param converter, which loads the node from the current
user's private per-session **preview tempstore** — the same store core's "Preview" button writes to.
Access is enforced by core's `_node_preview_access` check (requires create/update access to that node)
**and** JSON:API's own field-level access checker (`getAccessCheckedResourceObject`), so the endpoint
never returns content the caller couldn't otherwise see and never reads arbitrary nodes — only ones the
caller personally previewed in their own session. Responses are marked uncacheable
(`mergeCacheMaxAge(0)`). The module overrides `jsonapi.include_resolver`, the entity resource controller,
and the normalization cacher purely to thread an `$in_preview` flag through `?include=` resolution so
related previewed entities resolve consistently; all standard JSON:API query params (`fields`,
`include`, etc.) still work. A missing/never-previewed UUID or insufficient access yields a JSON:API
`404`.

---

- Fetch the live preview of a node an editor is editing into a decoupled/React/Next.js front end.
- Build a "Preview" button in a headless site that opens the front-end render of unsaved changes.
- Preview draft content over JSON:API without publishing it.
- Grab the preview UUID from core's `/node/preview/{uuid}/{view_mode}` URL and request it via JSON:API.
- Use `?include=` to pull referenced entities alongside the previewed node in preview mode.
- Use `?fields[...]` to limit the previewed node payload for a front-end component.
- Preview any node bundle (article, page, custom types) via its own JSON:API resource `/preview` path.
- Keep preview responses uncached so each request reflects the latest tempstore state.
- Integrate front-end preview into an editorial workflow (edit → preview → see decoupled render).
- Mirror the GraphQL `graphql_node_preview` capability for JSON:API-based decoupled stacks.
- Preview content in the editor's own language/session without affecting other users.
- Serve preview data only to authenticated editors who can edit the node (access is enforced).
- Test how unsaved field changes render in the front end before saving.
- Support Gatsby/Nuxt/Astro preview modes backed by Drupal JSON:API.
- Preview revisions-in-progress that have not yet been stored as a node revision.
- Combine with existing JSON:API auth (session, OAuth, etc.) — the preview routes enable all providers.
- Avoid exposing a separate preview API surface — reuses JSON:API resource paths with a `/preview` suffix.
- Let a front end distinguish preview requests by URL pattern for cache/routing purposes.
- Preview referenced media/paragraphs in their previewed state via include resolution.
- Provide editors instant decoupled preview without a custom preview microservice.
