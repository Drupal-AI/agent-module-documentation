# AMP Video Embed Field — manual setup guide

**AMP Video Embed Field** (`amp_video_embed_field_formatter`) is a small bridge
between two other modules: the **AMP** module and **Video Embed Field**. It adds
a field formatter that renders embedded YouTube and Vimeo videos as AMP-valid
markup — `<amp-youtube>` and `<amp-vimeo>` tags — so that videos display
correctly on AMP pages and pass the AMP validator.

If you build AMP versions of your pages and you use Video Embed Field to manage
video URLs, the ordinary video player markup will not validate as AMP. This
module gives you a formatter you can assign to a video field so that, on AMP
displays, the video is emitted as the proper AMP component instead.

It is a display-layer module only: it adds no routes, permissions, or services.
It simply provides a formatter choice on a video field's display settings, and it
takes effect when that display is rendered in an AMP context. On normal
(non-AMP) displays, Video Embed Field's usual rendering is used instead.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

1. Make sure the **AMP** module and **Video Embed Field** are installed and that
   you have an AMP display/theme set up.
2. Go to the **Manage display** screen for the entity that has your Video Embed
   Field (for example an article or media type), on the view mode you expose
   through AMP.
3. For the video field, choose the **AMP video formatter**. Where the formatter
   exposes them, you can set width/height defaults.
4. Assign it **per view mode** so that your canonical (non-AMP) pages keep the
   standard player and only the AMP view mode uses the AMP markup.
5. Clear caches after changing the formatter, then test the AMP page with
   Google's AMP validator.
