# Media Alias Display — manual setup guide

**Media Alias Display** (`media_alias_display`) makes a media entity's clean URL
serve the **underlying file directly** in the browser. Instead of a document
media item's canonical URL rendering a Drupal "media view" page — or exposing an
ugly `sites/default/files/handbook.pdf` path — a PDF simply opens at a friendly
alias like `/policies/handbook`.

It does this by taking over the display of the media's canonical (and revision)
URL: when someone visits that URL, the module streams the media's source file with
the correct MIME type rather than showing the normal media page. This only applies
to media whose source is an actual **file** (image, document, audio, or video file
sources — not oEmbed/remote video), and only when the file exists. Editors can swap
the file on a media entity and every link that points at its alias keeps working,
which makes it great for handbooks, forms, reports, and QR-code targets that
should never change URL.

The module has a small settings form with two controls: a global **kill switch**
to turn the behavior off site-wide without uninstalling, and an optional
**allow-list of media bundles** so the direct-file behavior applies only to
certain media types (leave it empty to cover all of them). It also understands a
couple of handy query-string tricks on any alias — `?dl` or `?download` forces a
download, and `?edit-media` sends editors to the media edit form. **Media Alias
Display requires core Media's "Standalone media URL" setting to be turned on**,
depends on the core **Media Library** module, and has an optional submodule,
**Media Alias Display Field Override**, that lets you exclude individual media
items. It adds no permissions of its own (the settings form uses *Administer site
configuration*).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — including the route
override, the controller decision flow, and the cache context — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module and the required "Standalone media URL" setting, and pick the submodule
   if you need it.
2. [Configuration](configuration/index.md) — the settings form (kill switch and
   media-bundle allow-list) and the `?dl` / `?download` / `?edit-media` URL tricks.

## Where it lives in the admin menu

Once enabled, its settings form sits at **Configuration → Media → Media Alias
Display** (`/admin/config/media/media_alias_display`).

## How to use it

The typical flow: create a media entity for your file (a Document media item for a
PDF, say), give it a friendly path alias — Pathauto can generate these
automatically — and make sure core's **Standalone media URL** setting is on. Visit
that alias and the file opens directly. Use the settings form to restrict the
behavior to specific bundles or to switch it off globally, and append `?dl` to any
alias when you want to force a download instead of an inline view.
