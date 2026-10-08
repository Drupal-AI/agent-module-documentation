# File (Field) Paths — manual setup guide

**File (Field) Paths** (`filefield_paths`) gives each File and Image field the
ability to build its upload folder and its stored filename from **tokens** — the
node's title or ID, the author, a date, and so on. Instead of every upload landing in
one flat directory with whatever name the browser sent, files get sorted and renamed
into a clean, predictable layout automatically, with no work for your editors.

For each file/image field you set a **File path** pattern (the destination directory,
e.g. `articles/[node:nid]`) and a **File name** pattern (the stored filename, e.g.
`[node:nid]-[file:name]`). Because the full token values often aren't known at the
moment a file is uploaded, uploads first land in a temporary location and are then
moved into their final, token‑built place when the entity is saved. Each pattern has
cleanup options — strip slashes out of token values, clean up segments using
Pathauto's alias cleaner, and transliterate non‑Latin text to safe US‑ASCII.

Beyond the basics it can create a **redirect** from a file's old URL when it moves
(with the Redirect module), **retroactively** reprocess every existing file of a
bundle in one batch after you change a pattern, and **actively** re‑move/rename files
whenever their entity is re‑saved. A companion Drush command runs retroactive updates
from the command line. It depends only on core's **File** module, and works best
alongside **Token**, **Pathauto** and **Redirect**.

> This is a **release candidate** (`8.x-1.0-rc1`) for Drupal 10.3+/11. The retroactive
> and active‑update options move real files around, so test them on a non‑production
> copy first.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the per‑field path/filename settings and
   the global temporary‑location form, field by field.

## Where it lives in the admin menu

There are two places to configure it:

- **Per field** — a *File (Field) Path settings* section is added to every File/Image
  field's settings form, under **Structure → Content types → *(type)* → Manage
  fields → *(your file field)***. This is where the real work happens.
- **Globally** — a small settings form at **Configuration → Media → File system →
  File (Field) Paths** (`/admin/config/media/file-system/filefield-paths`) sets the
  default temporary upload location. It requires the **Administer site configuration**
  permission.
