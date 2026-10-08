# Media Library Importer — manual setup guide

**Media Library Importer** (`media_library_importer`) takes a folder of files that already
live on your server and turns them into proper **Media** entities — so they show up in the
Media Library without anyone re-uploading them one by one. Point it at a directory, tell it
which media types to create, and it walks the folder, matches files by extension, and
creates a File entity plus a Media entity for each one.

It is built for bulk work. Rather than processing everything in a single request (which
would time out on a big folder), it loads the files into a Drupal queue and runs them
through a batch, using the required **Queue UI** module. It is also safe to re-run: before
queueing a file it checks whether a Media of that type with the same filename already
exists, so importing twice will not create duplicates. That makes it handy for onboarding a
legacy `sites/default/files` tree, seeding a fresh site's Media Library during deployment,
or repeatedly importing new drops into a "watched" folder from cron.

You control it from two screens — a **configuration** screen (where you set the import
folder, the media types, and the file-field mapping) and an **import** screen (a checkbox
tree of folders that actually runs the import) — or from the command line with
`drush media-library:import`. Two separate permissions keep "who can configure" apart from
"who can run an import." An optional submodule, **Media Image EXIF Importer**, adds camera
metadata extraction for imported images.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

> **Note:** by default the importer copies files into your public files folder. Grant both
> permissions only to trusted administrators — see the
> [Configuration](configuration/index.md) page.

## Contents

1. [Installation](installation/index.md) — install the module (and Queue UI) with Composer
   and enable it.
2. [Configuration](configuration/index.md) — set the import folder, choose media types, map
   file fields, and run an import.

## Where it lives in the admin menu

- **Configuration:** **Configuration → Media → Media Library Importer**
  (`/admin/config/media/media-library-importer`).
- **Run an import:** the same area, under **… / Import**
  (`/admin/config/media/media-library-importer/import`).
