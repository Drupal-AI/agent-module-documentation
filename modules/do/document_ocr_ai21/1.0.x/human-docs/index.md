# Document OCR AI21 Studio — manual setup guide

**Document OCR AI21 Studio** (`document_ocr_ai21`) is an add-on for the
[Document OCR](../../../document_ocr/1.0.x/human-docs/index.md) module that runs
**AI21 Studio's NLP API** over text that Document OCR has already extracted from a
document. AI21 Studio is a natural-language-processing platform, and this module
brings two of its APIs into your OCR pipeline as **transformer plugins**:

- **Summarize** — produces a summary of the extracted text, with an optional
  `focus` hint to steer what the summary emphasizes.
- **Text Segmentation** — intelligently breaks long text into coherent, readable
  units based on topic and structure, which is handy for chunking a long document
  into manageable pieces.

You use it by adding AI21 transformer plugins to a Document OCR mapping, so that
after OCR extracts the text, AI21 post-processes it into a summary or into segmented
sections before the result is saved into Drupal. It has **no routes, forms, or
permissions of its own** — its entire surface is the transformer plugins it
contributes to Document OCR, configured alongside everything else at
`/admin/config/structure/document-ocr`.

A few operational notes. Credentials are **not** stored in module configuration:
you place a small JSON file containing your AI21 API key in Drupal's **private
filesystem** and point each transformer plugin at it (see
[Configuration](configuration/index.md)). The module calls AI21 over **HTTPS** with
standard TLS verification and Bearer authentication, and **every transform is a
billable AI21 API call** — so control who can configure and run the OCR
transformers, and remember that the extracted text is sent to AI21's service.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (Document OCR is required).
2. [Configuration](configuration/index.md) — get an AI21 API key, store it as a
   private-filesystem JSON credentials file, and point the transformers at it.

## Where it lives in the admin menu

There is no separate settings page. You configure this integration from within
Document OCR at **Configuration → Structure → Document OCR**
(`/admin/config/structure/document-ocr`), by adding AI21 transformer plugins to a
mapping and pointing them at your credentials file.
