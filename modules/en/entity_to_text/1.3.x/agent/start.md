<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity to Text (entity_to_text) — agent index

Developer-only helper APIs that convert Drupal content into clean **plain text**. Package `Search`.
Core `^10.4 || ^11 || ^12`. License GPL-2.0-or-later. Version 1.3.x.
Composer library requirement: **`ezyang/htmlpurifier` `^4.14`**. No routes, no permissions, no config
schema, no plugin types, no config entities.

## What it actually is

- Two container services in the base module (`entity_to_text.services.yml`):
  - `entity_to_text.extractor.node_to_text` → `NodeToText` (`src/Extractor/NodeToText.php`).
  - `entity_to_text.htmlpurifier` → `HtmlPurifier` (`src/HtmlPurifier.php`).
- Everything is called from PHP; there is no admin UI, block, or HTTP endpoint. Access control of the
  source entity is the caller's responsibility — the services render whatever entity/field you hand them.

## Solution docs

- **`NodeToText` — turn one node field into plain text** → [api/node-to-text.md](api/node-to-text.md)
- **`HtmlPurifier` — the strip-to-text config used by every extractor** → [api/html-purifier.md](api/html-purifier.md)

## Submodules (documented in their own trees)

- **`entity_to_text_paragraphs`** — `ParagraphsToText` service; converts a paragraph-reference field to an
  array of plain-text blocks. Requires `entity_to_text` + `drupal/paragraphs`.
  → [../modules/entity_to_text_paragraphs/1.3.x/agent/start.md](../modules/entity_to_text_paragraphs/1.3.x/agent/start.md)
- **`entity_to_text_tika`** — `FileToText` (Apache Tika extraction/OCR), `LocalFileStorage` (OCR cache under
  `private://`), `PreProcessFileEvent`, and Drush `e2t:t:w`. Requires `entity_to_text` +
  `vaites/php-apache-tika` + a reachable Tika server.
  → [../modules/entity_to_text_tika/1.3.x/agent/start.md](../modules/entity_to_text_tika/1.3.x/agent/start.md)
