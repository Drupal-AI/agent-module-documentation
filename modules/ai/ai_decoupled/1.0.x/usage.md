<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Decoupled exposes AI chat processors — agents, assistants, and a direct provider pass-through — as configurable HTTP endpoints for out-of-page clients such as SPAs, mobile apps, and server-to-server integrations.
---
Each endpoint is an `ai_decoupled_endpoint` config entity: an administrator picks a **Chat Executor** (ChatProcessor plugin), configures it, restricts it to a set of roles, and optionally enables streaming and rate limiting. The endpoint is reachable at `/api/ai/{id}` with `execute` (POST), `info` (GET), `history` (POST), and `reset` (POST) operations. Responses carry the model's raw markdown (the client owns rendering), and when streaming is available the response is a true `text/event-stream` of incremental deltas.

The security model is deliberate and documented in the routing file: **state-changing routes accept only credential-based auth (`oauth2`, `basic_auth`) and specifically exclude the ambient `cookie` session**, because these routes carry no CSRF token — including cookies would allow a logged-in user's browser to be driven cross-site. Only the read-only `info` GET (no side effects) also accepts `cookie`. Access requires the restricted `access ai decoupled api` master-switch permission **and** passes a per-endpoint custom access check (`ai_decoupled.endpoint_access:access`, `EndpointAccessCheck`) enforcing the roles selected on that endpoint; `administer ai decoupled endpoints` (restricted) governs endpoint CRUD. All execute/history/reset routes are `no_cache: TRUE`. This is a sound, well-considered access posture rather than an open API.
---
- Expose an AI agent or assistant as an HTTP API for a JavaScript SPA.
- Serve an AI chat endpoint to a mobile app via OAuth2 or basic auth.
- Configure several endpoints, each with its own executor, roles, and limits.
- Stream responses as true SSE deltas to a decoupled client.
- Return raw markdown and let the client render it.
- Restrict an endpoint to specific roles.
- Rate-limit an endpoint to bound provider cost.
- Fetch endpoint metadata via the `info` GET route.
- Retrieve conversation history via the `history` POST route.
- Reset a conversation via the `reset` POST route.
- Use a direct provider pass-through executor for simple chat.
- Require OAuth2/basic-auth credentials and avoid CSRF exposure by design.
- Keep the read-only info route cookie-accessible while locking down mutations.
- Gate all access behind the `access ai decoupled api` master switch.
- Manage endpoints with the restricted admin permission.
- Build a headless AI chat backend on top of the AI module.
- Offer different processors to different client apps.
- Enforce per-endpoint role checks via the custom access service.
- Disable caching on state-changing AI routes.
- Integrate server-to-server AI calls with credential auth.
