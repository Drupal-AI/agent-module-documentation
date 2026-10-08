# Permanent Media File Delete — manual setup guide

**Permanent Media File Delete** (`permanent_media_file_delete`) extends the
[Media File Delete](https://www.drupal.org/project/media_file_delete) module so
that when you replace the file on an existing media item, the **old file is
permanently removed from storage** instead of being left behind as an orphan.

Without it, editing a media entity to swap in a new file leaves the previous
file sitting in the files table and on disk, unreferenced, slowly cluttering
your storage. With this module enabled, that replaced file is deleted as part of
the media save, keeping things tidy automatically.

Because it runs during a media edit, whoever can edit the media triggers the
cleanup. And because the deletion is **permanent and irreversible**, it is worth
understanding the trade-off: the module relies on Media File Delete's usage
checks, but if a file happens to be shared or referenced somewhere else, removing
it can break those other references. There is no undo. It has no access-control
role of its own — it only changes what happens to the old file when a media item
is edited.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its
   dependencies with Composer and enable it.

There is **no configuration page** — the behaviour is automatic once the module
is enabled.

## How to use it

There is nothing to switch on beyond enabling the module. Once it is active:

1. Create or open a media item (Image, Document, Audio, Video, etc.).
2. Edit it and **replace** its file with a new one, then save.
3. The previously attached file is deleted from storage. You can confirm this
   under **Content → Files** (`/admin/content/files`) — the replaced file no
   longer appears.

Because the removal cannot be undone, be deliberate when replacing files on
media that might be referenced elsewhere.
