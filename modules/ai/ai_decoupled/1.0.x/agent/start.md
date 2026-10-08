<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Decoupled (ai_decoupled) — agent index

**Exposes AI chat processors as per-endpoint, credential-authenticated HTTP APIs (`/api/ai/{id}`) for decoupled front-ends, with optional SSE streaming and rate limiting.**

- **Version:** 1.0.x  •  **Core:** ^10.5 || ^11.2  •  **Package:** AI  •  **Depends on:** `ai`
- **Configure:** `entity.ai_decoupled_endpoint.collection` (`administer ai decoupled endpoints`, restricted).
- **Routes:** `POST /api/ai/{endpoint}` (execute), `GET` (info), `POST /history`, `POST /reset` — all require `access ai decoupled api` + custom access `ai_decoupled.endpoint_access:access`.
- **Plugins:** ChatProcessor (Chat Executors). Controller: `AiDecoupledApiController`.
- **Security:** State-changing routes use only `oauth2`/`basic_auth` and **exclude `cookie`** on purpose (no CSRF token → prevents cross-site drive); only read-only info GET allows cookie. Per-endpoint role enforcement via `EndpointAccessCheck`; `no_cache` on mutations. Reviewed SOUND — no security findings.

See [api/endpoints.md](api/endpoints.md).
