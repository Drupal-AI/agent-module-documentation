# Panopto Media Remote — manual setup guide

**Panopto Media Remote** (`panopto_media_remote`) adds **Panopto** — the
lecture-capture platform used by many universities and training organisations — as
a provider for the **Media Remote** module. That lets you reference a Panopto
recording as a Drupal media entity **by its URL** and embed it in content, and via
CKEditor, without downloading or hosting the video yourself.

Referencing rather than holding the video is the right model here: the recording
is large, it is governed on Panopto (which carries the institution's access
controls, retention policy, and captions), and copying it into Drupal would
duplicate both the storage and the access decision. Media Remote is built for
exactly this — it stores a URL and renders an embed without pretending to own the
asset. This module supports a wide range of core versions (`^8` through `^11`) and
requires the **Media Remote** module.

Three things follow from referencing rather than holding, and they are worth
keeping in mind:

1. **Access lives with Panopto.** A recording restricted to a course can sit on a
   Drupal page that is public — and what a visitor actually sees is whatever
   Panopto decides. Don't build a page that implies access Drupal cannot grant; a
   page whose only content is an embed the visitor can't play is a broken page from
   their side.
2. **The embed is a third-party request.** Loading the player sends a request (and
   a view) to Panopto. For an institutional platform that is usually fine, but it
   still belongs in your site's privacy notice.
3. **Captions are the accessibility requirement, and they live in Panopto.**
   Whether a recording is captioned is answered on the platform, not in Drupal, so
   check that the recordings you publish are captioned.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install Panopto Media Remote and its
   Media Remote dependency with Composer, and enable it.

There is **no dedicated settings form**. Setup is done through Drupal's normal
media-type and field-display screens, described in "How to use it" below.

## Where it lives in the admin menu

Panopto Media Remote adds no standalone settings page. You set it up under
**Structure → Media types** (`/admin/structure/media`) and the media type's
**Manage display**, then add a media field to your content.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Go to **Structure → Media types** and **add a new media type** — give it a name
   such as *Panopto* and choose **Remote Media URL** as the media source.
3. Open that media type's **Manage display** and set the formatter to **Remote
   Media - Panopto**.
4. Add a **media field** to any content type and allow the new Panopto media type.
5. Editors can now add a Panopto recording by pasting its URL, and it will embed
   on the page.
