# Media Entity PodToo — manual setup guide

**Media Entity PodToo** (`podtoo`) lets content editors embed audio and podcast
content from the **PodToo** streaming service as standard Drupal media entities. It
registers an oEmbed-based media source, so once you create a PodToo media type,
PodToo embeds behave like any other Drupal media: they can be added through the
Media Library, inserted via the CKEditor media embed button, or referenced from a
dedicated media field on a content type.

Under the hood it reuses Drupal core's oEmbed machinery but points it at PodToo's
oEmbed API. The provider endpoint and the accepted URL patterns are **hard-coded**
to PodToo (`https://embed.podtoo.com/*` and `https://podcasts.podtoo.com/*`), so it
only ever talks to PodToo — there is no arbitrary provider discovery. Creating,
editing and deleting PodToo media follows Drupal's normal per-media-type permission
model.

Note the module's development status: it is **minimally maintained** with **no
further development** planned, so treat it as stable-but-frozen.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the site-wide settings form (display
   size, player color, and an optional privacy setting).

## Where it lives in the admin menu

Site-wide settings are at **Configuration → Media → PodToo**
(`/admin/config/media/podtoo`), behind the **Administer site configuration**
permission. Media create/edit/delete permissions are managed as usual at **People →
Permissions**.

## How to use it

1. Enable the module to register the `oembed:podtoo` media source.
2. Create a **PodToo** media type mapped to that source (**Structure → Media
   types → Add media type**).
3. Set the site-wide display options (see [Configuration](configuration/index.md)).
4. Add a media reference field that allows the PodToo media type, or use the Media
   Library / CKEditor media embed.
5. Paste a supported PodToo URL (`https://embed.podtoo.com/*` or
   `https://podcasts.podtoo.com/*`) to embed the audio.
