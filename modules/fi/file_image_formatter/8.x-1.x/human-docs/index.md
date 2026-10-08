# File Image Formatter — manual setup guide

**File Image Formatter** (`file_image_formatter`) is a field formatter for
**File** fields (not Image fields) that renders a file as an image whenever the
file actually is one. It is most useful on sites migrated from Drupal 6, where
the default "upload" field stored images as generic files: with this formatter,
those images display properly without having to re-migrate them into dedicated
image fields.

The typical place to reach for it is a **view** — for example a listing of nodes
whose file field may reference images stored as file entities — where you want
those images to render as images rather than as download links. It is less
suitable as the default display for a general file field, because non-image files
will simply be hidden by this formatter rather than shown as links.

The file is rendered respecting Drupal's normal file access, and the module adds
no access-control behaviour of its own. It depends only on core's **File** module
and covers Drupal 10.3 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is no settings page for this module — you select the formatter on a file
field's display, as described below.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Go to the *Manage display* for the entity holding your **File** field
   (**Structure → Content types → *(type)* → Manage display**, or the display of
   the relevant view).
3. Set the file field's format to the **File Image Formatter** (image) formatter.
   Files that are images will now render as images; non-image files in that field
   will be hidden.
