# Video Embed Facebook — manual setup guide

**Video Embed Facebook** (`video_embed_facebook`) teaches the **Video Embed
Field** module how to handle Facebook videos. On its own it is tiny — a single
provider plugin — but once enabled, any Video Embed Field on your site will
accept a Facebook video URL alongside the YouTube and Vimeo URLs it already
understands, and render it as an embedded player with a thumbnail pulled from
Facebook.

There is nothing to configure and no settings screen. Editors simply paste a
Facebook video URL (such as `https://www.facebook.com/somepage/videos/123456`
or the older `https://www.facebook.com/video.php?v=123456`) into a video field,
and the module extracts the video, builds the embed iframe, and fetches a poster
image from Facebook's Graph API so Drupal can apply image styles to it. All the
field, widget, formatter and thumbnail behaviour comes from the parent Video
Embed Field module — this add-on only adds Facebook recognition.

Because everything runs through Video Embed Field, you configure the *field*
(and its display formatter) the normal way, and Facebook support is just
"switched on" by having this module enabled.

> **Compatibility note for this version.** On the environment these docs were
> generated against, the Facebook provider's `renderEmbedCode()` method signature
> is out of date relative to the installed Video Embed Field base class, which
> causes a PHP fatal when the provider class is loaded to *render* a video.
> Storing a Facebook URL in a field works, but rendering it (or otherwise
> resolving the provider) fails until the plugin is updated to match the current
> base signature. This is a module/dependency version mismatch, not something you
> can fix from configuration. See the [`agent/`](../agent/start.md) docs for the
> exact detail.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (Video Embed Field is required).

## Where it lives in the admin menu

Nowhere of its own — this module has no admin pages, no settings form and no
permissions. You work entirely through Video Embed Field's normal field UI.

## How to use it

1. Make sure the **Video Embed Field** module is installed and enabled (it is a
   required dependency — see [Installation](installation/index.md)).
2. Enable this module. That is all it takes to add Facebook support.
3. On a content type (for example Article), add a field of type **Video Embed
   Field** via **Manage fields**, or reuse one you already have.
4. Optionally, in the field settings you can limit the *allowed providers*;
   leaving that empty allows every provider, including Facebook.
5. On **Manage display**, choose how the field renders (Video, Thumbnail, and so
   on) exactly as you would for any Video Embed Field.
6. Editors then paste a Facebook video URL into the field. Both `www.` and
   non-`www.` URLs are recognised, and Facebook videos can sit in the same field
   as YouTube and Vimeo videos.
