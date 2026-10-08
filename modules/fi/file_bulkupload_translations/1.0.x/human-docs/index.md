# File Bulkupload Translations — manual setup guide

**File Bulkupload Translations** (`file_bulkupload_translations`) removes the tedium
of managing multilingual file fields. Normally, adding a file in ten languages means
ten round-trips: open the form, upload, save, switch language, repeat. This module
lets you drop **all** the translated files at once — `report_en.pdf`,
`rapport_fr.pdf`, `bericht_de.pdf`, and so on — and it creates every translation
automatically. What used to take minutes takes seconds.

It figures out each file's language from its **filename**, using a configurable
pattern. Three modes are built in: **Suffix** (`report_en.pdf`,
`document-fr.docx`), **Prefix** (`en-report.pdf`, `fr_document.docx`), and a
**Custom regex** for anything else. A **live regex tester** right on the widget lets
you paste your filenames, pick a mode, and see exactly what gets extracted —
highlighted in context with a green/red status per file — before you commit.

It is careful about mistakes: a file whose language code is not enabled on your site
is rejected with a clear message, two files for the same language in one upload are
blocked, and an invalid regex is flagged immediately by the tester. You can also
manage existing translations right inside the widget — a table lists them, and you
can edit any translation in a modal or remove one with a click, all AJAX-powered with
no page reload. Finally, you choose how new translations are published: **match the
source** entity's status, **always published**, or **always unpublished** (for review
workflows).

It depends on Drupal's core **Content Translation**, **Field UI**, and **Media**
modules.

> **Note:** This project is **not covered by Drupal's security advisory policy** —
> weigh that before relying on it for a high-stakes site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (with its core dependencies and languages configured).

There is **no central settings page**. The upload behavior (mode, regex, publish
status) is configured on the **field widget** you enable, described in "How to use
it" below.

## Where it lives in the admin menu

File Bulkupload Translations adds no page of its own. You configure it on a media (or
file-field) entity's **Manage form display**, where you enable its bulk-upload
widget and set its options.

## How to use it

1. Make sure your site has **more than one language** enabled and that the relevant
   media type / file field is **translatable** (Content Translation).
2. On the entity's **Manage form display**, enable the module's bulk-upload widget
   for the file/media field, and configure it:
   - **Mode** — **Suffix**, **Prefix**, or **Custom regex** — to say where the
     language code sits in the filename.
   - Use the **live regex tester** to paste sample filenames and confirm the correct
     language code is extracted (green) before saving.
   - **Publish status for new translations** — match the source, always published, or
     always unpublished (draft).
3. When creating/editing content, upload all your translated files in one operation.
   The module extracts each file's language from its name and creates (or updates)
   every translation instantly, rejecting files whose language is not enabled or that
   duplicate a language in the same batch.
4. Manage the results from the widget's translations table — edit a translation in a
   modal or remove one — without leaving the form.
