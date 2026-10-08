<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity to Text - Paragraphs (entity_to_text_paragraphs) — agent index

Submodule of **Entity to Text**. One service that converts a Paragraphs reference field into an array of
plain-text blocks. Package `Search`. Core `^10.4 || ^11 || ^12`. License GPL-2.0-or-later. Version 1.3.x.

- Depends on `entity_to_text` (declared in `entity_to_text_paragraphs.info.yml`) and on the **Paragraphs**
  (`drupal/paragraphs`) module at runtime (uses `EntityReferenceRevisionsFieldItemList`).
- No routes, permissions, config schema, or plugin types.

## Solution docs

- **`ParagraphsToText` — paragraph-reference field to plain-text array** →
  [api/paragraphs-to-text.md](api/paragraphs-to-text.md)

Parent project index → [../../../../entity_to_text/1.3.x/agent/start.md](../../../../entity_to_text/1.3.x/agent/start.md)
