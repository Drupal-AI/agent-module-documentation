# Islandora Text Extraction — agent index

OCR / text extraction via the Hypercube microservice: derivative Actions, an OCR-writeback route, a text
formatter, and Search API reindexing. Depends on `islandora`. No settings form, no permissions of its own.
Default media type/fields/context are shipped by the companion `islandora_text_extraction_defaults` module.

- **Actions, the OCR-attach route, the `ocr_formatter`, and the reindexer** →
  [plugins/ocr.md](plugins/ocr.md)

Key facts:
- Actions extend Islandora Core's derivative actions:
  - `generate_ocr_derivative` (new `extracted_text` media) — defaults: `queue=islandora-connector-ocr`,
    `mimetype=text/plain`, `source_term_uri=http://pcdm.org/use#OriginalFile`,
    `derivative_term_uri=http://pcdm.org/use#ExtractedText`, `scheme=fedora`,
    `path=[date:custom:Y]-[date:custom:m]/[node:nid]-[term:name].txt`.
  - `generate_extracted_text_file` (attach text file to media).
- Route `islandora_text_extraction.attach_file_to_media`:
  `PUT|GET /media/add_ocr/{media}/{destination_field}/{destination_text_field}` (auth basic/cookie/jwt;
  access = core `attachToMediaAccess` = media `update`).
- Formatter `ocr_formatter` (`src/Plugin/Field/FieldFormatter/OcrTextFormatter.php`, `field_types = {file}`).
- Service `islandora_text_extraction.search_reindexer` (`SearchReindexer`) pushes updated OCR text to Search
  API.
