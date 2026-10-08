# Media Entity Instagram — manual setup guide

**Media Entity Instagram** (`media_entity_instagram`) adds an **Instagram** media
source to Drupal's core Media module, so editors can store Instagram posts, reels,
and IGTV videos as reusable media entities from just their URL — no manual embed
HTML required.

The module registers a single oEmbed-based media source (`oembed:instagram`, an
extension of core's oEmbed source) plus a matching field formatter
(`instagram_embed`). You create a Media type whose source is "Instagram"; a
plain-text or link **source field** on that type holds the post URL (for example
`https://www.instagram.com/p/<shortcode>/`). The source parses the shortcode out
of the URL — recognizing `/p/`, `/reel/`, and `/tv/` paths on both `instagram.com`
and `instagr.am` — and then uses Instagram's oEmbed API to fetch the post's HTML,
thumbnail, and metadata (author name, provider, dimensions). The
`instagram_embed` formatter renders that oEmbed HTML in an iframe, with options
for a maximum width and hiding the caption.

Because live embedding calls Instagram's Graph/oEmbed API, the module includes a
small settings form for your Facebook App ID and App secret. It is a thin, focused
source provider built entirely on core Media and oEmbed infrastructure — it adds
no new plugin types, permissions, or Drush commands.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, satisfy the
   Media dependency, and enable it.
2. [Configuration](configuration/index.md) — enter your Facebook App credentials
   and create an Instagram media type.

## Where it lives in the admin menu

Two places:

- The credentials settings form is at **Configuration → Media → Instagram
  settings** (`/admin/config/media/instagram-settings`), gated by the core
  *Administer media* permission.
- You create the Instagram media type itself at **Structure → Media types**
  (`/admin/structure/media`), the standard core Media location.

## How to use it

Once installed, enter your Facebook App credentials, create a Media type backed by
the Instagram source, and editors can then add Instagram posts by pasting a URL —
through the media library or a media-reference field. The
[Configuration](configuration/index.md) page walks through both steps.
