# File to Media — manual setup guide

**File to Media** (`file_to_media`) lets you turn an existing managed file into a
proper **Media entity**. It adds a Views field that renders a per‑file "Create
&lt;media type&gt;" dropbutton, and a route that opens the media add‑form
pre‑populated with the chosen file — so an editor can promote a stray uploaded
file (a PDF, image, or document) into a reusable media item without re‑uploading
it.

The main use case is migration and cleanup: sites that predate Drupal's Media
system, or that have old file fields, accumulate managed files that aren't backed
by media. Point a View at your files, add this field, and each eligible file gets a
one‑click path to become media. It's smart about what it offers — the conversion
link only appears for files that are **public**, **not already used by a media
entity**, and only for media types whose source field actually accepts the file's
extension.

There's essentially nothing to set up beyond adding the field to a view. File to
Media has **no settings page, no permissions of its own, no Drush commands, and no
configuration**. It depends on core's **File**, **Media**, and **Views** modules,
and ships no submodules. Access is governed by Drupal's normal media‑create
permissions plus the core **Access the Files overview** permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside File, Media, and Views.

## Where it lives in the admin menu

The module adds no admin page. Its Views field surfaces wherever you place it — most
naturally in a View of **Files** (for example an admin listing under
`/admin/content/files`). The conversion form itself lives at
`/file/to-media/{file}/{media_type}`.

## How to use it

1. Go to **Structure → Views → Add view** and choose **Show: Files** (base table
   `file_managed`); add a Page or Block display.
2. Add a field and pick **File to Media links** ("Links to create a media item from
   this file.").
3. Save. Each file row now shows a dropbutton with a **Create &lt;label&gt;** link
   for every compatible media type.

For the links to appear you need at least one media type whose source (file/image)
field accepts the file's extension, and the files must be public and not already
backed by media. Clicking a link opens the standard media add‑form with the file
already assigned to the source field — the editor fills in any remaining fields and
saves.

To control who sees the links, use the View's normal access settings together with
core's per‑media‑type create permissions; the field itself adds no permission. There
is no per‑view configuration beyond adding the field — the behaviour is fixed in
code.
