# AI Automator: Pandoc — manual setup guide

**AI Automator: Pandoc** (`ai_automator_pandoc`) adds a document-conversion step
to Drupal's [AI Automators](https://www.drupal.org/project/ai) framework. It takes
an uploaded Word (`.docx`) or PDF file and converts it to clean HTML using
[pandoc](https://pandoc.org/), the well‑known document converter — so a document
you import can automatically populate a rich‑text field as part of an AI‑driven
content workflow.

You don't use this module on its own. It registers a new *automator* that you
attach to a field: when content is created or imported with a source document,
the automator runs pandoc on the server and writes the resulting HTML into the
target field. That makes it a building block for document‑to‑content pipelines
rather than something with its own page to click.

Because conversion runs the pandoc program on your server, **pandoc must be
installed in the environment** where Drupal runs (for example inside your DDEV
web container). Uploaded files are processed server‑side, so treat the source of
any document you convert as untrusted and only let people you trust feed
documents into the pipeline.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, make sure
   pandoc is available on the server, and enable the module.

## How to use it

This module has no settings page of its own. Once it and the AI Automators module
are enabled, the pandoc converter appears as an available automator when you
configure the AI Automators behaviour on a field:

1. On a content type, edit a rich‑text (formatted long‑text) field and enable an
   AI Automator on it.
2. Choose the **pandoc** document‑conversion automator as the automator type, and
   point it at the source document field that holds the uploaded Word/PDF file.
3. When content is saved or imported with a document attached, the automator runs
   pandoc and fills the rich‑text field with the converted HTML.

Requires the AI Automators module (`ai_automators`) and core `system`. Works on
Drupal 10.4+, 11, and 12.
