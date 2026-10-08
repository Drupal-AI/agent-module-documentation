# Image File Preview — manual setup guide

**Image File Preview** (`image_file_preview`) solves a small but common annoyance:
when you build a **View** of files, Drupal normally shows you a filename or a link,
not the actual picture. This module adds a Views field that renders a **thumbnail
preview** for image files, so a file listing becomes something you can scan by eye.

It works on Views built from the **Files** (`file_managed`) base table. Once the
module is enabled it registers a display‑only field called **Image File Preview**
that you drop into any such View — an admin file overview, a media library listing,
a "find unused files" cleanup View, and so on. The thumbnail simply renders from
the existing file data.

The module is deliberately minimal: it has **no configuration UI, no routes, no
permissions, and no dependencies beyond Drupal core**. It only reads existing file
data and adds a read‑only column, so there's nothing to lock down and nothing to
tune.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module. You use it entirely from the
Views UI, described in "How to use it" below.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Structure → Views** and edit an existing Files‑based View, or create a
   new View of **Files**.
3. Click **Add** next to *Fields* and search for **Image File Preview**. Add it.
4. Arrange it wherever you'd like the thumbnail column to appear — for example next
   to the filename, file size, or upload date.
5. Save the View and look at its preview: image files now show a thumbnail.

If you build Views in code or configuration, the Views field id is
`image_file_preview` on the `file_managed` base table.

Handy places to use it: an editor‑facing visual file browser, a "used in" tracking
View, a paged listing of all managed image files, or a cleanup View of unused files
where seeing the actual images makes deletion decisions safer.
