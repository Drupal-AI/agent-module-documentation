<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Processor plugins (`document_ocr_processor`)

Ship in `src/Plugin/document_ocr/processor/`. Each declares the file `extensions` it accepts;
`Process::isExtensionSupported()` only runs a processor on files matching (regex on filename/URI).
`requirementsAreMet()` gates each on its library/binary being installed. All extend `ProcessorBase`.

| id | Name | group | extensions | Backend / notes |
|----|------|-------|-----------|-----------------|
| `google_document_ai` | Google Document AI | Google Cloud | pdf gif tiff tif jpg jpeg png bmp webp | `Google\Cloud\DocumentAI` client via service `document_ocr.google_documentai`. `requires = {credentials, template}`, `supports = {asynchronous, store_json}`. Only processor with async large-file handling (Google Cloud Storage) and JSON storage. |
| `tesseract_ocr` | Tesseract OCR | Shell Commands | jpg jpeg png | `thiagoalessio\TesseractOCR\TesseractOCR` (needs the `tesseract` binary). Config: user patterns/words files, `lang`, `psm`, `oem`, `dpi`. Extracts one property `extracted_text`. |
| `pdf_to_text` | PDFtoText (Poppler) | Shell Commands | pdf | `spatie/pdf-to-text` (needs Poppler `pdftotext` binary). |
| `pdf_parser` | PDF parser | (none) | pdf | Pure-PHP `smalot/pdfparser` — no system binary required. |
| `docconv_extractor` | Docconv Extractor | Shell Commands | pdf doc docx xml html rtf odt pages | `docconv` service/binary; broadest input format set. |
| `openai_audio` | OpenAI Audio | OpenAI | mp3 mp4 mpeg mpga m4a wav webm | `openai-php/client` audio transcription via service `document_ocr.openai`; transcribes audio to text. |

## Behaviour

- A processor is wired through a `document_ocr_processor` **config entity** (label, plugin id,
  `credentials` file path, `configuration`). `Process::processDocument()` sets the plugin's
  credentials/configuration/file, then calls `getMappingData()`; the returned plugin exposes
  extracted properties via `getOptions()` (labels) and `getValues()` (values) which the mapping
  tool and `saveEntity()` read.
- Extracted properties are opaque strings from the OCR backend; they are written into destination
  entity fields with normal `$entity->set()` (rendered later by the field's own formatter, so core
  escaping applies).
- Credentials for the SaaS processors (Google) are a service-account JSON file whose stored path
  is read from disk by `ProcessorBase::getCredentials()`; OpenAI/Azure keys live in the
  processor's `credentials`/`configuration`. See the README for provider setup.

See [plugin-types.md](plugin-types.md) for the interface/base-class contract and how to add a
processor.
