<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Annotations Context assembles a site's annotations into structured context payloads and exposes them as a JSON API, an MCP endpoint, and an admin preview with markdown export.

---

Annotations Context is the assembly and delivery layer of the suite. `ContextAssembler` gathers annotations for one target, an entity type, or the whole site, optionally traversing entity-reference fields (`ref_depth` 0–2), including field metadata (`inc_meta`), and adding reverse-reference sources (`inc_refs`). The assembled payload is rendered to markdown (`ContextRenderer`) or to a browseable admin page (`ContextHtmlRenderer`). Three delivery surfaces: a cacheable JSON endpoint at `/api/annotations/{target_id}`; an MCP (Model Context Protocol) Streamable-HTTP endpoint at `/api/annotations/mcp` that lists/reads each target as an `annotation://target/{id}` resource; and an admin preview at `/admin/config/annotations/context` with role simulation and a `.md` download. MCP access accepts either a Drupal session (`view annotations context` / `administer annotations`) or a Bearer token compared with `hash_equals` against a stored key; only annotation types opted into `in_ai_context` are exposed over MCP. No AI module is required.

---

- Assemble annotations for a single target, an entity type, or the whole site.
- Traverse entity-reference fields up to two hops (`ref_depth`).
- Include field metadata (type, cardinality, description) in the payload.
- Add reverse entity-reference sources (`inc_refs`).
- Render assembled context as markdown for AI consumption.
- Serve per-target annotation context as cacheable JSON to headless front-ends.
- Expose annotations to AI agents over the Model Context Protocol (MCP).
- List every annotation target as an MCP resource.
- Read one target's context as markdown via MCP `resources/read`.
- Authenticate MCP by Drupal session or Bearer API key.
- Restrict MCP output to annotation types opted into AI context.
- Preview assembled context in the admin UI as a browseable document.
- Simulate any role to see the context that role would receive.
- Filter the preview by target, entity type, and reference depth.
- Download the assembled context as a markdown file.
- Provide the shared assembler used by annotations_docs, annotations_tool, and annotations_export.
- Let other modules alter payloads via `hook_annotations_context_alter()`.
- Generate and store an MCP API key via the settings form.
