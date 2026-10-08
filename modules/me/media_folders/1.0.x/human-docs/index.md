# Media Folders — manual setup guide

**Media Folders** (`media_folders`) gives Drupal's media library a familiar,
Windows-Explorer-style folder interface. Instead of one flat list of media items,
editors get a folder tree they can browse, with drag-and-drop to move items
between folders or to upload files straight from the desktop, thumbnail and list
views, and an in-folder search.

Behind the scenes, folders are simply taxonomy terms in a dedicated
`media_folders_folder` vocabulary, so the structure is *logical* — organising
media into folders never moves the underlying physical files. Uploaded files are
automatically matched to the right Media type based on their file extension (which
you can map yourself), and every create/edit/delete operation is checked against
your existing Media and Taxonomy permissions, so the module doesn't hand out any
new powers.

It's more than a browser, too: Media Folders ships a **field widget** so editors
can pick media through the folder tree, a **field formatter** to display those
references, a **CKEditor 5** integration for embedding media from folders into
rich text, and a bulk **Add to folder** action. A small settings page controls
the default view, sort order, page size, thumbnails, the CKEditor toggle, and the
extension-to-Media-type mapping, and a sync form reconciles your existing media
into the folder structure.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the settings form, the folder
   vocabulary, the sync tool, permissions, and the widget/formatter/CKEditor
   pieces.

## Where it lives in the admin menu

- **The folder browser** — **Content → Media folders**
  (`/admin/content/media-folders`), gated by the core **Access media overview**
  permission.
- **Settings** — **Configuration → Media → Media Folders**
  (`/admin/config/media-folders`), gated by the module's **Access media folders
  configuration** permission.
- **Sync tool** — `/admin/config/media-folders/sync`, gated by **Administer
  modules**.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Review the [settings](configuration/index.md) — pick your default view and sort
   order, decide whether to show thumbnails, and confirm the extension → Media type
   mapping so uploads land as the right bundle.
3. Go to **Content → Media folders** and create folders (folders are taxonomy
   terms, so this needs the matching taxonomy permission). Drag media between
   folders, or drag files from your desktop onto a folder to upload them.
4. If you already have media, run the **Sync** tool to file existing items into
   the folder structure.
5. To let editors pick media through folders on content forms, set a media
   entity-reference field's widget to **Media Folders** on the bundle's *Manage
   form display*. To embed media from folders in rich text, use the CKEditor 5
   button (unless you've disabled it in settings).
