# Editor File Upload — manual setup guide

**Editor File Upload** (`editor_file`) adds a paperclip toolbar button to
CKEditor 5 so content authors can upload a file and insert a link to it directly
from the rich-text editor — no separate file field, no FTP, no "upload it
somewhere else first."

Out of the box, linking to a downloadable file (a PDF, spreadsheet, and so on) in
body text means uploading the file elsewhere and pasting its URL by hand. This
module registers a CKEditor 5 plugin that provides a **File** button and an upload
dialog: the editor picks or drags a file, it is stored as a managed file entity,
and a link is inserted carrying `data-entity-type` and `data-entity-uuid`
attributes. Those attributes let Drupal track the file's usage and keep the link
valid even if the file moves.

Behavior is controlled **per text format**, in the CKEditor 5 plugin settings —
you decide whether uploads are enabled, which storage scheme to use
(public/private/other), the target directory, the allowed file extensions
(required, for safety), and a maximum file size. It hooks into core's managed-file
and file-validation systems and can migrate its settings from the old CKEditor 4
equivalent. It pairs nicely with the **Editor Advanced Link** module when you want
to add title, id, or class attributes to the inserted link. The module adds no
permissions of its own — access simply follows the text format's use permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — adding the File button to a text
   format and setting the upload options.

## Where it lives in the admin menu

The File button and its settings live under **Configuration → Content authoring →
Text formats and editors** (`/admin/config/content/formats`), on each CKEditor
5-based text format you want to give file-upload capability.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Edit a CKEditor 5 text format, drag the **File** (paperclip) button into the
   active toolbar, and set the upload options (see
   [Configuration](configuration/index.md)).
3. Editors using that format will see the paperclip button. Clicking it opens a
   dialog to upload (or drag in) a file — or link an existing one by URL — and the
   download link is inserted into the body.
