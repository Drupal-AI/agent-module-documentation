<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Automator: `document_processor`

`Plugin\AiAutomatorType\DocumentProcessor` (`#[AiAutomatorType(id: 'document_processor', label: 'Document Processor', field_rule: 'string_long', target: '')]`) extends `ai_automators` `RuleBase` and implements `AiAutomatorTypeInterface`. It runs Google Document AI OCR automatically when an entity is saved, writing extracted text into a `string_long` target field.

## What it declares
- `llmType` = `document_to_text`; `title` = "Document Processor".
- `allowedInputs()` → `['image', 'file']` — the source (base) field must be an image or file reference field.
- `placeholderText()` → "Extract text from uploaded documents using OCR".
- `verifyValue()` accepts any string; `storeValues()` sets the target field to the produced values.

## How it runs (`generate()` → `processDocumentFile()`)
1. `generate()` reads `$automatorConfig['base_field']`; if the entity lacks it or it is empty, returns `[]`. It iterates each referenced file item and OCRs `$item->entity`.
2. `processDocumentFile()`:
   - Reads `ai_document_ocr.settings` for `general_credentials_file`, `processor_id`, `default_region`; throws if credentials or processor are missing.
   - Loads the Key entity via `entityTypeManager->getStorage('key')->load()` and `json_decode`s its value; requires a `project_id`.
   - Logs project/region/processor at info level (`ai_document_ocr` channel) — no secret values are logged.
   - Reads the referenced file's bytes (via the file system service / stream URI) for the configured source field.
   - Builds a `DocumentProcessorServiceClient` (`apiEndpoint => "{region}-documentai.googleapis.com"`, `credentials => $decoded`), constructs `processorName($project, $region, $processor)`, sends a `ProcessRequest` with a `RawDocument` (content + `$file->getMimeType()`), and reads `$response->getDocument()`.
   - Returns `['text' => $document->getText(), 'confidence' => avg page-layout confidence, 'structured_data' => [], 'metadata' => pages/mime/filename]`. On any exception it logs and returns NULL (the field is left unset for that item).

## Configure
1. Add an image or file field (source) and a `string_long` text field (target) to a bundle.
2. On the target field's AI Automator settings, enable **Document Processor** and choose the source field as the base field.
3. Ensure the provider is configured (see [config/settings.md](../config/settings.md)) — the automator reuses the same `ai_document_ocr.settings` credentials/processor/region. Note it reads `default_region` directly (no `us` fallback here), so `default_region` must be set for the automator path.

Runs synchronously on entity save, or via the AI Automators queue/batch when configured for background processing.
