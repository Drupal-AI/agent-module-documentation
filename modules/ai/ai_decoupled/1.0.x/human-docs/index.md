# AI Decoupled — manual setup guide

**AI Decoupled** (`ai_decoupled`) exposes the Drupal AI module's chat
processors — agents, assistants, and a direct provider pass-through — as
credential-authenticated HTTP endpoints, so a separate front-end can talk to
them. If you are building a JavaScript single-page app, a mobile app, or a
server-to-server integration that needs to reach an AI agent living in Drupal,
this module gives you the API to do it without rendering anything through
Drupal's own pages.

Each endpoint you create is a small configuration entity. You pick which chat
executor it runs, configure that executor, restrict it to a set of roles, and
optionally turn on streaming and rate limiting. The endpoint then answers at
`/api/ai/{id}` with four operations: `execute` (POST, runs the AI),
`info` (GET, read-only metadata), `history` (POST) and `reset` (POST).
Non-streaming responses hand back the model's raw markdown so your client owns
the rendering; when streaming is on, the response is a true
`text/event-stream` of incremental deltas.

The security model is deliberate. The state-changing routes accept only
credential-based authentication (OAuth2 or basic auth) and specifically refuse
the ambient browser session cookie, because those routes carry no CSRF token —
accepting cookies would let a logged-in user's browser be driven cross-site.
Only the read-only `info` GET also accepts a cookie. Every route additionally
requires the master-switch permission and passes a per-endpoint role check, so
nothing here is an open API.

This guide is written for a **human** setting the module up through the admin
UI. If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and confirm the AI module dependency.
2. [Configuration](configuration/index.md) — create and tune endpoints field by
   field, including auth, roles, streaming and rate limiting.

## Where it lives in the admin menu

Once enabled, you manage endpoints from the **AI Decoupled endpoints**
collection (the `entity.ai_decoupled_endpoint.collection` route). Managing
endpoints requires the restricted **Administer AI decoupled endpoints**
permission; calling an endpoint at runtime requires the **Access AI decoupled
API** permission plus membership in the roles selected on that endpoint.

## How to use it

After you have created an endpoint (see [Configuration](configuration/index.md)),
your front-end client calls it directly. POST to `/api/ai/{id}` with OAuth2 or
basic-auth credentials to run the configured executor, GET the same path for
metadata, POST to `/api/ai/{id}/history` to retrieve a conversation, and POST
to `/api/ai/{id}/reset` to clear one. The provider API keys that the underlying
executors use are never handled by this module directly — they live in the AI
module's provider layer as Key entities, as described in
[Installation](installation/index.md).
