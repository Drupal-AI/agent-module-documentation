# OpenIntranet Documents — manual setup guide

**OpenIntranet Documents** (`openintranet_documents`) is a hierarchical document
management system for Drupal. It gives your site a dedicated place to store and
organise files in nested folders, upload documents with a title and description,
browse them through a Bootstrap 5 interface at `/documents`, and search across
document titles, descriptions, and filenames. It was built as part of the **Open
Intranet** distribution — Droptica's intranet product — but it can be installed
on its own.

Think of it as a lightweight internal document library: editors create folders,
drop files into them, and everyone with the right permission can browse and
download. Folders can be nested without limit, files get automatic type icons
(PDF, Word, Excel, PowerPoint, images, and so on), and adding folders or
uploading documents happens through AJAX modal dialogs rather than full page
reloads.

Because this is a document store, its most important setting is not a form field
— it is your **access model**. The documents and folders can hold confidential
organisational content, so decide carefully who may view, add, and manage them
(configured through Drupal's permissions), and make sure document files are served
through access checks rather than being fetchable directly by URL. Confirm the
access model matches your organisation's confidentiality needs before you put
anything sensitive in it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and set up permissions.

There is **no dedicated settings form** for this module — it works out of the box.
Everything you tune is either a Drupal permission or done inside the document
browser itself, described in "How to use it" below.

> **Heads up:** This module was developed and tested inside the Open Intranet
> distribution. It may work on a standard Drupal site, but full compatibility is
> only guaranteed within the Open Intranet ecosystem.

## Where it lives in the admin menu

There is no configuration page under **Configuration**. The document browser lives
at **`/documents`**, and permissions are set at **People → Permissions**
(`/admin/people/permissions`).

## How to use it

1. After enabling the module (see [Installation](installation/index.md)), visit
   **`/documents`** to open the main document browser.
2. Use the toolbar icons at the top of the browser to **create a folder** or
   **upload a document** — both open in a modal dialog. When uploading, give the
   file a title, an optional description, and choose the folder it belongs to.
3. Navigate into folders using the breadcrumb trail; create as many nested levels
   as you need.
4. Use the search box to find documents by title, description, or filename.
5. Click a document to download it (the module sends proper download headers).

Before storing anything confidential, review who can reach the browser and its
files at **People → Permissions**, and confirm your file storage and access setup
does not let someone bypass folder permissions by requesting a file URL directly.
