<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Unstructured is a Drupal client for Unstructured.io — a service (hosted SaaS or self-hosted container) that takes a document (PDF, Word, PowerPoint, image, email, HTML, markdown, and others) and returns its contents as structured elements, which the module turns into field values.

---

Getting clean text out of a PDF or scanned image is the kind of task that looks trivial until you try it; Unstructured.io does the machine-learning parsing and OCR, and this module supplies the Drupal side. It ships one service, `unstructured.api` (`UnstructuredApi`), that POSTs a Drupal file to the Unstructured `general/v0/general` endpoint and returns the parsed element array. Three formatters (`unstructured.text_formatter`, `unstructured.markdown_formatter`, `unstructured.html_formatter`) turn that element array into plain text, markdown, or HTML — extracting embedded images and rendering tables. On top of these sit four AI Automator plugins — `FileToText` (text_long), `FileToString` (string_long), `FileToTable` (tablefield) and `FileToImage` (image) — so an uploaded file field can drive another field's value with no custom code, choosing element types, output format, split mode, and OCR strategy from the automator form. The module can run against the hosted API (needs an API key stored as a Key entity) or against a self-hosted `unstructured-api` container (host name only, no key), and the README documents a DDEV recipe for the local case. The parsing service is also usable directly from custom code via `\Drupal::service('unstructured.api')->structure($file, $options)`.

---

- Extract plain text from an uploaded PDF into a text field.
- Extract text from a Word (.doc/.docx) or PowerPoint (.ppt/.pptx) document.
- OCR a scanned image (.jpg/.jpeg) into a text field.
- Parse an email (.eml/.msg) or HTML file into structured text.
- Extract tables from Excel, PDFs, Word files or images into a TableField.
- Extract embedded images from a PDF into an image field.
- Return parsed content as plain text.
- Return parsed content as markdown (with images written to the public files directory).
- Return parsed content as HTML (with tables and inline images).
- Split output per page, per element, or as one combined value.
- Restrict extraction to chosen element types (titles, list items, headers, footers, formulas, images).
- Choose an OCR/partition strategy: auto, fast, hi-res, or OCR-only.
- Pick a hi-res layout model (Detectron2, YOLOX, Chipper) for complex documents.
- Bypass the API when an uploaded text/markdown/HTML file already matches the requested output format.
- Drive an AI Automator chain from a file field with no custom code.
- Run against the hosted Unstructured.io SaaS API.
- Run against a self-hosted Unstructured container.
- Run locally in DDEV with no API key.
- Store the hosted API key as a Key entity.
- Call the `unstructured.api` service directly from custom code or a Drush script.
- Feed extracted document text into other AI Automator steps for summarisation or tagging.
