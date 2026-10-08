# Document Loader: PHPWord — manual setup guide

**Document Loader: PHPWord** (`document_loader_phpword`) is a **loader plugin for
[Document Loader](../../../document_loader/2.0.x/human-docs/index.md)** that extracts
content from **word-processor documents** using the `phpoffice/phpword` PHP library.
It lets Document Loader read Microsoft Word, OpenDocument, and Rich Text files and
return their content in a normalized form for downstream use — indexing, migration,
or AI pipelines.

Supported input formats are **Word 2007+ (`.docx`)**, **Word 2003 (`.doc`)**,
**OpenDocument Text (`.odt`)**, and **Rich Text Format (`.rtf`)**. Output can be
produced as **text**, **HTML**, or **Markdown**. Once enabled it simply becomes one
of the loaders Document Loader can dispatch to.

This is an import/export developer feature with **no admin form and no permissions
of its own** — it is configured through Document Loader and driven in code. As with
any document parser, treat input files as untrusted and keep the underlying library
patched. It depends on the **Document Loader** module and supports Drupal 10.4+, 11,
and 12.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (it pulls in the
   `phpoffice/phpword` library) and enable the module.

There is **no configuration page** for this module. After enabling it, the PHPWord
plugin appears at **Configuration → Media → Document Loader**
(`/admin/config/media/document-loader`); there is no per-plugin form to fill in.

## Where it lives in the admin menu

The plugin is listed in the Document Loader configuration at **Configuration → Media
→ Document Loader** as an available loader. It adds no settings page of its own — set
it as the handler for the Word/document loader type on Document Loader's own settings
page if needed.
