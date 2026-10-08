# Files and Folders — manual setup guide

**Files and Folders** — on‑disk name `filesandfolders`, actual machine name
`files_and_folders` — is a hierarchical file manager for Drupal, built on nodes. It
lets editors organize, browse, and manage files and folders in a nested structure,
much like a traditional file explorer. Folders and files are each their own content
type, arranged by a parent‑folder reference, with a collapsible folder tree, an
AJAX file browser, uploads with automatic thumbnail generation, and role‑based
folder visibility.

Because everything is a node, it slots into Drupal's usual content model: folders
can be created with an image, thumbnails are generated for images, PDFs, and Office
documents (via Imagick and LibreOffice), file metadata such as type and size is
stored, and each folder's visibility can be restricted to specific roles. You place
the manager as a block (Layout Builder works well) and use the *Add files* and *Add
folder* buttons to start organizing.

The module exposes a `/files-and-folders` interface plus many AJAX endpoints for
listing, creating, renaming, moving, deleting, downloading, and uploading items,
and it ships several fine‑grained permissions for who can do what.

> **Read before production use.** This module is **not covered by Drupal's security
> advisory policy** and describes itself as still under development, with some
> features incomplete. It handles file uploads and access, so review it carefully,
> restrict its permissions tightly (do not grant upload or management permissions to
> untrusted or anonymous users), and keep uploads in a location that isn't
> web‑executable. Treat it as security‑sensitive.

Files and Folders works on **Drupal 9 and 10** and depends on a number of core
modules (Node, Views, File, Image, Field, Field UI, User, Datetime, Options).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module
   (note the machine name), and grant permissions.
2. [Configuration](configuration/index.md) — the settings form (storage scheme,
   directory, layout, icon size) and folder access.

## Where it lives in the admin menu

Once enabled, the settings form sits at
**`/admin/config/files-and-folders/settings`** (the `files_and_folders.settings`
route), behind the **Administer site configuration** permission. The manager
interface itself is at **`/files-and-folders`**, and it can also be placed as a
block.

## How to use it

1. Enable the module and grant the appropriate permissions.
2. Choose your storage scheme and layout on the settings form.
3. Place the **Files and Folders** block where you want the manager to appear (for
   example via Layout Builder), or visit `/files-and-folders`.
4. Use **Add folder** to create folders (optionally restricting each to specific
   roles) and **Add files** to upload into them. Browse the folder tree, and
   rename, move, download, or delete items as needed.
