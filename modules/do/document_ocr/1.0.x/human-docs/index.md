# Document OCR — manual setup guide

**Document OCR** (`document_ocr`) turns uploaded documents and scans into
**structured Drupal data**. It is an integration layer for OCR and
document-understanding services — most notably **Google Document AI** — that sends an
uploaded image or PDF to the service, receives text (and, where supported, extracted
fields such as the totals on a receipt or the boxes on a tax form), and **maps those
values into Drupal entities** according to mappings you define.

It is deliberately extensible. Processing is built from pluggable **processors**
(which talk to an OCR engine) and **transformers** (which preprocess or reshape the
data before it is saved). Out of the box it ships Basic, Pipeline, and OpenAI
transformer plugins, and it integrates with a broad set of engines and services —
Google Document AI (including large PDFs via Google Cloud Storage), Google
Translation, Google Text-to-Speech (to generate an MP3 from extracted text), the
PDF Parser PHP library, Tesseract, PDFtoText (Poppler), docconv, and OpenAI /
Microsoft Azure OpenAI. A **Pipeline** transformer lets you stack several
transformers and control their order.

Typical uses: extract a PDF's contents as text, pull each field out of a form,
summarize or translate extracted content, create Drupal entities pre-filled from
document contents, or transcribe and translate audio. Processing can run in
real time or through the queue, and you can optionally store the raw API response as
JSON. Two companion modules extend the provider list further:
[Document OCR Mindee](../../../document_ocr_mindee/1.0.x/human-docs/index.md) and
[Document OCR AI21 Studio](../../../document_ocr_ai21/1.0.x/human-docs/index.md).

**Data-handling caveats worth settling first.** The processor plugins **send document
content to an external service** (for example Google Cloud) — that is outbound
egress of potentially **sensitive** documents, so confirm it is acceptable for your
data. And the service **credentials are secrets**: store them safely, never in
committed configuration. The module has no access-control role beyond its own
`administer document ocr` permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it pulls in the
   required dependencies) and enable the module.
2. [Configuration](configuration/index.md) — set up mappings, processors and
   transformers, and store your service credentials securely.

## Where it lives in the admin menu

Document OCR is configured under **Configuration → Structure → Document OCR**
(`/admin/config/structure/document-ocr`; the configure route is the mapping
collection, `entity.document_ocr_mapping.collection`). From there you manage
mappings, document processors, transformers, and the one-time import tool. Access is
gated by the **Administer document OCR** permission.
