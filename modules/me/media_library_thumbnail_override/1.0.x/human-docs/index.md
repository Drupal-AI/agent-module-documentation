# Media Library Thumbnail Override — manual setup guide

**Media Library Thumbnail Override** (`media_library_thumbnail_override`) makes
the Media Library easier to scan by replacing the generic placeholder thumbnails
that non‑image media normally show. Instead of an identical grey icon for every
PDF, video, audio file, or document, each item gets an icon chosen from its file
extension — for example a `pdf.png` icon for a PDF — so editors can tell at a
glance what each tile actually is.

The module detects the file extension for each non‑image media item and displays
the matching extension‑specific icon. When it can't find an icon for a particular
extension, it falls back to a generic one, so nothing ever renders blank. The
overridden thumbnails are run through Drupal's `media_library` image style, which
keeps them at the same consistent 220×220 pixel size as the rest of the grid, and
the module preserves the standard markup and CSS classes so it blends in seamlessly.

This is purely a display/admin‑UX enhancement for the Media Library. It does not
change what content is stored, and it plays no part in access control — it only
affects how non‑image tiles look in the library. It depends on core's **Media**
and **Media Library** modules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no dedicated settings page** for this module. It works automatically
once enabled: open the Media Library and non‑image items will show
extension‑based icons in place of the generic placeholder.

## Where it lives in the admin menu

The module adds no admin page of its own. You see its effect wherever the Media
Library appears — for example at **Content → Media → Add media** and in the media
selection modal that opens from any Media reference field.
