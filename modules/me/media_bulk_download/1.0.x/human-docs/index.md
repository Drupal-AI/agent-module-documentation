# Media Bulk Download — manual setup guide

**Media Bulk Download** (`media_bulk_download`) adds a *Download selected as ZIP*
bulk action to the Media Library, so an editor can tick several media items and
download all of their original files together as a single ZIP archive. It works
in both the grid and the table view of the library, and it needs nothing more
than core's **Media** module to run.

This is handy whenever Drupal is doing double duty as a digital asset manager, or
during a migration, or simply when someone needs a handful of assets pulled off
the site for use elsewhere. Rather than opening and saving each file one at a
time, you select them all and get one archive.

The feature is gated by a dedicated **`download bulk media`** permission, so only
the roles you trust can use it. When the action runs, the module builds the ZIP
on the server and shows a status message with a download link. That link is only
valid for the user who triggered the action, and the temporary file is deleted
once it has been downloaded — the served file is read from that user's own
private tempstore, not from any id in the URL, so there is no way to tamper with
the request to reach files you shouldn't. Because the archive contains whatever
media you selected, treat this as a way to *download files you can already
manage*, and grant the permission accordingly. There is no auto-download: by
design you always click the provided link.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and grant the download permission.

There is **no configuration page** for this module. The bulk action appears in
the Media Library automatically once the module is enabled — the only setup step
is granting the permission, covered in Installation.

## Where it lives in the admin menu

Media Bulk Download adds no settings page of its own. You use it from the **Media
Library** (**Content → Media**, or wherever the media library view is shown):
select media items, choose **Download selected as ZIP** from the *Action*
dropdown, and apply it. A status message then gives you the download link.

## How to use it

1. Grant the **`download bulk media`** permission to the roles that should be
   allowed to bulk-download (see Installation).
2. Go to the Media Library and switch to either the grid or the table view.
3. Tick the media items you want.
4. In the bulk *Action* dropdown choose **Download selected as ZIP** and apply.
5. Click the download link in the status message that appears. The ZIP contains
   the original files of the selected media, and the temporary archive is removed
   after you download it.
