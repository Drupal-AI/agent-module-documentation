<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Annotations Documents — generation flow

## `DocumentGeneratorService::generate($target_id)` (`src/DocumentGeneratorService.php`)

1. Loads the `annotation_target`; throws `RuntimeException` if missing.
2. Requires a default AI chat provider (`aiProvider->operationTypeHasDefault('chat')`) and the `league/commonmark` class; throws otherwise.
3. Assembles the target's context with `inc_meta => TRUE` and renders it to markdown (`ContextRenderer`).
4. Builds a `ChatInput` with the shipped system prompt (`systemPrompt()`, from `DEFAULT_PROMPT_ID = annotations_docs__generate__default`) + a user message wrapping the context, and calls `chat()` on the set provider/model.
5. `html_entity_decode()`s the response, then converts markdown → HTML with `new CommonMarkConverter(['html_input' => 'strip', 'allow_unsafe_links' => FALSE])` — AI output is treated as untrusted, so any raw HTML from the provider is discarded.
6. Loads or creates the target's `annotations_document` node (title = target label, `status = NOT_PUBLISHED`, `annotations_doc_target = target_id`), sets `annotations_doc_body` `{value, format: full_html}`, marks a new revision ("Generated via Annotations Documents"), and saves.
7. Records the generation timestamp in key-value collection `annotations_docs.generated` (2-year expiry, display only). Returns the node ID.

## Content model (`config/install/`)

- Node type `annotations_document`; fields `annotations_doc_body` (text_long, `allowed_formats: {}`) and `annotations_doc_target` (string) with storage + form/view displays. Body view formatter `text_default`.
- AI config: `ai.ai_prompt_type.annotations_docs__generate` and `ai.ai_prompt.annotations_docs__generate__default`.

## Access (`src/Hook/AnnotationsDocsHooks.php`)

- `node_access` on `annotations_document` nodes and `entity_create_access` for the bundle gate view/create to `access annotation documents` / `administer annotation documents`. Removing create access also drops the type from the "Add content" menu.
- `theme` registers the documents-browser theming.

## UI

`DocumentsController::page` (`/annotations/documents`) lists targets with a status chip (label escaped via `Html::escape` in `Markup::create`); `targetPanel` shows one target's document; `GenerateDocumentForm` (`generate annotation documents`) runs `generate()` for the target.
