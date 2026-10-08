# CkEditor Media Modal Edit — manual setup guide

**CkEditor Media Modal Edit** (`ckeditor_media_modal_edit`) adds a small but
welcome convenience: an "Edit this media" pencil link on each item in the media
library widget that CKEditor uses, so editors can fix a media entity in a modal
dialog without leaving the editor.

The problem it solves is a workflow gap. When you embed media through CKEditor,
the media library widget normally only lets you *select* existing media —
correcting an image's alt text or other metadata means leaving the editor,
finding the media entity, editing it, and coming back. This module appends an
edit link to each selectable media item; clicking it opens the media edit form in
an AJAX modal, and saving closes the dialog and returns you to your place instead
of doing a full‑page redirect.

It respects access properly. The edit link only appears when the current user has
**update** access to that specific media item, so the module does not bypass
Drupal's media access rules — it simply surfaces the edit form more
conveniently. It has no routes, permissions, or external calls of its own; it
reuses core's own media edit route, which keeps its own access checks. There is
nothing to configure — the behavior applies wherever the media library widget
appears once the module is enabled and your text format uses the media embed
filter.

The only requirement is core's **Media** module. It works on Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   make sure your text format uses the media embed filter.

There is **no settings page** for this module — it works automatically once
enabled.

## Where it lives in the admin menu

The module adds no admin configuration page. It hooks into the existing media
library widget, so it takes effect anywhere that widget is used inside CKEditor.
For the widget (and therefore the edit links) to appear, your text format needs
the **drupal‑media** / media embed filter enabled at **Configuration → Content
authoring → Text formats and editors** (`/admin/config/content/formats`).

## How to use it

Edit a content field whose text format supports embedded media. Open the media
library widget (via the Media button), and next to each media item you have
permission to update you will see an **Edit this media** pencil link. Click it,
adjust the media's fields in the modal, and save — the dialog closes and your
editing session continues uninterrupted.
