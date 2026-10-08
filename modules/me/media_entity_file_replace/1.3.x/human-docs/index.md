# Media Entity File Replace — manual setup guide

**Media Entity File Replace** (`media_entity_file_replace`) adds a **"Replace
file"** widget to media edit forms so content editors can swap the underlying
source file of any file‑based media entity — a Document, Image, Audio, Video, and
so on — while keeping the original filename and path intact. That last part is
the whole point: existing links, embeds, and bookmarks keep working because the
file's URL never changes.

Out of the box, Drupal core's media edit form lets you *reference a different
file*, but it doesn't offer a true in‑place replacement — the old file usually
stays behind and the URL changes. This module fixes that by adding a "Replace
file" pseudo‑field to the **Manage form display** of any media type whose source
is a file field. Once enabled there, an editor editing an existing media entity
gets a file upload with two choices: **overwrite** the original file (keeping the
same filename and extension, so everything that points at it keeps working), or
upload a new file that **replaces the reference** using the new filename.

When overwriting, the module copies the new file over the original on disk,
re‑saves the file entity so metadata like file size is recalculated, and flushes
image style derivatives so thumbnails regenerate. It enforces that an overwrite
uses the **same file extension** as the original (because web servers set the
content type from the filename), and it plays nicely with content translation,
skipping cases where a replacement could clobber the default‑language file.

The whole feature is implemented through form alters and hooks — there is **no
configuration UI, no permissions, and no settings of its own**. It depends only
on core's **Media** module. You "configure" it simply by enabling the widget on
the media types where you want it.

This guide is written for a **human** enabling and using the widget through the
admin UI. If you want a terse, token‑cheap reference for an AI coding agent, read
the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

## Where it lives in the admin menu

There's no settings page. You turn the widget on per media type at **Structure →
Media types → *(your type)* → Manage form display**
(`/admin/structure/media/manage/{type}/form-display`), and editors then use it on
the normal media **Edit** form.

## How to use it

1. Go to **Structure → Media types**, pick a file‑based type (for example
   *Document* or *Image*), and open its **Manage form display** tab.
2. Enable the **Replace file** field (drag it out of *Disabled* into the form and
   save). Do this only on the media types where editors actually need it.
3. Now, when an editor **edits an existing** media entity of that type, they'll
   see a "Replace file" upload with two options:
   - **Overwrite the original file** — keeps the same filename, extension, and
     URL, so existing embeds and links keep resolving. The extension must match
     the original.
   - **Replace with a new file** — uses the new filename when a rename is
     actually wanted.
4. For images, overwriting automatically regenerates image‑style derivatives, so
   thumbnails refresh.

Typical uses: updating a logo while keeping every embed pointing at the same
file, overwriting an outdated policy PDF so bookmarked links keep working,
refreshing a weekly report file in place, or fixing a corrupted upload — all
without deleting and re‑adding the media entity (which would create orphaned
duplicate files and change URLs).
