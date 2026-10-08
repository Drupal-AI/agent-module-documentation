<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Content Assistant turns a short text prompt into a complete, unpublished Drupal node — filling node fields, nested paragraphs, entity references, links, formatted text, and generated images — by reading the content type's own field schema and asking the configured AI provider for structured JSON.

---

The module adds a "Generate with AI" entry to `/node/add` and a form at `/node/add/ai-generate` where an editor picks a content type they are allowed to create and describes what they want. `ContentSchemaDiscovery` inspects that bundle — node fields, Paragraphs reference fields, sub-paragraphs, referenceable entity IDs, link/color/text-format constraints — and `ContentGenerator` builds a system prompt, calls the `chat_with_complex_json` (or `chat`) operation of the AI (`drupal/ai`) module, parses the returned JSON, and creates an unpublished (`status = 0`) draft node. Field values are mapped defensively: entity references are validated through the field's selection handler, link URIs are checked against an allowed scheme list and the field's internal/external setting, formatted text is normalized to `basic_html` or `plain_text`, and image fields are produced through a configured `text_to_image` provider (bundles with a required image field are blocked up front if no such provider exists, so no tokens are spent on infeasible content). Access is enforced twice — the route requires the `generate ai content` permission and both `generate()` and `generateFromData()` re-check that permission plus per-bundle node create access, so structured-data callers (including the MCP submodule) cannot bypass authorization. Requires the AI module and at least one configured chat provider; Paragraphs is optional and only needed for paragraph-based bundles.

---

- Generate a draft landing page, article, or any node type from a one-line description.
- Let editors create content without hand-filling every field on complex bundles.
- Auto-populate Paragraphs-based page builders (hero, accordion, card grid, etc.) from a prompt.
- Fill nested sub-paragraphs (e.g. cards inside a card grid) in a single generation pass.
- Generate topical images for image-media fields via a `text_to_image` provider instead of picking from the library.
- Reuse existing media by ID when the AI is told to, rather than always generating new images.
- Populate entity-reference fields by having the AI pick from real, access-checked entities on the site.
- Respect a reference field's Views/selection handler so only genuinely referenceable entities are offered and accepted.
- Keep AI output on-brand by giving each content type a free-form "purpose" description on its edit form.
- Produce rich multi-paragraph body text formatted with safe basic HTML.
- Enforce link-field rules automatically (internal-only vs external-only, title required/optional).
- Prevent broken drafts by failing fast when a required image field has no image provider configured.
- Always save as an unpublished draft for human review before publishing.
- Restrict who can generate content with the dedicated `generate ai content` permission.
- Limit generation to the content types the current user can actually create.
- Add a discoverable "Generate with AI" shortcut at the top of the node-add list.
- Seed a first draft that editors then refine, rather than authoring from a blank form.
- Expose the same generation capability to external AI clients (Claude, Codex) through the MCP submodule.
- Let an AI client read an existing node's structure with `get_node` to create consistent related content.
- Discover a bundle's field shape programmatically before generating (`describe_content_type`).
- Batch-create many draft nodes in parallel from AI sub-agents, each running under a real Drupal user's permissions.
