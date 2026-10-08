# Media PhotoSwipe — manual setup guide

**Media PhotoSwipe** (`media_photoswipe`) provides field formatters that render
image (and remote‑video) media in a **PhotoSwipe** lightbox — a touch‑friendly,
zoomable, swipeable gallery. Thumbnails on the page open into a full‑screen viewer,
and multiple images can be grouped into a single gallery a visitor can swipe
through. It's a display‑only integration: you set the formatter on a field's
display and the module handles attaching the PhotoSwipe JavaScript library where
it's needed.

> **Heads‑up: this module is no longer supported.** Its maintainers mark it as
> unsupported/obsolete and recommend using the
> [PhotoSwipe](https://www.drupal.org/project/photoswipe) module instead. It also
> works only with **Image fields** (not Media reference fields) at present. Weigh
> that before adopting it on a new site; this guide documents it as it stands.

The formatter relies on the `levmyshkin/photo-swipe` JavaScript library (installed
via Composer) and core's **Image** module. Supporting internals attach the
PhotoSwipe assets only where the formatter is used, generate a gallery id per
entity (so galleries stay grouped correctly), and let a request suppress the
lightbox entirely by adding `?media_photoswipe=no` to the URL — handy for print or
debugging.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its PhotoSwipe
   library with Composer, then enable it.
2. [Configuration](configuration/index.md) — the gallery settings form, plus
   setting the formatter on a field's display.

## Where it lives in the admin menu

Its settings form sits at **Configuration → Media → Media PhotoSwipe**
(`/admin/config/media/media-photoswipe`), and requires the **Administer site
configuration** permission. The formatter itself is set per field on **Manage
display**.

## How to use it

1. Install the PhotoSwipe library and enable the module (see
   [Installation](installation/index.md)).
2. On the entity that has your image field, open its **Manage display**, and set
   that field's format to the **Media PhotoSwipe** formatter. Configure the
   formatter options (image styles for thumbnail vs. full view, captions, etc.).
3. Tune the site‑wide gallery behaviour at **Configuration → Media → Media
   PhotoSwipe** (see [Configuration](configuration/index.md)).
