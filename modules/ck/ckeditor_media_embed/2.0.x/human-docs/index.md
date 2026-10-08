# CKEditor Media Embed plugin — manual setup guide

**CKEditor Media Embed plugin** (`ckeditor_media_embed`) brings CKEditor 5's native
**Media Embed** feature to Drupal. With it enabled, a content author can paste a media
URL — a YouTube or Vimeo video, a Twitter/X post, an Instagram photo, a Google Map, a
SoundCloud track, a CodePen — into a rich‑text field and have it turn into a real
embed. Under the hood the author's URL is saved as a compact `<oembed url="…">` tag,
and a text‑format filter converts that tag into the actual embed HTML when the content
is rendered, resolving each URL through an oEmbed provider (Iframely by default, which
covers 1700+ services).

Getting it working takes **three** pieces, all of which must be in place:

1. **The CKEditor plugin JavaScript**, which is *not bundled* with the module — you
   download it once with a Drush command into your site's `libraries/` directory.
2. **The "Insert media" toolbar button**, which you drag onto a text format's CKEditor
   5 toolbar.
3. **The "Convert Oembed tags to media embeds" filter**, which you enable on that same
   text format so the stored `<oembed>` tag actually renders as an embed.

Which oEmbed service resolves the URLs is a single **Provider URL** setting at
**Configuration → Media → CKEditor Media Embed**. It defaults to Iframely's proxy but
accepts any oEmbed endpoint — Noembed (no API key needed), embed.ly, or your own proxy.
The module also ships a **link field formatter** that renders a Link field's URL as an
embed through the same provider, and a hook for post‑processing the returned embed
(it ships a default that copies each media title onto the embedded iframe's `title`
attribute for accessibility). The module targets **Drupal 10.3+ or 11** and depends on
core's **CKEditor 5** module.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module,
   and download the CKEditor plugin JavaScript with Drush.
2. [Configuration](configuration/index.md) — add the toolbar button, enable the render
   filter, and choose your oEmbed provider.

## Where it lives in the admin menu

The module's own settings form is at **Configuration → Media → CKEditor Media Embed**
(`/admin/config/media/ckeditor-media-embed/settings`), gated by the core **Administer
filters** permission. The toolbar button and render filter are configured per text
format at **Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`).
