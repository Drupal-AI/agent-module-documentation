# Media Folder Management — manual setup guide

**Media Folder Management** (`media_folder_management`) gives editors a
Windows‑Explorer‑style (or Nautilus‑style) file manager for organizing media into
a browsable folder tree. Editors can create, move, and rename folders, drag files
to upload them, drag and drop items to move them between folders, and rely on file
locking and file revisions to keep changes safe.

One important thing to understand up front: this module provides **its own "media"
entity and folder structure** — it is a self‑contained file manager, not an
integration layer over Drupal's core Media entities. If what you actually want is
to organize your existing core Media entities into folders, look at the separate
*Media Folders* module instead.

The module is properly access‑controlled. Its routes require the **access media
folder file explorer** permission, and folder operations additionally run a
per‑folder access check on top of a granular permission set (create/read/update/
delete folders, own‑folder permissions, per‑revision permissions, and a
**bypass media folder files permissions** override). Because a folder manager can
touch media across the whole site, grant these permissions deliberately and keep
the *bypass* and *administer* permissions to trusted administrators only.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and set up permissions.

This module has **no global settings form**, so there is no separate configuration
page. What you *do* configure is permissions (via the standard **People →
Permissions** screen) and the folders themselves, both covered below.

## Where it lives in the admin menu

Once enabled, the file explorer lives at **`/admin/content/file-explorer`**. Open
it to start creating folders and uploading or moving files.

## How to use it

1. Assign permissions first (see below) so the right users can reach the explorer.
2. Go to **`/admin/content/file-explorer`**.
3. Create folders, then drag files in to upload them, or drag existing items
   between folders to reorganize. Renaming, locking, and revisions are available
   per item.

## Permissions to review

Grant these on **People → Permissions** (`/admin/people/permissions`) according to
how much trust each role should have:

- **Access media folder file explorer** — the baseline permission needed to open
  and use the explorer at all.
- **Folder create / read / update / delete** permissions — control which folder
  operations a role may perform.
- **Own‑folder** and **per‑revision** permissions — allow users to manage the
  folders (and revisions) they created.
- **Bypass media folder files permissions** — an override that ignores the
  per‑folder checks. Reserve this for trusted administrators only.
