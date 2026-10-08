# Geysir — manual setup guide

**Geysir** (`geysir`) lets content authors add, edit, delete, reorder (cut/paste),
and translate individual **Paragraphs** directly from the rendered front end of a
node, using AJAX modal dialogs — instead of opening the full node edit form in the
backend. For Paragraph-based landing pages and page-builder layouts, it makes editing
feel much more direct: hover a paragraph, click *Edit*, tweak it in a modal, and the
page updates in place.

It works on any **Entity Reference Revisions** field that targets **paragraph**
entities on a **node**. When an authorized user views such a node, Geysir injects
per-paragraph action buttons (Add before/after, Edit, Delete, Cut, Paste, Translate)
that open Drupal modal forms. Saving re-saves a new revision of the parent node and
AJAX-replaces just that field's markup. A toolbar tab toggles the buttons on and off.

Geysir has **no settings page** — the only thing to set up is a single permission,
**Manage Paragraphs from the front-end**, plus having a node with a Paragraphs field.
It depends on the **Paragraphs** and **Entity** contrib modules. It offers one
developer extension point, `hook_geysir_paragraph_links_alter()`, for adding your own
per-paragraph action links (e.g. move up/down).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the permission and prerequisites.

## Where it lives in the admin menu

Geysir has no configuration page. Its one permission is granted at **People →
Permissions** (`/admin/people/permissions`), and its editing controls appear on the
front-end view of nodes that have a Paragraphs field. A Geysir toolbar tab lets each
editor show or hide the buttons.
