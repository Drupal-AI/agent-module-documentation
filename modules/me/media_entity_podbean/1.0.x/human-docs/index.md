# Media Entity Podbean — manual setup guide

**Media Entity Podbean** (`media_entity_podbean`) adds a media source for
[Podbean](https://www.podbean.com/), letting editors embed Podbean podcast
episodes and playlists as Drupal media entities. If you use Podbean (free or
paid), you paste a Podbean permalink URL into the media item and the module embeds
the podcast as oEmbed content, the same way core handles a YouTube or Vimeo video.
Once added, the episode lives in the Media Library and can be reused across the
site.

It depends only on Drupal core's Media module and runs on Drupal 9, 10, and 11.
The module has no content or access‑control role of its own — the audio is hosted
on Podbean, and Drupal's normal media access applies.

Because the player is embedded from Podbean's servers, the podcast loads
third‑party content in your visitors' browsers — the usual egress and privacy
consideration for any external embed, since Podbean sees the visitors who load the
player.

One format detail to know up front: you must use a Podbean **permalink** URL in
the form `https://www.podbean.com/e/12345`, not an ordinary page link.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside core's Media module.

This module has no separate settings page. You set it up by creating a media type
that uses the Podbean source, described below.

## Where it lives in the admin menu

Media Entity Podbean adds no admin settings form. The media types you create with
the Podbean source appear under **Structure → Media types**
(`/admin/structure/media`), and individual episodes are managed from **Content →
Media** (`/admin/content/media`) or through the Media Library.

## How to use it

1. **Create a media type that uses the Podbean source.** Go to **Structure →
   Media types → Add media type** (`/admin/structure/media/add`), name it (for
   example "Podbean episode"), and in the **Media source** field choose
   **Podbean**. Save.
2. **Add an episode.** Go to **Content → Media → Add media**, choose your Podbean
   media type, and paste a Podbean **permalink** URL in the form
   `https://www.podbean.com/e/12345`. Save.
3. **Reuse it.** The episode is now in the Media Library and can be referenced
   from media reference fields or inserted through the CKEditor Media button
   wherever entity embedding is allowed.
