# GraphQL Compose: Preview — manual setup guide

**GraphQL Compose: Preview** (`graphql_compose_preview`) brings Drupal's built‑in
node preview to a decoupled (headless) front end. It lets a front‑end app — a
Next.js or Nuxt "draft mode", for example — fetch an unsaved or unpublished node
**preview** over GraphQL, using a secret one‑time token, so editors can see draft
content rendered by the real front end without that content ever being exposed
publicly.

It works by adding a `preview(id, token, langcode)` query to your GraphQL Compose
schema. When an editor opens Drupal's core node preview, the module mints a long,
cryptographically random token bound to that specific preview. The front end
passes the node's UUID and that token to the `preview` query and gets back the
draft node, typed with the same GraphQL Compose types as your published content.
The token is also surfaced as Drupal tokens (`[node:preview:uuid]`,
`[node:preview:token]`, `[node:preview:url]`) and through two field formatters you
can add to a node's display — one that renders a tokenized **preview link**, and
one that renders an **iframe** pointing at your front end (so you can embed a live
preview right on the node edit page).

Access is deliberately strict: a preview is only viewable when the request carries
the matching secret token **and** the account holds the module's **View preview
entities** permission. Without a valid token the request falls back to normal
node access, so unpublished content stays private. Granting the permission to the
anonymous role is a supported pattern for headless draft mode, because the secret
per‑preview token is still required.

This is a developer‑oriented, decoupled module. It has **no admin settings page** —
setup is: enable it, grant the permission to the roles that consume previews,
optionally add a display formatter, point it at your front‑end URL, and query with
the token.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer
   (which pulls in GraphQL Compose) and enable it.

## Where it lives in the admin menu

There is no settings page. You work with the module in these places:

- **People → Permissions** (`/admin/people/permissions`) — grant **View preview
  entities** to the roles that consume previews.
- The **Manage display** tab of a content type
  (`/admin/structure/types/manage/{type}/display`) — optionally add the **preview
  link** or **preview iframe** formatter for the computed preview‑token field.

## How to use it

1. **Grant the permission.** At **People → Permissions**, enable **View preview
   entities** (`view graphql_compose_preview entity`) for every role that should be
   able to use tokenized preview links — including the **anonymous** role if your
   headless front end fetches previews anonymously. The permission alone exposes
   nothing: a matching secret token is always required too.
2. **Point the module at your front end.** Set the `GRAPHQL_COMPOSE_PREVIEW_URL`
   environment variable to your front‑end base URL, or set the base URL per
   formatter (step 3). When the env var is set it takes precedence.
3. **(Optional) Add a preview control to the node display.** On a content type's
   **Manage display** tab, configure the computed preview‑token field with one of
   the module's formatters:
   - **Preview link** (`preview_token_link`) — renders a tokenized `<a>` link an
     editor can click or share with a reviewer. Settings: link title, link URL,
     CSS class.
   - **Preview iframe** (`preview_token_iframe`) — renders an `<iframe>` that
     embeds your front‑end preview on the node page. Settings: iframe URL (default
     `https://my.frontend/preview/[node:preview:uuid]/[node:preview:token]`), CSS
     class, width, height, `allow`, and transparency.
4. **Query the preview from the front end.** Open a node preview in Drupal to mint
   a token, then query GraphQL:

   ```graphql
   { preview(id: "da02328a-…", token: "ABC123…") { ... on NodePage { title status } } }
   ```

   The same token also works on the core preview route
   (`/node/preview/{uuid}/full?token=…`) and through GraphQL Compose's `route()`
   query. Pass an optional `langcode` argument to preview a specific translation.
