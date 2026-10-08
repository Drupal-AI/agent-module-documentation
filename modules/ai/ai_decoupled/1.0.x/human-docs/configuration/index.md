# Configuration

All of AI Decoupled's configuration happens on **AI Decoupled endpoint**
entities. Each endpoint is one addressable API at `/api/ai/{id}`, and you can
create as many as you like — one per client app, or several with different
executors and limits.

## Open the endpoints list

Go to the **AI Decoupled endpoints** collection (route
`entity.ai_decoupled_endpoint.collection`). You need the restricted
**Administer AI decoupled endpoints** permission to see it. From here you add,
edit and delete endpoints.

## Creating or editing an endpoint

When you add or edit an endpoint you set the following:

- **Chat Executor** — the ChatProcessor plugin this endpoint runs. This is the
  heart of the endpoint: pick the AI agent, the AI assistant, or the direct
  provider pass-through you want exposed. Each executor has its own settings,
  which appear once you choose it.
- **Roles** — the roles allowed to call this endpoint. At runtime the module's
  per-endpoint access check enforces this list, so a credentialed caller must
  also belong to one of the selected roles. This is in addition to the global
  **Access AI decoupled API** permission every call requires.
- **Streaming** — when the chosen executor supports it, enabling streaming
  makes `execute` return a true `text/event-stream` of incremental deltas
  instead of one complete response. Leave it off for a simple request/response
  client; turn it on for a chat UI that renders tokens as they arrive.
- **Rate limiting** — an optional cap on how often the endpoint may be called,
  so you can bound provider cost and guard against abuse.

## What the endpoint exposes

Once saved, the endpoint answers at `/api/ai/{id}` with four operations:

| Method / path | Operation | Authentication |
|---|---|---|
| `POST /api/ai/{id}` | execute — run the executor | OAuth2, basic auth |
| `GET /api/ai/{id}` | info — read-only metadata | OAuth2, basic auth, cookie |
| `POST /api/ai/{id}/history` | history — fetch a conversation | OAuth2, basic auth |
| `POST /api/ai/{id}/reset` | reset — clear a conversation | OAuth2, basic auth |

The state-changing routes (`execute`, `history`, `reset`) deliberately accept
**only** credential auth and refuse the browser session cookie — they carry no
CSRF token, and accepting cookies would let a logged-in browser be driven
cross-site. Only the read-only `info` GET also allows a cookie. All three
mutating routes are marked no-cache. You do not configure any of this; it is
the module's fixed, considered security posture.

## Save

Save the endpoint. It is reachable immediately for any caller who holds the
**Access AI decoupled API** permission, presents valid credentials, and belongs
to one of the endpoint's selected roles.
