# IMCE Rename Plugin — manual setup guide

**IMCE Rename Plugin** (`imce_rename_plugin`) adds a **Rename** button to the IMCE
file browser, so editors can rename files and folders straight from the IMCE UI —
the browser you get when picking files in CKEditor or on a file/image field —
instead of downloading and re-uploading. Despite the project description mentioning
images, it works on any file IMCE manages (for example anything under `public://`),
not just images.

It plugs into IMCE rather than adding a page of its own, so there is no settings form
here. Instead it adds two **IMCE folder permissions** — *Rename files* and *Rename
folders* — that appear as checkboxes on each IMCE profile. Grant either one on a
folder and users assigned that profile get a Rename toolbar button (keyboard shortcut
Ctrl+Alt+W) and a "New name" prompt. On submit, the module tidies the new name
(transliterates to ASCII, caps it at 50 characters, turns spaces into dashes, strips
unusual characters, and re-appends the original file extension), refuses to overwrite
an existing name, and keeps Drupal's file records in sync — renaming a folder even
rewrites the stored paths of the files inside it.

The module depends on the **IMCE** module and the PHP **mbstring** extension. It has
no configuration route of its own, no Drupal-level permissions file, no config schema,
and no Drush commands — all the "configuration" is granting its two IMCE permissions
through IMCE's own settings.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

The module adds no page of its own. You grant its permissions inside IMCE's settings
at **Configuration → Media → IMCE** (`/admin/config/media/imce`), and the Rename
button itself appears in the IMCE file browser toolbar for users who have the
permission.

## How to use it

Renaming is gated by two per-folder IMCE permissions, so you grant them on an IMCE
profile before the button appears:

1. Go to **Configuration → Media → IMCE** (`/admin/config/media/imce`).
2. Edit the IMCE profile whose users should be able to rename (or create one).
3. In the profile's **folders**, tick **Rename files** and/or **Rename folders** on
   the folder(s) you want — these two checkboxes appear alongside the standard IMCE
   ones (Browse files, Upload files, Delete files, …) once this module is enabled.
   The two permissions are independent, so you can allow renaming files but not
   folders, or vice versa.
4. Make sure that profile is assigned to the right roles (IMCE's *Role-Profile
   assignments*, on the same settings page). "Who can rename" is simply which roles
   have a profile whose folder grants these permissions.

Once granted, an editor opens the IMCE browser (from CKEditor's file dialog or a
file field), selects a file or folder, and clicks the **Rename** button (or presses
**Ctrl+Alt+W**), types a new name, and confirms. The name is sanitized
automatically, the original extension is preserved for files, and renaming to a name
that already exists is rejected with an error. With neither permission on a folder,
the Rename button does not appear at all.

The finer points — the exact name-sanitizing rules and how folder renames update the
file records — are in the [`agent/` plugin docs](../agent/plugins/rename-plugin.md)
and [permissions docs](../agent/permissions/rename-permissions.md).
