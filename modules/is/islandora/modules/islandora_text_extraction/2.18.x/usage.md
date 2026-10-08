Islandora Text Extraction runs OCR/text extraction on ingested files through the Hypercube microservice, stores the extracted text (and hOCR) as media, displays it, and reindexes it for full-text search.

---

The submodule provides Context Actions that extend Islandora Core's derivative actions to produce text:
`generate_ocr_derivative` (creates an **Extracted Text** media on the node) and `generate_extracted_text_file`
(attaches the extracted text **file** to media). Their defaults target the **Hypercube** OCR microservice
(`queue = islandora-connector-ocr`), read the `OriginalFile` (`http://pcdm.org/use#OriginalFile`) and write
an `ExtractedText` (`http://pcdm.org/use#ExtractedText`) derivative as `text/plain` into the `fedora` scheme,
`destination_media_type = extracted_text`. A dedicated controller
(`islandora_text_extraction.attach_file_to_media`, `PUT /media/add_ocr/{media}/{destination_field}/{destination_text_field}`,
same JWT/basic/cookie auth and access check as core) lets the microservice write both the file and a text
field back in one call. An `ocr_formatter` field formatter renders an OCR/hOCR file field as readable text,
and a `SearchReindexer` service pushes updated OCR content into Search API so the extracted text becomes
searchable. Depends only on `islandora`. No settings form or permissions of its own; the companion
`islandora_text_extraction_defaults` module ships ready-made media type/fields/context config.

---

- OCR scanned page images into machine-readable text on ingest.
- Extract embedded text from ingested PDFs.
- Route OCR jobs to the Hypercube microservice via the `islandora-connector-ocr` queue.
- Store extracted text as an `extracted_text` media on the object (`generate_ocr_derivative`).
- Attach an extracted-text file to existing media (`generate_extracted_text_file`).
- Write OCR results back over HTTP with the `/media/add_ocr/...` route (JWT-authenticated).
- Save both a text file and a text field in one microservice callback.
- Display OCR/hOCR content with the `ocr_formatter` field formatter.
- Index extracted text into Search API for full-text search across the repository.
- Reindex OCR content automatically via the `SearchReindexer` service when it changes.
- Use PCDM `OriginalFile` → `ExtractedText` term mappings for source/derivative.
- Store extracted text in the Fedora filesystem alongside other derivatives.
- Enable full-text search over digitized books, newspapers, and manuscripts.
- Provide highlightable text layers for IIIF viewers (paired with islandora_iiif hOCR support).
- Bootstrap a working OCR pipeline quickly with `islandora_text_extraction_defaults`.
- Regenerate extracted text by re-running the OCR Action on content.
