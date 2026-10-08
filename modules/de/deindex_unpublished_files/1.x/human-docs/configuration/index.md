# Configuration

Deindex Unpublished Files has one main decision to make: *how* an unpublished
media file should be made inaccessible.

## Open the settings

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Media → Unpublished files settings**.

## Choose the protection method

The settings form lets you pick the method used to make unpublished media files
inaccessible:

- **Private files method** *(the strongest option)* — moves the file to the
  private directory `private://unpublishedfiles/`, where it is served only
  through Drupal's access checks and cannot be fetched directly. This requires a
  working private file system (see [Installation](../installation/index.md)). On
  republish, the file is moved back to public storage.
- **Prefix method** — adds a prefix to the file (a `.ht_` rename) so that
  Drupal's default `.htaccess` denies access to it. This is the fallback used
  where a private move is not possible; it depends on your web server honoring
  `.htaccess` (Apache does by default; nginx needs equivalent deny rules).

## Save and confirm

Click **Save configuration**. Then test the behavior: unpublish a media item and
confirm its file is no longer directly downloadable, then republish and confirm
it is restored.

Because moving or renaming a file changes its URI, **verify that references to it
still resolve** after a publish/unpublish cycle — especially anywhere a file URL
may have been hard‑coded.

## The "Unpublish media by usage" page

Separately from the settings, the module provides a review page at
`/admin/content/deindex-unpublished-files/unpublished-media`. It lists media and
where each item is used — in unpublished nodes, published nodes, and other
entities — so you can identify media that is only used by unpublished content and
therefore ought to be unpublished itself. Rows highlighted in light red are
exactly those "used only in unpublished content" cases.
