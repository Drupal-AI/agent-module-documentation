<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Content Hub (ai_content_hub) — agent index

**Content-authoring engine: extracts an entity's field structure to JSON and hydrates payloads back into validated previews or saved entities. Ships no AI.**

- **Version:** 1.0.x  •  **Core:** ^11  •  **Package:** AI
- **Base module:** a library — no routes, forms, or permissions. Enable a submodule or write a consumer.
- **Submodules:** `ai_content_hub_mcp` (MCP client authoring), `ai_content_hub_preview` (UI + access control, routes under `/ai-content-hub/preview/*` and `/ach-preview/*`).
- **Hydration modes:** preview (nothing saved), create (new entity), override (overwrite named entity); never deletes.
- **Security:** By design the engine enforces **no access control and no field-level access** — the caller must authorize and must supply the target bundle from a trusted source, never the payload (documented contract). The `ai_content_hub_preview` submodule adds restricted permissions + entity-access; exposing previews to anonymous requires the `make ... public` permission. Report: callers wiring the raw engine must add their own authorization (README-documented, not a module bug).

See [api/engine.md](api/engine.md).
