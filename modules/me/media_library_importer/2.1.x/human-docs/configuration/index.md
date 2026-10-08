# Configuration

Media Library Importer has two screens: a **configuration** form where you tell it where to
look and what to create, and an **import** form that actually does the work. You need the
matching permission for each.

## Open the configuration form

1. Log in as a user with the **Configure media library importer** permission.
2. Go to **Configuration → Media → Media Library Importer**
   (`/admin/config/media/media-library-importer`).

## Settings, field by field

- **Import folder** — the absolute filesystem path the importer scans for files. The form
  suggests your public files directory's real path and asks you to base the path on it.
- **Exclude styles folder** *(on by default)* — skips the image-`styles/` derivative folder
  while scanning, so you don't accidentally import generated image-style copies.
- **Copy files into the media type's location** *(on by default)* — when on, each source file
  is copied into the destination directory configured for its media type (a managed copy).
  When off, the file is registered in place at its existing path, without duplicating it.
- **Media types to import** — a set of checkboxes listing your media types. Tick the ones you
  want to create (for example only *Image* and *Document*). Selecting types reveals the field
  mapping below.
- **File field per media type** — for each media type you ticked, a drop-down appears to
  choose *which field on that media type stores the file* (for example
  `field_media_image` on the Image type). This is how the importer knows where to attach the
  imported file.

Save the form once these are set. The list of accepted file extensions is worked out
automatically from the file fields of the media types you selected.

## Run an import

1. With the **Import files into media library** permission, go to
   **Configuration → Media → Media Library Importer → Import**
   (`/admin/config/media/media-library-importer/import`).
2. You'll see a **checkbox tree of the folders** found under your import folder, all ticked
   by default, with a count of matching media next to each. Untick any you want to skip — for
   example to import just one campaign's subfolder.
3. Submit. The importer builds the queue for the selected folders and processes it as a
   batch, showing progress as it goes.

Because the importer checks for an existing Media of the same type and filename before
creating anything, running the import again will skip files that are already imported rather
than duplicating them.

## Importing from the command line

You can run the same import (across all configured folders) with Drush:

```bash
ddev drush media-library:import   # or the short alias:
ddev drush mli
```

The Drush command honours the same configuration as the UI (import folder, selected media
types, field mapping, copy-vs-in-place, exclude styles) and is equally idempotent. It has no
options — to scope what gets imported, adjust the import folder or selected media types in
the configuration form first.

## Scheduling incremental imports (developer tip)

If you want a "watched folder" that imports new files automatically, a small custom module
can rebuild the queue from `hook_cron` by calling the importer service's
`generateImportQueue()` and then letting cron drain the queue. The full service API is
documented in the sibling [`agent/`](../agent/start.md) docs.

## Permissions recap

| Permission | What it lets a user do |
|---|---|
| **Configure media library importer** | Open the configuration form and set the import folder and every other setting. |
| **Import files into media library** | Open the import form and run an import over the currently configured folder (and, by default, copy files into the public files directory). |

Grant both only to trusted administrators.
