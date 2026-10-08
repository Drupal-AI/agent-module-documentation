# File Rename — manual setup guide

**File Rename** (`file_rename`) lets an editor rename a file that's already been
uploaded — changing both its filename on disk and the filename stored on the file
entity — without deleting it and uploading it again. Out of the box Drupal gives
you no way to fix a badly named file after the fact; this module adds a dedicated
rename form, an *Rename* operation link in the admin file list, and (optionally) a
*Rename* link right next to files on your upload widgets.

It's the module you reach for when a file was uploaded as `IMG_2931.jpg` and
should really be `team-photo.jpg`, or when a migration produced machine-generated
names, or when you want downloadable documents to carry human-readable,
keyword-rich filenames (which also helps what the browser's "Save as" suggests).
Because renaming happens through core's own file APIs, it reuses Drupal's filename
sanitisation, refuses to overwrite an existing file with the same target name, and
— for images — automatically flushes the image-style derivatives so the resized
copies regenerate under the new name.

Renaming is gated by a dedicated permission and only works on **permanent** (saved)
files, so it's safe to hand to trusted editors. There's a small settings form for
one global option, and a per-field option on Manage form display. This guide is
written for a **human** clicking through the admin UI; if you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead. The module depends only on core's
**File** module, has no submodules, and adds no third-party libraries.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — the "Rename files" permission, the
   global settings flag, and the per-field "Show rename link" option.

## Where it lives in the admin menu

- The **settings form** is at **Configuration → Media → File Rename settings**
  (`/admin/config/file_rename/settings`).
- The **rename form** itself is reached from a *Rename* operation link — on the
  admin file listing at **Content → Files** (`/admin/content/files`), or beside a
  file on an upload widget when that link is enabled.

## How to use it

1. Grant the **Rename files** permission to the roles that should be allowed to
   rename (see [Configuration](configuration/index.md)).
2. Decide where the *Rename* link should appear — everywhere on file widgets
   (global flag), or just on specific fields (per-field opt-in), or only via the
   admin file list. This is covered in [Configuration](configuration/index.md).
3. To rename a file, click its **Rename** link. On the form you edit the base
   filename — the extension is fixed and shown as a suffix, so you can't
   accidentally change the file type — then save. The file is moved on disk, the
   entity is updated, and any image derivatives are flushed.

Developers can react to renames by implementing `hook_file_prerename()` /
`hook_file_rename()` (for example to notify an external system) — see the
[`agent/`](../agent/start.md) docs.
