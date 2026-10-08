# Private file auto redirect — manual setup guide

**Private file auto redirect** (`private_file_auto_redirect`) fixes a common,
frustrating problem with private files that are attached to **Media** entities:
when an editor replaces the file behind a media item, the *old* file URL stops
working. Drupal keeps uploaded files unique by appending `-0`, `-1`, and so on to
duplicate filenames, and it no longer deletes superseded files from disk — so any
link that was shared earlier (a bookmark, a newsletter, another site linking in,
printed marketing material) keeps pointing at the previous file and eventually
404s once that file is gone or superseded.

This module quietly solves that. It takes over Drupal's private-file download
routes and, for each request, loads the file, finds the media entity that
references it, and checks the media's latest revision. If the newest revision now
points at a *different* file, it sends the visitor a redirect to the current
file's private-download URL. If nothing has changed — or the file isn't
referenced by a media entity, or it's a temporary file — it simply hands the
request back to Drupal core unchanged.

Two things are worth knowing. First, it only works with files served from the
**private** file system and only for files referenced by **media** entities;
everything else falls through to core behaviour. Second, access control is never
weakened: the module never streams file bytes itself. Every path that actually
delivers a file defers to Drupal core, which runs the normal private-file
permission checks (`hook_file_download`) on whatever file is finally served, and
the redirect target is re-checked on the follow-up request.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it. That's the entire setup.

There is **no configuration page** for this module — it is zero‑config. The route
controller override applies the moment you enable it.

## How it works, and when to use it

Enable it on sites where content editors routinely **replace media source files
in place** and you want previously shared private-file links to resolve to the
replacement rather than break. Typical wins:

- Bookmarked private-file URLs keep working after a media file is replaced.
- Email and newsletter links to a document still land on the current version.
- Stale document or PDF/image downloads point at the newest uploaded file.
- Fewer broken-link support tickets for updated private assets.

Non-media private files, temporary files, and files whose latest revision hasn't
changed are all served exactly as core would serve them — so enabling the module
is safe even where most of your files don't fit its pattern.
