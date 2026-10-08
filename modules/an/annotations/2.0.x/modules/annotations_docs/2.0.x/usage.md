<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Annotations Documents generates AI-authored documentation nodes from a target's assembled annotation context.

---

Annotations Documents turns the annotations attached to a target into readable prose documentation using the Drupal AI module. For a chosen target, `DocumentGeneratorService::generate()` assembles that target's context markdown (via annotations_context, with field metadata), sends it to the configured default AI chat provider with a shipped system prompt, decodes the response, strips any raw HTML the provider returned, converts the markdown to a safe HTML subset with league/commonmark, and stores it as an unpublished `annotations_document` node (a new revision each time). A documents browser at `/annotations/documents` lists targets with their document status; generation is a separate confirm-style form gated by the restricted `generate annotation documents` permission. Viewing documents needs `access annotation documents`; the `annotations_document` node type is access-gated to those permissions via `hook_node_access`. Requires drupal/ai, node, and annotations_context.

---

- Generate prose documentation for an annotation target with AI.
- Reuse the assembled annotation context as the AI input.
- Ship a default system prompt (AI prompt config entities) for generation.
- Strip untrusted raw HTML from AI output before storing it.
- Convert AI markdown to a safe HTML subset (league/commonmark).
- Store generated docs as unpublished `annotations_document` nodes.
- Keep a new node revision for each regeneration.
- Browse targets and their generated document status.
- View an individual generated document.
- Track when each target's document was last generated.
- Gate generation behind the restricted `generate annotation documents` permission.
- Gate viewing behind `access annotation documents`.
- Gate the document node type via `hook_node_access` / `hook_entity_create_access`.
- Fail clearly when no AI chat provider is configured.
- Provide a document-target field linking a node back to its annotation target.
- Support full administration via `administer annotation documents`.
