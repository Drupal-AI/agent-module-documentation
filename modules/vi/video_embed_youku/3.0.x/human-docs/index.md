# Video Embed Field Youku — manual setup guide

**Video Embed Field Youku** (`video_embed_youku`) adds Youku (优酷), the popular
Chinese video platform, as a provider for the
[Video Embed Field](https://www.drupal.org/project/video_embed_field) module.
Once it is installed, editors can paste a Youku video URL into any Video Embed
field — on a node, media entity, or paragraph — and Drupal renders a responsive
Youku player, just as Video Embed Field already does for YouTube and Vimeo.

The player itself works with no setup: paste a URL like
`https://v.youku.com/v_show/id_XNDQ2NjQwMjQw.html` and the module extracts the
video id and renders the embed. If you additionally supply a **Youku API Client
ID** (obtained from the Youku Developer Portal), the module can also fetch the
video's title, description, and thumbnail from the Youku API and cache them, so
your content can show proper metadata and a preview image. Without a client id
the player still renders — you simply don't get the remote title/thumbnail.

There's a small settings page where you enter that API Client ID and tune how
long API responses are cached (default one hour). Everything else — which
entities have a video field, how the player looks, autoplay — is handled by
Video Embed Field's own field and formatter settings.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside Video Embed Field.
2. [Configuration](configuration/index.md) — the settings form (API Client ID,
   cache duration), plus how to add a Video Embed field and paste a Youku URL.

## Where it lives in the admin menu

The settings form sits at **Configuration → Media → Video Embed Youku**
(`/admin/config/media/video-embed-youku`), gated by the standard
**Administer site configuration** permission. There is no permission specific to
this module.

## How to use it

1. Make sure a bundle (content type, media type, paragraph type) has a **Video
   Embed** field added by Video Embed Field.
2. When creating content, paste a Youku video URL into that field.
3. The module recognizes the URL, extracts the id, and renders a
   `player.youku.com` iframe on display. If you've configured an API Client ID,
   the title, description, and thumbnail are pulled from Youku and cached.
