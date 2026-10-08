<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Annotations Documents (annotations_docs) — agent index

AI-generated documentation nodes from assembled annotation context. Depends on `annotations`, `annotations_context`, `ai:ai`, `node`. See [generation.md](generation.md).

## Provides

- **Service** `annotations_docs.generator` (`DocumentGeneratorService`) — `generate(string $target_id): int` returns the saved node ID. Uses `@annotations_context.assembler`, `@annotations_context.renderer`, `@ai.provider`, `@keyvalue.expirable`.
- **Routes** (`annotations_docs.routing.yml`):
  - `annotations_docs.page` `/annotations/documents` (`_custom_access: DocumentsController::accessPage`).
  - `annotations_docs.target` `/annotations/documents/{annotation_target}` (same access) → `DocumentsController::targetPanel`.
  - `annotations_docs.generate` `/annotations/documents/generate/{annotation_target}` (`generate annotation documents`) → `GenerateDocumentForm`.
- **Controller** `DocumentsController`, **Form** `GenerateDocumentForm`, **Hooks** `AnnotationsDocsHooks` (`theme`, `node_access`, `entity_create_access`).
- **Permissions**: `access annotation documents`, `generate annotation documents` (restricted), `administer annotation documents` (restricted).
- **Config (install)**: content type `annotations_document` + body/target fields + form/view displays; AI prompt entities `ai.ai_prompt_type.annotations_docs__generate` and `ai.ai_prompt.annotations_docs__generate__default`.

## Notes for agents

- `accessPage()` = `access annotation documents` OR `administer annotation documents`. The `annotations_document` node type is additionally gated by `AnnotationsDocsHooks::nodeAccess` / `entityCreateAccess`.
- Generation is admin/restricted (`generate annotation documents`). AI output is treated as untrusted: `html_input => strip` + `allow_unsafe_links => FALSE` in the CommonMark conversion before storing to the `full_html` body field; the node is created unpublished.
- Throws `RuntimeException` when no default AI chat provider is configured or league/commonmark is missing.
