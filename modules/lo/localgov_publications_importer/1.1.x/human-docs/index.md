# LocalGov Publications Importer — manual setup guide

**LocalGov Publications Importer** (`localgov_publications_importer`) automatically
turns uploaded **PDF files** into **LocalGov HTML publications**. An editor uploads
a PDF, and the module extracts its text, images and links and builds a publication
node tree (a cover/first page and its child chapter pages) — so a council can move a
back‑catalogue of PDFs into accessible, searchable web pages without retyping them.

The work happens through a configurable, plugin‑driven pipeline. Each import runs
through an **Extract** step (the default uses the Smalot PDF parser to pull out
text, images and links), any number of **Transform** steps (shaping images,
normalising line breaks, capping the number of pages), and a **Save** step (which
builds the publication and its pages). Pipelines are configuration entities, so you
can create several — one recipe per kind of document — and choose which to use for
each upload.

Imports are processed in the background, not at upload time: either on **cron** or by
running a **Drush command** on demand. An optional submodule,
**`localgov_publications_importer_ai`**, adds an AI transform that cleans up the
extracted text with a large language model for better headings and lists — see the
note about that below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (and, optionally, the AI submodule).
2. [Configuration](configuration/index.md) — the settings form (cron processing and
   per‑run limits) and how to set up import pipelines and the optional AI provider.

## Where it lives in the admin menu

- Upload and track imports at **Content → Imports**
  (`/admin/content/imports`); the upload form is at
  `/admin/content/imports/create`.
- The settings form is at **Configuration → System → LocalGov Publications
  Importer** (`/admin/config/system/localgov-publications-importer`), which also
  links to the **Import Pipelines** management screen.
- Permissions (create/view/delete‑own imports and pipeline management) are set at
  **People → Permissions** under the module's sections.

## How to use it

1. Enable the module and create at least one **import pipeline** (the module ships a
   sensible default recipe).
2. Go to **Content → Imports** and upload a PDF, choosing the pipeline to use.
3. Wait for **cron** to process it, or run it immediately with
   `drush localgov_publications_importer:import` (alias `drush lpii`).
4. When the import completes, the Imports list shows a link to the resulting
   publication.

Requires the **LocalGov Publications** module, since it builds publications; it is
part of the LocalGov Drupal distribution.
