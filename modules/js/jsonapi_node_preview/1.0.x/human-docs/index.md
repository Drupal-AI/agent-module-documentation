# JSON:API Node Preview — manual setup guide

**JSON:API Node Preview** (`jsonapi_node_preview`) adds a `/preview` endpoint to
every JSON:API node resource, so a decoupled front end can fetch the **preview**
(unsaved/draft) version of a node an editor just previewed — rather than the
stored, published version. It's the JSON:API counterpart to the "Preview" button
in a headless editorial workflow: an editor edits a node, clicks Preview, and your
React/Next.js/Gatsby/Nuxt front end can render the unsaved changes before anything
is published.

For each node resource, the module generates a route like
`GET /jsonapi/node/article/{UUID}/preview`. The `{UUID}` is the node id taken from
core's preview URL, and it's resolved from the current user's **own private
preview session store** — the very same store core's Preview button writes to. All
the usual JSON:API query parameters still work, so you can use `?fields[...]` to
trim the payload and `?include=...` to pull in referenced entities in their
previewed state too.

This is a purely developer/API‑facing module: it has **no configuration, no admin
UI, and no permissions of its own**. It's also careful about access — it is *not*
a way to read arbitrary unpublished content. Every response passes two independent
checks: the node must be one the caller personally previewed in their current
session, and core's node‑preview access plus JSON:API's field‑level access must
both allow it. A UUID nobody previewed, or one the caller can't access, simply
returns a JSON:API `404`. Responses are marked uncacheable so each request
reflects the latest previewed state.

This guide is written for a **human** clicking through the admin UI and building a
front end. If you want terse, token‑cheap references for an AI coding agent, read
the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Nowhere — there is no admin page or settings form. The module works by adding
routes to your existing JSON:API surface. There's nothing to click after you
enable it.

## How to use it

1. Make sure JSON:API is enabled and reachable, and that requests are
   authenticated as an editor who can edit the node (via session cookie, OAuth, or
   any auth provider you already use with JSON:API — the preview routes enable all
   available providers).
2. In Drupal, an editor edits a node and clicks **Preview**. Core stores the
   unsaved node in that editor's private preview store and shows a preview URL of
   the form `/node/preview/{UUID}/{view_mode}`.
3. Take the `{UUID}` from that URL and request it over JSON:API:

   ```
   GET /jsonapi/node/article/{UUID}/preview
   Accept: application/vnd.api+json
   ```

4. The response is the previewed (unsaved) node, in the same JSON:API shape as any
   node resource. Add `?fields[node--article]=title,body` to trim it, or
   `?include=field_media` to pull related previewed entities alongside it.

Because the store is per‑user and per‑session, one editor's preview never leaks to
another user, and every field is access‑checked exactly as a normal JSON:API
request would be. See the sibling
[`agent/api/endpoint.md`](../agent/api/endpoint.md) for the full route pattern and
access model.
