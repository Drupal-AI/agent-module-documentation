# Document OCR Mindee — manual setup guide

**Document OCR Mindee** (`document_ocr_mindee`) is an add-on for the
[Document OCR](../../../document_ocr/1.0.x/human-docs/index.md) module that adds
**Mindee** as an OCR provider. Mindee is a fast, accurate document-parsing API; with
this module, Document OCR can send an uploaded document or image to Mindee's API and
receive back extracted, parsed data — a good fit for automated document data capture
(receipts, invoices, IDs, and similar structured documents).

You use it by adding a **Mindee processor** in Document OCR, so that when a document
is processed, Mindee performs the OCR/parsing and the results flow through your
Document OCR mappings into Drupal entities. It depends on the **Document OCR** module
and supports Drupal 9.5+, 10, and 11.

Two things to keep in mind. The Mindee **API key is a secret** — this module reads it
from a JSON file in Drupal's **private filesystem** (see
[Configuration](configuration/index.md)), keeping it out of configuration and version
control. And processing **sends your documents to Mindee's API over HTTPS**, so
confirm that transmitting the content to a third-party service is acceptable for your
data.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (Document OCR is required).
2. [Configuration](configuration/index.md) — get a Mindee API key, store it as a
   private-filesystem JSON credentials file, and add the Mindee processor.

## Where it lives in the admin menu

There is no separate settings page. You configure the Mindee integration from within
Document OCR at **Configuration → Structure → Document OCR**
(`/admin/config/structure/document-ocr`), by adding a Mindee processor and pointing
it at your credentials file.
