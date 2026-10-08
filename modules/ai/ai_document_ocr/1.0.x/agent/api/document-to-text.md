<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Provider API & the `document_to_text` operation type

## Operation type
Registered at runtime by `AiHooks::aiOperationtypeAlter()` (`hook_ai_operationtype_alter`): id `document_to_text`, class `Plugin\OperationType\DocumentToTextPlugin`, interface `OperationType\DocumentToText\DocumentToTextInterface`. `DocumentToTextPlugin::getDefinition()` advertises `supported_formats`: `application/pdf`, `image/jpeg`, `image/png`, `image/gif`, `image/tiff`, `image/bmp`, `image/webp`.

## Provider plugin
`Plugin\AiProvider\DocumentOcrProvider` (`#[AiProvider(id: 'ai_document_ocr')]`), extends `AiProviderClientBase`, implements `DocumentToTextInterface`.
- `getSupportedOperationTypes()` → `['document_to_text']`.
- `getConfig()` → `ai_document_ocr.settings` (immutable).
- `getApiDefinition()` / `getConfiguredModels()` / `getModelInfo()` read `definitions/api_defaults.yml` — one model, `document_ocr` (label "Document OCR").
- `isConfigured()` → TRUE when `general_credentials_file` is set. `isUsable()` is permissive (returns TRUE for config purposes; checks operation type when given one).
- `loadModelsForm()` adds per-model fields: `processor_id` (defaults to global `processor_id`, disabled when the global one is set), `extract_structured_data` (default TRUE), `confidence_threshold` (default 0.8).
- `setAuthentication()` is a no-op — auth is entirely config/Key-driven.

## Calling it
```php
$provider = \Drupal::service('ai.provider')->createInstance('ai_document_ocr');
$input = new \Drupal\ai_document_ocr\OperationType\DocumentToText\DocumentToTextInput(
  base64_encode($bytes), $mime_type, $filename,
);
$output = $provider->documentToText($input, 'document_ocr', $tags);
$text  = $output->getText();
$score = $output->getConfidence();
$data  = $output->getStructuredData();
```

### `documentToText(string|DocumentToTextInput $input, string $model_id, array $tags = [])`
1. Throws `AiBadRequestException` if `!isConfigured()`.
2. Resolves `project_id` (from credentials), `region` (config `default_region` ?? `us`), `processor_id` (model info ?? config). Missing processor or project id → `AiBadRequestException`.
3. If `$input` is a string it is treated as a base64 PDF (`application/pdf`); otherwise reads content/MIME/filename off `DocumentToTextInput`.
4. `createDocumentAiClient()` builds a `Google\Cloud\DocumentAI\V1\Client\DocumentProcessorServiceClient` with the decoded service-account `credentials`. The content is `base64_decode`d (falls back to raw bytes on failure) into a `RawDocument`; the request name comes from `$client->processorName($project, $region, $processor)`; `processDocument()` is called.
5. Response is normalized into pages/paragraphs/entities using defensive `method_exists()` checks. Text is optionally filtered by `filterTextByConfidence()` when the threshold (from `$tags['confidence_threshold']` ?? model info ?? config ?? 0.8) > 0. Overall confidence via `calculateOverallConfidence()`. Structured data via `extractStructuredData()` when enabled. Any failure is wrapped in `AiBadRequestException`.

Text-anchor slicing (`getTextFromTextAnchor()`) clamps start/end indices to the document-text bounds before `substr()`.

## Output DTO — `DocumentToTextOutput`
Implements `ai\OperationType\OutputInterface`. Getters: `getNormalized()` (=text), `getText()`, `getConfidence()`, `getStructuredData()`, `getRawOutput()`, `getMetadata()`, plus `getPages()/getParagraphs()/getEntities()/getTables()` (slices of structured data) and `toArray()`. Metadata carries page count, MIME type, filename, processor id and location.

## Input DTO — `DocumentToTextInput`
Extends `ai\OperationType\InputBase`. Constructor `(string $document_content /* base64 */, string $mime_type, ?string $filename = NULL)` with matching getters and a `toString()` summary.
