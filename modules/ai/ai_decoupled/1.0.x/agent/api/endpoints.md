<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Decoupled — endpoint API

Each `ai_decoupled_endpoint` config entity is reachable at `/api/ai/{id}`:

| Method / path | Operation | Auth | Notes |
|---|---|---|---|
| `POST /api/ai/{id}` | execute | `oauth2`, `basic_auth` | `no_cache`; runs the configured Chat Executor |
| `GET /api/ai/{id}` | info | `oauth2`, `basic_auth`, `cookie` | read-only, no side effects |
| `POST /api/ai/{id}/history` | history | `oauth2`, `basic_auth` | `no_cache` |
| `POST /api/ai/{id}/reset` | reset | `oauth2`, `basic_auth` | `no_cache` |

Every route requires the restricted `access ai decoupled api` permission **and** passes the custom access check `ai_decoupled.endpoint_access:access` (`EndpointAccessCheck`) which enforces the roles selected on the endpoint.

**Why no `cookie` on mutations:** these routes carry no CSRF token; accepting the ambient session cookie would let a logged-in browser be driven cross-site. Credential auth (OAuth2/basic) is immune. Configure executor, roles, streaming, and rate limiting per endpoint. Streaming responses are `text/event-stream` deltas; non-streaming responses carry raw model markdown for the client to render.
