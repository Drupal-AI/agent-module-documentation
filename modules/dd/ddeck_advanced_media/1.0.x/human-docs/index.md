# DDECK Plyr & Advanced Media — manual setup guide

**DDECK Plyr & Advanced Media** (`ddeck_advanced_media`) gives Drupal a set of
modern media display formatters, so you can render audio, video, remote video,
and image galleries beautifully without writing any front-end code. It plugs
straight into Drupal's standard **Manage display** workflow: you keep your
existing Media and image fields and simply choose a richer formatter for them.

The module solves a common problem — getting polished, accessible media playback
without custom templates or JavaScript. It ships four ready-to-use formatters: a
**Plyr** player for local audio, a **Plyr** player for local video, a **Plyr**
formatter for remote YouTube and Vimeo videos, and a **PhotoSwipe** responsive
lightbox gallery for image fields. It also adds a **CKEditor 5** media gallery so
editors can insert an image gallery (backed by the Media Library and viewed with
PhotoSwipe) directly into rich-text content. Player behaviour — autoplay, loop,
controls, YouTube privacy options — is set per formatter, and many formatters
accept JSON player options for finer control.

It depends on Drupal core's **Media**, **Media Library**, **CKEditor 5**, and
**Image** modules, and works with the **Plyr** and **PhotoSwipe** front-end
libraries. It creates no new content type — everything happens through standard
field formatters — and supports Drupal 10 and 11. Note that this is an
alpha-stage, minimally maintained project not covered by Drupal's security
advisory policy, so test it carefully before relying on it in production.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Media dependencies.

There is **no dedicated configuration page** for this module. All of its settings
live on individual field displays (and in CKEditor's toolbar setup), described in
"How to use it" below.

## Where it lives in the admin menu

DDECK Advanced Media adds no admin settings page of its own. You use it entirely
from **Structure → Content types → *(your type)* → Manage display**, where you
pick one of its formatters on a media or image field, and from your text format's
**CKEditor 5** toolbar configuration, where you add the media gallery button.

## How to use it

1. Make sure your content has a **Media** or **image** field (for example a Media
   reference field configured for audio, video, or image, or a plain image
   field).
2. Go to **Structure → Content types → *(your type)* → Manage display**.
3. On the relevant field, open the **Format** dropdown and choose one of the
   DDECK formatters:
   - **DDECK Plyr for audio files** — a modern, accessible audio player.
   - **DDECK Plyr for video files** — a Plyr video player for local video.
   - **DDECK Plyr for remote videos** — Plyr playback for YouTube and Vimeo
     links.
   - **PhotoSwipe Media Gallery** — a responsive lightbox gallery for image
     fields.
4. Click the formatter's gear/settings icon to adjust player behaviour (autoplay,
   loop, controls, YouTube privacy, and JSON player options where offered), then
   **Save**.
5. To let editors insert galleries inside rich text, open **Configuration →
   Content authoring → Text formats and editors**, edit a CKEditor 5-based
   format, and drag the module's media gallery button into the active toolbar.

Then view a piece of content and confirm your media renders through the Plyr
player or PhotoSwipe gallery. If you upgraded from an earlier internal name of
the module, run a cache rebuild (`drush cr`) and re-check your formatter
assignments.
