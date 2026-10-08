<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Document OCR extracts text and structured data from uploaded documents, images and audio using pluggable OCR services, then maps the results into fields of Drupal entities.

---

Document OCR is an extraction framework, not a single OCR engine. It defines two plugin types — OCR *processors* (that read a file and return text/properties) and property *transformers* (that post-process a value before it is stored) — and ships integrations for Google Document AI, Tesseract, PDFtoText (Poppler), the smalot/pdfparser PHP library, Docconv, and OpenAI audio transcription, plus transformers for translation (Google/Microsoft), text-to-speech (Google), OpenAI chat summarisation, truncation, encoding conversion and pipelines. Administrators define a *mapping* config entity that binds a source entity/bundle field (holding the file) to a processor and to a destination entity/bundle, then use a visual mapping tool to pair extracted document properties with destination fields (optionally routing each through a transformer). Files are processed in real time when a source entity is saved, or queued and handled on cron; Google Document AI additionally supports an asynchronous mode for large PDFs via Google Cloud Storage. A one-time import tool lets you upload and process files ad hoc, and extracted API responses can be stored as JSON. Everything lives under Configuration → Structure → Document OCR and is gated by the single `administer document ocr` permission.

---

- Extract the text of uploaded PDFs into a body/text field on a node.
- OCR scanned images (JPG/PNG) into text with Tesseract OCR.
- Parse structured fields (dates, totals, line items) from receipts, invoices or tax forms with Google Document AI form parsers.
- Train Google Document AI on your own custom form layouts and import each detected element as a separate property.
- Import PDF contents into a custom "Document" content type as new nodes automatically on file upload.
- Store the raw processor API response alongside each processed file as JSON for later reuse.
- Summarise long PDF contents with an OpenAI Chat transformer before saving to a summary field.
- Transcribe MP3/MP4/WAV audio files to text with the OpenAI Audio processor.
- Translate extracted text into another language with a Google Translate or Microsoft Translate transformer.
- Generate an MP3 narration of extracted text with the Google Text to Speech transformer and attach it to a file field.
- Extract text from DOC, DOCX, ODT, RTF, HTML, XML and PAGES files via the Docconv extractor.
- Extract PDF text with the pure-PHP smalot/pdfparser processor when no shell binaries are available.
- Chain several transformers (e.g. trim → translate → truncate) with the Pipeline transformer and control their order.
- Trim, normalise or regex-manipulate an extracted property with the Basic transformer before storage.
- Safely truncate extracted text to a maximum character count with the Truncate transformer.
- Convert extracted text between character encodings with the Encoding Converter transformer.
- Process only new files, or also re-process files when existing source entities are updated (per-mapping setting).
- Queue historical/older content for OCR processing in bulk via the "Queue Older Entities" tool.
- Run heavy OCR work off the request via the pending-task queue processed on cron instead of in real time.
- Retry failed jobs automatically up to a configurable attempt limit, then mark tasks as failed.
- Bulk-upload a batch of files through the one-time import tool and map them to a destination bundle without a persistent mapping.
- Automatically clean up processed destination entities and task records when the source file is deleted.
- Build a new processor or transformer integration (e.g. another OCR SaaS) by implementing the module's plugin interfaces.
- Track the status (Initiated/Pending/Processed/Failed) of every document job on the Tasks listing view.
