<!--
SPDX-FileCopyrightText: © 2025 Agent Module Documentation contributors
SPDX-License-Identifier: GPL-2.0-or-later
-->
Media Entity Instagram adds an **Instagram** media source to Drupal's core Media module, so
editors can store Instagram posts, reels and IGTV videos as reusable media entities from just
their URL.

---

The module registers a single oEmbed-based media source plugin (`oembed:instagram`, an
extension of core's `OEmbed` source) plus a matching `instagram_embed` field formatter. You
create a Media type whose source is "Instagram"; a plain-text or link **source field** on that
type holds the post URL (e.g. `https://www.instagram.com/p/<shortcode>/`). The source parses
the shortcode out of the URL with a set of validation regexes (covering `/p/`, `/reel/` and
`/tv/` paths on both `instagram.com` and `instagr.am`), then uses Instagram's oEmbed API to
fetch the post's HTML, thumbnail and metadata (author name, provider, dimensions, resource
type). The `instagram_embed` formatter renders the returned oEmbed HTML in an iframe, with
display options for maximum width and hiding the caption. A settings form at
`/admin/config/media/instagram-settings` stores the Facebook App ID and App secret used to
authenticate against the Graph/oEmbed API. The module ships no new plugin types, permissions
or Drush commands — it is a thin, focused media-source provider built entirely on the core
Media and oEmbed infrastructure.

---

- Let editors add an Instagram post to the site by pasting only its URL, with no manual HTML.
- Create a dedicated "Instagram" media type backed by the `oembed:instagram` source plugin.
- Store Instagram reels (`/reel/`) as first-class media entities.
- Store IGTV / TV posts (`/tv/`) as media alongside images and video.
- Embed a curated Instagram post into an article body via the media library.
- Build a Views-driven "social wall" of Instagram media referenced from content.
- Reuse a single Instagram media item across many nodes instead of re-pasting embeds.
- Capture Instagram post metadata (author name, provider, thumbnail) into media fields.
- Auto-generate a local thumbnail for each Instagram post for use in listings and teasers.
- Render Instagram embeds at a constrained maximum width to fit a content column.
- Hide the Instagram caption in embeds for a cleaner, image-first presentation.
- Use one shared source field across several Instagram media types, or one field per type.
- Reference Instagram media from an entity-reference field on any content type.
- Provide alt/label metadata for accessibility from the oEmbed author/title data.
- Populate a media library tab so editors can pick or add Instagram posts inline.
- Validate pasted URLs so only genuine Instagram post/reel/tv links are accepted.
- Centralise Facebook App credentials once for all Instagram media on the site.
- Migrate legacy inline Instagram embeds into structured media entities.
- Feed Instagram media into a decoupled front end via JSON:API media resources.
- Display an editor-facing preview of the embedded post on the media edit form.
- Drive the source field's shortcode into custom tokens or computed fields.
- Standardise how marketing embeds Instagram across an editorial team.
- Combine with Media Library to give a single "Add media" flow across image, video and Instagram.
- Theme the Instagram embed by overriding the formatter's iframe output.
