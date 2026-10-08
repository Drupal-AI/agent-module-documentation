# AI Document OCR — manual setup guide

**AI Document OCR** (`ai_document_ocr`) adds a Google Document AI (OCR) provider
to the Drupal AI stack, so your site can extract the text out of documents —
scanned pages, PDFs and similar files — using Google's document-understanding
service. Once installed, that extraction becomes available as a building block
for AI automators and other AI workflows.

Being a provider, the module doesn't add a page of its own to click around in.
Instead it plugs into the AI module and the AI Automators framework, where you
select and use it as the OCR step in a larger flow. The heavy lifting happens at
Google's end: the documents you process are sent to Google Document AI and the
extracted text comes back.

Two things are worth understanding before you rely on it. First, this is an
**egress** — the documents you run through it leave your site and are processed
by Google under Google's terms, so confirm that is acceptable for the content
you handle. Second, the credentials it uses are a secret and are stored through
the **Key** module, never pasted into plain configuration.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module and its dependencies, and store the Google credentials as a Key.

## Where it lives in the admin menu

AI Document OCR has no settings page of its own (`configure` is null). You use it
by selecting the Google Document AI provider inside the AI module's provider
configuration and inside AI Automator steps, once its credentials are in place.

## How to use it

1. Store your Google Document AI credentials as a **Key** entity (see
   [Installation](installation/index.md)) and configure the provider through the
   AI module.
2. Build an AI Automator (or use another AI workflow) that includes an OCR /
   text-extraction step, and point it at the Google Document AI provider this
   module supplies.
3. When the workflow runs, the document is sent to Google Document AI and the
   returned text is available to the rest of your pipeline — for example to
   summarize, index, or store.

Remember the extracted content originated from files that were sent to an
external service; handle anything confidential accordingly.
