<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Content Hub reads an existing "reference" entity into JSON an AI can author against, then hydrates a returned JSON payload into a validated preview or a saved Drupal entity.
---
The module is an engine, not an AI client: it has no API key, prompt, model choice, and no dependency on the AI or AI Agents modules. The writing is done outside the site — the `ai_content_hub_mcp` submodule lets an MCP client such as Claude Code do it — while this module handles the Drupal side: extracting a reference page's fields and current values into structured JSON, validating a returned payload against the target's fields, and rendering it. Hydration has three modes: **preview** (map onto a discarded copy and render a full themed HTML document, nothing saved), **create** (build and save a new entity of a named bundle), and **override** (map onto a named entity and save, keeping id/author/status, replacing not merging). It never deletes. Every path validates before saving; a payload that does not fit raises per-violation errors and writes nothing.

Security is explicitly the caller's responsibility and this is documented, not accidental: **no path checks permissions or the current user, and field-level access is not enforced** — a payload can write any field the target has. The bundle to create must come from a trusted source (route/form/config), never the payload. On its own the base module exposes no pages, forms, or permissions. The `ai_content_hub_preview` submodule adds the UI and access control: preview routes are gated by restricted permissions (`generate/publish/delete ai content hub previews`) and entity-access checks, with a separate `make ai content hub previews public` permission required to expose a preview to anonymous visitors. Callers wiring the engine directly must add their own authorization.
---
- Extract a reference entity's field structure and values into JSON.
- Describe what each field accepts so an AI can author valid content.
- Preview an AI-authored payload as a full themed HTML document without saving.
- Create a new entity of a chosen bundle from a JSON payload.
- Override an existing entity's fields from a payload (id/author/status kept).
- Validate a payload against target fields before anything is written.
- Surface per-field violations when a payload does not fit.
- Drive content authoring from an MCP client via the `ai_content_hub_mcp` submodule.
- Add a preview UI and access control via the `ai_content_hub_preview` submodule.
- Store previews privately per account or as sharable entities with their own URL.
- Publish a preview into a real, permanent node.
- Share a preview with a URL other permitted accounts can open.
- Expose a sharable preview to anonymous visitors (restricted permission).
- Build content-generation tooling without embedding an AI provider.
- Keep AI provider choice and billing entirely outside Drupal.
- Enforce your own authorization before calling the engine.
- Take the target bundle from a trusted route/form, never the payload.
- Regenerate a page's structure as a template for new pages.
- Render themed previews for editorial review before creation.
- Delete previews you no longer need (previews only; the engine never deletes content).
