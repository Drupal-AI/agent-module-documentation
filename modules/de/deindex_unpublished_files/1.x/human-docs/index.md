# Deindex Unpublished Files — manual setup guide

**Deindex Unpublished Files** (`deindex_unpublished_files`) makes sure the files
behind *unpublished* media are not publicly downloadable. When you unpublish a
media entity, it moves that entity's file out of public storage and into private
storage, and moves it back when you publish again — real access protection, not
just a search‑engine hint, despite the "deindex" in the name.

This closes a long‑standing Drupal gap. Unpublishing a media entity hides the
media, but if the underlying file lives in `public://` it stays directly
fetchable at its URL — so "unpublished" content is still downloadable by anyone
who has (or guesses) the link. Deindex Unpublished Files fixes this: when a media
item is unpublished and its file is in public storage, the module **moves the
file to `private://unpublishedfiles/`**, where it is served through Drupal's
access checks rather than being fetched directly. On republish, the file moves
back to public storage. Where a private move is not possible, it falls back to
renaming the file with a `.ht_` prefix, which Drupal's default `.htaccess` denies.

The module works only with media types that include a file field. It also
provides a **"Unpublish media by usage" page** at
`/admin/content/deindex-unpublished-files/unpublished-media`, which lists where
each media item is used (in unpublished nodes, published nodes, and other
entities) so you can spot media that is only used by unpublished content and
should itself be unpublished; rows shown in light red indicate exactly that case.

Two operational points to plan for: the **private file stream must be
configured** (a private file path set in `settings.php`) for the move to work,
and the `.ht_` fallback relies on your web server honoring Drupal's `.htaccess`
(Apache does; nginx needs equivalent rules). Because moving a file changes its
URI, confirm your references still resolve after a publish/unpublish cycle.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and make sure private file storage is configured.
2. [Configuration](configuration/index.md) — choose how unpublished files are
   made inaccessible.

## Where it lives in the admin menu

Its settings form is at **Configuration → Media → Unpublished files settings**.
The usage overview lives at **Content →** the "Unpublish media by usage" page
(`/admin/content/deindex-unpublished-files/unpublished-media`).
