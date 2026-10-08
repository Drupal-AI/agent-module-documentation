# DL (Document Library) — manual setup guide

**DL** (`dl`) is a comprehensive document‑management system for Drupal — a place to
upload, organize, browse, search and download documents, with a modern card‑based
interface. It gives you hierarchical folders with slug‑based URLs, version control
with a changelog and preserved file history, advanced search and filtering,
download tracking (with user, IP and timestamp), a favorites feature, and a
dedicated admin interface with filtering and bulk actions. It's built on core
**Node**, **File**, **Views**, **Taxonomy** and **User**, and defines its own
granular permission system (a dozen distinct permissions).

The visitor‑facing library lives at **`/documents`**, with search at
`/documents/search`, favorites at `/documents/favorites`, and an admin view at
`/admin/content/documents`. Editors upload documents through a form (title,
description, folder, file, version, tags, published status — with drag‑and‑drop
supported), and uploading a new file during an edit creates a new version while
preserving the old one. Folders can be created, edited, moved and deleted, and the
UI adds niceties like breadcrumb navigation, file‑type icons, keyboard shortcuts
(Ctrl+K to search, Ctrl+U to upload) and a statistics dashboard.

One thing to plan deliberately: **documents are files**, so decide how they're
stored and protected. If some documents should be restricted, put them in
Drupal's **private file scheme** with access control — public files are served
directly by the web server regardless of any listing's access checks, so a
private‑file setup is what actually keeps restricted documents from being
downloaded by URL. Keep upload permissions to trusted roles, and gate the library
through its permissions and your file‑field settings. Beyond core node/file access
plus its own permissions, the module has no special access‑control role.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its core dependencies.

Configuration is done through the library's own pages and the standard permissions
and file‑storage settings rather than a single settings form, so the setup steps
are described in "How to use it" below.

## Where it lives in the admin menu

The visitor library is at **`/documents`**; the admin management view is at
**`/admin/content/documents`**. Permissions are granted on **People →
Permissions**, and file storage is governed by your file‑field and file‑system
settings.

## How to use it

1. After enabling, grant the appropriate DL permissions to your roles on **People
   → Permissions** — keep upload and management permissions to trusted roles.
2. Decide on file storage. For any restricted documents, configure the **private
   file scheme** so files aren't web‑served directly; public files bypass listing
   access.
3. Visit **`/documents`** and use **Upload Document** to add a document — fill in
   the title (required), description, folder, file (required, drag‑and‑drop
   supported), version number, tags and published status.
4. Organize documents into hierarchical **folders**, and browse or search them at
   `/documents` and `/documents/search`. Users can mark favorites at
   `/documents/favorites`.
5. Manage documents in bulk (publish/unpublish/delete) and review download
   activity logs from the admin view at **`/admin/content/documents`**.
6. Uploading a new file while editing a document creates a new **version**;
   previous versions are preserved and visible in the document's version history.
