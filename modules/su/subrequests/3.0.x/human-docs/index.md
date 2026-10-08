# Subrequests — manual setup guide

**Subrequests** (`subrequests`) adds a single front-controller endpoint,
`/subrequests`, that lets a client bundle many independent API calls into one HTTP
request. Instead of a decoupled front end (or a mobile app) firing off five or six
separate requests to build a single screen, it POSTs one JSON document — a
**blueprint** — that describes all of those inner calls, and gets back one combined
response. Drupal runs each inner call internally against its own kernel, reusing the
caller's cookies/session so every subrequest runs with the caller's normal
permissions.

The real power is in the blueprint format. Independent subrequests run in parallel;
a subrequest can declare `waitFor: ["req-1"]` to run only after another finishes,
and it can pull a value out of an earlier response with a
`{{requestId.body@$.jsonpath}}` token — so you can, for example, create a node and
then create a paragraph that references it, all in one call. The endpoint always
answers with HTTP 207 (Multi-Status): by default a `multipart/related` document with
one part per subrequest, or a single JSON object keyed by each subrequest's
`requestId` if you add `?_format=json`.

This is a developer/decoupled module: there is **no settings form, no configuration
page, and no Drush commands**. The only thing you administer is a single permission,
`issue subrequests`, which controls who may call the endpoint. It requires Drupal's
core Serialization module and the `galbar/jsonpath` PHP library (pulled in by
Composer), and works the moment it is enabled and the permission is granted.

This guide is written for a **human** setting the module up through the admin UI and
Composer. If you want terse, token-cheap references for an AI coding agent — the
blueprint format, the services, the auth providers — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it pulls in the
   `galbar/jsonpath` library), enable the module, and grant the permission.

## Where it lives in the admin menu

Subrequests has no admin pages of its own. Once enabled it exposes one route,
`/subrequests` (GET or POST), and adds one permission, **Issue subrequests**, on the
permissions page at **People → Permissions**
(`/admin/people/permissions`). There is nothing else to click.

## How to use it

Subrequests is driven entirely by what the client sends, not by site configuration:

1. **Grant the permission.** Decide which role may call the endpoint (typically a
   dedicated API/integration role, or `authenticated user` for a trusted decoupled
   front end) and tick **Issue subrequests** for it at
   `/admin/people/permissions`. Granting it to a narrow role rather than to everyone
   keeps the batching endpoint restricted to trusted consumers.
2. **Send a blueprint.** POST a JSON array to `/subrequests`, where each item
   describes one inner call with at least a `uri` and an `action` (`view`, `create`,
   `update`, `replace`, `delete`, `exists`, or `discover`, mapping onto
   GET/POST/PATCH/PUT/DELETE/HEAD/OPTIONS). Give each item its own `requestId` so you
   can match it to its part of the response.
3. **Sequence and chain when needed.** Add `waitFor: ["some-request-id"]` to defer a
   subrequest until another finishes, and use a `{{requestId.body@$.jsonpath}}` token
   to feed a value from one response into a later request's URI or body.
4. **Pick a response shape.** Take the default `multipart/related` response (each
   part keyed by `Content-ID`), or add `?_format=json` to the endpoint to get one
   JSON object keyed by `requestId`, which is usually easier to parse client-side.

The master request's authentication (`basic_auth`, `cookie`, `oauth2`, or
`token_bearer`) is reused for every subrequest in the batch, so you authenticate
once. For the exact blueprint grammar and the PHP services behind it, see the
[`agent/`](../agent/start.md) docs.
