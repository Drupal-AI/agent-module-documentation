<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Document OCR (document_ocr) — agent index

A framework that extracts text/structured data from uploaded documents, images and audio via
pluggable **OCR processor** plugins and post-processes each value via **transformer** plugins,
then maps results into fields of Drupal entities. Package `AI`. Core `^9.5 || ^10 || ^11`.
License GPL-2.0-or-later. Installed version 1.0.14 (dir 1.0.x).

- **No declared module dependencies.** Uses core `file`, `views` (ships `views.view.document_ocr`),
  and entity/field APIs. Composer pulls OCR/AI libraries (Google Cloud Document AI / Storage /
  Translate / Text-to-Speech, `openai-php/client`, `smalot/pdfparser`,
  `thiagoalessio/tesseract_ocr`, `spatie/pdf-to-text`) — each processor works only if its library
  (and any system binary, e.g. `tesseract`, `pdftotext`, `docconv`) is present.
- **One permission:** `administer document ocr` (gates every route, directly or as the entities'
  `admin_permission`).
- **Configure route:** `entity.document_ocr_mapping.collection` → `/admin/config/structure/document-ocr`.

## What it provides

- **Two plugin types** (annotation-based) → [plugins/plugin-types.md](plugins/plugin-types.md):
  `document_ocr_processor` (manager `plugin.manager.document_ocr_processor`, base `ProcessorBase`)
  and `document_ocr_transformer` (manager `plugin.manager.document_ocr_transformer`, base
  `TransformerBase`).
- **6 processor plugins** (Google Document AI, Tesseract, PDFtoText, PDF parser, Docconv, OpenAI
  Audio) → [plugins/processors.md](plugins/processors.md).
- **8 transformer plugins** (Basic, Pipeline, Truncate, Encoding Converter, Google Translate,
  Microsoft Translate, Google Text to Speech, OpenAI Chat) → [plugins/transformers.md](plugins/transformers.md).
- **5 entities** → [entities/entities.md](entities/entities.md): config `document_ocr_mapping`,
  `document_ocr_processor`, `document_ocr_transformer`; content `document_ocr_task`,
  `document_ocr_data`.
- **Config, routes, permission, services, links** → [config/settings.md](config/settings.md).
- **Processing pipeline** (hooks, cron, batch, events, the `Process` service) →
  [api/processing.md](api/processing.md).

## Mechanism in one paragraph

`hook_entity_insert/update` (via `document_ocr.module` service) call `Process::processEntity()`,
which finds `document_ocr_mapping` entities whose `field_selector` matches the saved entity's
type/bundle, runs the mapping's processor plugin on each referenced file, transforms each mapped
property, and creates/updates the destination entity. Jobs become `document_ocr_task` content
entities with a status; real-time mappings process inline, others are set pending and run on cron
(`Process::processPendingOnCron()`) or via Batch API. Google Document AI can run asynchronously.
