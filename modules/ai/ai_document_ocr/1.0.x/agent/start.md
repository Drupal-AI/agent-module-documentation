<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Document OCR Provider (ai_document_ocr) — agent index

Google Cloud Document AI provider for Drupal's AI module: converts PDFs/images to text (OCR). Version **1.0.x**, core `^10.4 || ^11.1 || ^12`, package "AI Providers".

Dependencies (modules): `ai:ai`, `key:key`, `ai:ai_automators`. Composer: `google/cloud-document-ai:^1.0`, `ext-openssl`. Configure at `/admin/config/ai/providers/document-ocr` (route `ai_document_ocr.ai_provider`, permission `administer ai_document_ocr`).

## What it provides
- **Operation type** `document_to_text` — registered via `hook_ai_operationtype_alter()` (`src/Hook/AiHooks.php`); plugin `Plugin\OperationType\DocumentToTextPlugin`; interface `OperationType\DocumentToText\DocumentToTextInterface`; input/output DTOs `DocumentToTextInput` / `DocumentToTextOutput`.
- **AI provider** `ai_document_ocr` — `Plugin\AiProvider\DocumentOcrProvider` (extends `AiProviderClientBase`, implements `DocumentToTextInterface`). Talks to Google Document AI via the `google/cloud-document-ai` SDK (`DocumentProcessorServiceClient`).
- **AI Automator** `document_processor` — `Plugin\AiAutomatorType\DocumentProcessor` (extends `ai_automators` `RuleBase`); runs OCR on `image`/`file` source fields, stores text into a `string_long` target field.
- **Config form** `Form\AiProviderConfigForm`; config object `ai_document_ocr.settings` (keys: `general_credentials_file`, `default_region`, `processor_id`); schema in `config/schema/`.
- **Model definitions** `definitions/api_defaults.yml` (single model `document_ocr`).
- **Hooks** `hook_help()` (`src/Hook/SystemHooks.php`), `hook_ai_operationtype_alter()`.
- **Permission** `administer ai_document_ocr` (restricted).

## Solution docs
- [Config & provider settings](config/settings.md) — Key credentials, region, processor discovery, config keys.
- [Provider API & operation type](api/document-to-text.md) — calling `documentToText()`, input/output DTOs, model defaults.
- [Automator: document_processor](plugins/document-processor.md) — automatic OCR on file/image fields.
