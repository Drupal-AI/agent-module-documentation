# Media File Delete — manual setup guide

**Media File Delete** (`media_file_delete`) closes a small but wasteful gap in
Drupal's media handling. Out of the box, when you delete a media item, Drupal
removes only the `media` entity — the underlying `file` (and the physical file on
disk) is left behind. Over time these orphaned files pile up and eat storage. This
module adds an **"Also delete the associated file?"** checkbox to the media delete
flow, so removing a media item can clean up its file too.

The checkbox appears on both the single **delete** confirm form and the **bulk
delete** form. When ticked, the module deletes the file entity after the media is
deleted. Crucially, the deletion is carefully guarded so you never break something:
it only offers the option for file‑based media sources (image, document, audio,
video); it respects file delete access, so a file owned by another user is retained
unless you hold the right permission; and it refuses to delete a file that is still
used elsewhere, according to a chained file‑usage resolver (core's file usage by
default). If a file can't be deleted, the form explains why instead of offering the
checkbox.

A settings form at **Configuration → Media → Media File Delete Settings** lets you
set whether the checkbox defaults to on and whether editors may change it at all —
so you can enforce a site‑wide cleanup policy. The bulk form applies the same
safety checks per item and reports how many files were deleted, skipped for
insufficient privilege, or skipped because they are still in use. An optional
submodule, **Media File Delete – Entity Usage**, plugs the Entity Usage module into
the resolver chain so files still referenced by tracked entities are protected too.
It depends on core's **Media** and **File** modules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and add the Entity Usage submodule if you need it.
2. [Configuration](configuration/index.md) — the settings form and the permissions
   that govern who can delete files.

## Where it lives in the admin menu

The settings form is at **Configuration → Media → Media File Delete Settings**
(`/admin/config/media/media_file_delete/settings`, route
`media_file_delete.settings`), gated by the **Administer media file delete**
permission.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Optionally visit the settings form to set the checkbox default and whether
   editors can change it — see [Configuration](configuration/index.md).
3. Delete a media item as usual. On the confirm form you'll see the **Also delete
   the associated file?** checkbox (when the file is safe to delete). Tick it to
   remove the file too.
