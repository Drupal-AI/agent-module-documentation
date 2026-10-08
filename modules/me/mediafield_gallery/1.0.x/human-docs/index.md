# Media Field Gallery — manual setup guide

**Media Field Gallery** (`mediafield_gallery`) turns an ordinary media reference
field into a responsive, interactive **gallery** inside Views. Instead of listing
media items one under another, it displays them as a modern grid with lightbox
previews: images, videos, audio files, and documents (PDF, DOCX and more) all get
inline previews, and clicking a thumbnail opens the full item in a lightbox
without leaving the page. To keep listings tidy it shows the **first four** media
items and adds a **"+X more"** overlay for the rest.

The problem it addresses is that Drupal's core media handling, while capable,
offers no ready‑made gallery‑style display for multiple media types. Media Field
Gallery fills that gap with a no‑code approach: rather than configuring a formatter
inside each View, you use a single **configuration page** to choose which media
field gets the gallery treatment and on which View paths it should apply.

It requires **PHP 8.1**, depends on core **Views**, **Media** and **Field**, works
on Drupal 9, 10 and 11, and provides its own permission. Before it can do anything
your content type must have a **media reference field** (Entity Reference → Media);
the gallery renders that field's items. Note the module is **not covered by
Drupal's security advisory policy**. The media shown always follows normal core
media and file access — the gallery only changes how it is displayed.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Views, Media and Field.
2. [Configuration](configuration/index.md) — choose the media field and the View
   path(s) the gallery applies to.

## Where it lives in the admin menu

The module's settings form is at **Configuration → Media → Media Field Gallery**
(`/admin/config/media/mediafield-gallery`). The gallery itself appears on the View
page(s) you configure there.

## How to use it

1. Make sure the content type whose media you want to display has a **media
   reference field** (Entity Reference → Media).
2. Build (or reuse) a **View** that lists that content — for example a page View at
   `/gallery`.
3. Open the module's [configuration page](configuration/index.md), select the media
   field, and enter the View path(s) where the gallery should apply.
4. Clear the Drupal cache so the gallery layout takes effect, then visit the View
   path to see the responsive gallery with lightbox previews.
