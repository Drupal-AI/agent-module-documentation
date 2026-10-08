# Media Canonical Download — manual setup guide

**Media Canonical Download** (`media_canonical_download`) makes a media entity's
canonical URL serve its file directly. Normally visiting a media item's canonical
route (for example `/media/1`) shows the media *view page*; with this module
enabled and switched on for a media type, that same URL returns — and downloads —
the underlying file instead. It is useful wherever a media item should behave as
a direct link to its file, such as document downloads.

Under the hood the module alters the media routes (via a route subscriber) so the
canonical route is handled by a download controller. It has no dependencies beyond
Drupal core.

The security-relevant point is reassuring: because it alters the **canonical**
route — which Drupal already access-checks with media *view* access — serving the
file runs under that same check. A user must be able to view the media to download
its file, and the response is sent with `Cache-Control: private`. That said, it is
worth confirming this matches your intent for any private or restricted media:
the download follows media *view* access, not a separate, broader gate. If a role
can view a restricted media item, this module lets that role download the file at
its canonical URL.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no dedicated settings page** for this module. You turn the behaviour on
per media type, using a checkbox on the media type edit form — described in "How
to use it" below.

## Where it lives in the admin menu

Media Canonical Download adds no admin page of its own. The one switch it provides
appears as a **Serve file directly** option on each media type's edit form
(**Structure → Media types → *(type)* → Edit**). It also relies on a core media
setting at **Configuration → Media → Media settings**
(`/admin/config/media/media-settings`).

## How to use it

Following the module's own setup steps:

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **Configuration → Media → Media settings**
   (`/admin/config/media/media-settings`) and select **Standalone media URLs** so
   media items have their own canonical routes.
3. Create or edit a media type — a *document* type is the typical case
   (**Structure → Media types**). Make sure **Create new revision** is checked.
4. On that media type's form, check **Serve file directly** (the option this
   module adds).
5. Now visiting the media canonical route for an item of that type (for example
   `/media/1`) downloads the file directly instead of showing the media entity
   page.

Because the download honours media view access, double-check that any media type
you switch on is one whose files you are comfortable letting viewers download
directly.
