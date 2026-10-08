<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Document OCR Provider adds a Google Cloud Document AI provider to Drupal's AI module so documents and images can be converted to text with OCR.

---

The module registers a `document_to_text` operation type and an `ai_document_ocr` AI provider (`DocumentOcrProvider`) that sends PDFs and images to a Google Cloud Document AI processor and returns extracted text, an overall confidence score, and structured data (pages, paragraphs, entities). Credentials are a Google Cloud service-account JSON key stored in the Key module; the processor and region are chosen on the provider settings form at `/admin/config/ai/providers/document-ocr`, where enabled processors are auto-discovered across regions. A `document_processor` AI Automator (from `ai_automators`) can run OCR automatically when a file or image field is filled, writing the result into a `string_long` target field. Requires the `ai`, `key`, and `ai_automators` modules and the `google/cloud-document-ai` Composer library.

---

- Extract plain text from uploaded PDF documents with Google Document AI.
- OCR scanned images (JPEG, PNG, GIF, TIFF, BMP, WebP) into searchable text.
- Add a `document_to_text` capability to the Drupal AI framework for other modules to call.
- Store OCR results in a text field automatically when a node with a file/image field is saved.
- Convert invoices, receipts, and forms to text for downstream processing.
- Build a searchable archive from scanned paper documents.
- Generate text alternatives for image-only content to aid accessibility.
- Populate a summary or body field from an attached document via AI Automators.
- Index document contents for site search after upload.
- Extract structured data (pages, paragraphs, entities) alongside plain text.
- Filter extracted text by a configurable confidence threshold.
- Pick a specific Document AI processor (Document OCR, Form Parser, etc.) per site.
- Route requests to a chosen Google Cloud region (US, EU, or a regional endpoint).
- Auto-discover the enabled processors in a Google Cloud project across all regions.
- Keep Google service-account credentials out of the database using the Key module.
- Call the provider programmatically via `\Drupal::service('ai.provider')->createInstance('ai_document_ocr')`.
- Feed base64-encoded document bytes plus a MIME type to the provider through `DocumentToTextInput`.
- Retrieve confidence and structured data from `DocumentToTextOutput` (`getText()`, `getConfidence()`, `getStructuredData()`).
- Process multi-page PDFs and report the page count in the output metadata.
- Wire OCR into an automated content pipeline triggered by the AI Automators queue.
- Digitize handwritten or form documents by selecting an appropriate processor.
- Pre-fill content moderation or tagging workflows from extracted document text.
