# File Field Sources — manual setup guide

**File Field Sources** (`filefield_sources`) gives editors more ways to fill in a
**File** or **Image** field than just uploading from their computer. With it
enabled on a widget, an editor can also populate the field from a **remote URL**
(the module downloads it), a **reference** to an existing file already on the site,
a file sitting in a **server directory** ("File attach"), the **IMCE** file
browser, or by pasting from the **clipboard**. Core's normal **Upload** stays
available alongside whichever extra sources you turn on.

This is useful whenever re-uploading is wasteful or impractical: reuse a
large file that is already on the site instead of uploading it again, pull in
images an external process dropped into a watched server folder, let editors paste
a screenshot straight from the clipboard, or syndicate an image from another site
by URL. You decide which sources appear on each field, so you can, for example,
offer both Upload and Remote URL on an Image field, or lock a field down to the
"reference existing file" source to enforce file reuse.

Sources are configured **per field widget**, not globally — you turn them on from a
content type's **Manage form display** screen, and the choice travels with your
exported form-display configuration. By default the extra sources are offered on
the standard File (`file_generic`) and Image (`image_image`) widgets. Developers
can extend it too: it defines a `FilefieldSource` plugin type for writing custom
sources, and hooks for adding source support to custom widgets or filtering which
sources a user sees.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — the plugin type, the source
ids, and the config structure — read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and the optional IMCE integration.
2. [Configuration](configuration/index.md) — enable and set up sources on a File
   or Image field's widget.

## Where it lives in the admin menu

File Field Sources has **no global settings page**. You configure it per field on
a content type's (or other entity's) **Manage form display** screen — for example
**Structure → Content types → Article → Manage form display**
(`/admin/structure/types/manage/article/form-display`).

## How to use it

Enable the module, then edit the **Manage form display** for the bundle that has
your File or Image field. Click the gear icon on that field's row, open the **File
sources** section, tick the sources you want to offer, adjust any per-source
options, and save. From then on, editors filling in that field will see the extra
source options. See [Configuration](configuration/index.md) for the full
walkthrough.
