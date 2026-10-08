# Create Media from Image Entities — manual setup guide

**Create Media from Image Entities** (`media_from_images`) scans the managed image
files already on your site and creates a Media (image) entity for every file that
doesn't have one yet. It is a clean‑up tool for sites that accumulated lots of
raw image files before adopting the Media system — for example a Drupal 8 site
that used CKEditor's file insert or the IMCE uploader and now has many (often
duplicated) `file_managed` rows with no media behind them.

To avoid creating duplicates, the module tracks every file it processes by its
**SHA‑256 content hash** in a small custom table. It only ever works on files that
already exist in Drupal's file system (those whose MIME type starts with
`image/`) — there is no user‑supplied path and no ingestion of arbitrary files —
and it re‑checks the MIME type and sanitises filenames before creating anything.
Re‑running it is safe: files that already have media are detected and skipped.

You can run the creation in whichever way suits your site: a standard progress‑bar
**Batch**, an immediate sequential batch for smaller sites, a **cron‑queued** mode
that trickles through the backlog in the background, or a **Drush** command. A
companion "attach unattached media" workflow back‑fills hash entries for media
that already existed before you installed the module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and confirm the prerequisites.

There is **no settings form** to configure. The module's admin page is an action/
statistics screen rather than a set of options, so its use is described below.

## Where it lives in the admin menu

The administrative interface is at **Configuration → Media → Media From Images**
(`/admin/config/media/media-from-images`). It shows statistics about image files
versus media entities, the current tracking‑table entries, and buttons to start
the batch operations. Reaching it requires the **administer media from images**
permission.

## How to use it

1. Make sure the prerequisites are in place: an **`image` media type** exists and
   has a **`field_media_image`** field (see Installation).
2. Grant the **administer media from images** permission to the administrators who
   should run it (**People → Permissions**).
3. Go to **`/admin/config/media/media-from-images`**, review the statistics, and
   click the button to start the batch that creates media for untracked files. Use
   the "attach unattached media" action to register media that already existed.
4. Prefer the command line, or have a very large library? Run it with Drush:

   ```bash
   drush media-from-images:process
   # short alias:
   drush mfi:process
   ```

5. Or let it run gradually in the background — the module can queue the work for
   **cron**, processing a few batches per run.

A per‑user 5‑minute rate limit and a named lock prevent overlapping runs, so two
administrators can't accidentally start conflicting operations.
