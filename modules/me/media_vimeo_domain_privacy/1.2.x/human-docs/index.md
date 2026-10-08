# Media Vimeo Domain Privacy — manual setup guide

**Media Vimeo Domain Privacy** (`media_vimeo_domain_privacy`) lets you add Vimeo
videos that use Vimeo's **domain‑level privacy** setting as remote‑video media
entities in Drupal. Domain privacy is the Vimeo option that allows a video to play
only when embedded on specific, whitelisted domains — commonly used for training
material, internal briefings, client deliverables, or licensed films meant for one
site. Without this module you simply cannot create a media entity for such a video,
and this module exists purely to handle that one case.

The reason it is needed is technical and specific. Drupal core's remote‑video
media source fetches a video's title and thumbnail through **oEmbed**, and Vimeo's
oEmbed endpoint refuses to return metadata for a domain‑restricted video to an
unauthenticated caller — the server making that request is not a browser on an
allowed domain. So adding the video fails at the metadata step. This module
supplies the required **Referer** value on the oEmbed request so the metadata is
returned and the media entity can be created.

There is nothing to configure and no settings form: install it, enable it, and
domain‑restricted Vimeo videos become addable through the normal remote‑video
media flow. It depends only on core **Media** and works on Drupal 8.8 through 11.
Salsa Digital sponsors its maintenance; the roadmap notes that no further features
are planned, since it handles one specific integration.

> **Two things about the mechanism, not the module.** First, **domain privacy is a
> deterrent, not access control** — it is enforced by a request header that a
> determined person can set, and the video URL still exists. It keeps a video off
> other people's sites; it does not keep it from someone who really wants it. For
> genuinely confidential material, Vimeo's password protection or
> unlisted‑with‑hash links are the stronger options. Second, **an embedded Vimeo
> player is still a third‑party request** with cookies and a view reported to
> Vimeo, so the same consent and privacy questions apply as for any public embed.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside core Media.

There is **no configuration page** for this module — it has no settings form and
requires no setup beyond enabling it.

## Where it lives in the admin menu

The module adds no settings page. Once enabled, you add domain‑restricted Vimeo
videos exactly like any other remote video, through your remote‑video media type at
**Content → Media → Add media** (`/admin/content/media`).

## How to use it

1. Make sure you have a media type using core's **Remote video** source (Drupal's
   standard oEmbed video type), or create one at **Structure → Media types**.
2. With this module enabled, go to **Content → Media → Add media**, choose that
   remote video type, and paste the Vimeo URL of a **domain‑privacy** video.
3. The media item saves successfully — its title and thumbnail are fetched — and
   the video plays wherever it is embedded on your allowed domain(s). Before the
   module was installed, this same step would have failed.
