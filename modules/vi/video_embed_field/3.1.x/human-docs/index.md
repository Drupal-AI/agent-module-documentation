# Video Embed Field — manual setup guide

**Video Embed Field** (`video_embed_field`) gives Drupal a dedicated field type
for videos hosted on third‑party services such as **YouTube** and **Vimeo**. An
editor simply pastes a video's URL into a normal‑looking text field; the module
recognises which provider it belongs to, validates it, and renders it as a
responsive embed — with an optional preview thumbnail that it downloads and caches
locally so it can be run through Drupal's image styles like any other image.

It solves the everyday problem of "how do content authors add a video without
wrestling with embed codes." Instead of pasting an `<iframe>`, they paste a link,
and you control the presentation centrally through the field's display settings.
Several **formatters** ship with the module: a full **Video** embed, a
**Thumbnail** (optionally linked to the node or the video), a **Lazy load**
thumbnail that swaps to the player on click, a **Colorbox** formatter that opens
the video in a modal/lightbox, and a raw **Video URL** output. Each formatter
exposes its own settings — autoplay, responsive vs. fixed size, explicit
width/height, the iframe `loading` mode, image style, and link target. The video
hosts themselves are **provider plugins**, so YouTube, YouTube playlists, and
Vimeo are built in and a developer can add more.

Video Embed Field **needs to be set up per field** — enabling it doesn't change
anything on its own until you add a Video Embed field to a content type and choose
how it displays. It depends only on core's **Field**, **Image**, and **System**
modules. It provides a **"never autoplay videos"** permission (so you can turn off
autoplay for chosen roles, which helps accessibility), and ships two optional
submodules: **Video Embed Media** (`video_embed_media`), which lets the field back
a core Media type, and **Video Embed WYSIWYG** (`video_embed_wysiwyg`), which lets
editors drop videos into CKEditor 5 rich text.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — the field/formatter setting
keys, the provider plugin API, the hooks — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and pick the submodules you need.

## Where it lives in the admin menu

Video Embed Field has **no central settings page** (`configure` is `null`). It
surfaces in the places you already manage fields and displays:

- **Add the field** under **Structure → Content types → *(your type)* → Manage
  fields → Add field**, choosing the **Video Embed** field type.
- **Choose how it displays** under the same content type's **Manage display** tab,
  where you pick one of the formatters and set its options.
- **Control autoplay per role** under **People → Permissions**, via the
  **Never autoplay videos** permission.

## How to use it

Adding video to a content type is a three‑step job:

**1. Add a Video Embed field.** Go to **Structure → Content types → *(your type)*
→ Manage fields → Add field**, choose **Video Embed**, and save. Editors will then
see a single text box where they paste a YouTube or Vimeo URL; a built‑in
validation check rejects any URL that no provider recognises. In the field's
settings you can optionally **restrict the allowed providers** (for example
YouTube only) — leave it empty to accept all supported hosts.

**2. Choose how the video displays.** On the content type's **Manage display**
tab, pick a formatter for the field:

- **Video** — the full embedded player. By default it's **responsive** (scales to
  its container); untick that to set an explicit **width** and **height** (854×480
  by default).
- **Thumbnail** — shows the cached preview image, optionally linked to the content
  or to the video on its provider.
- **Lazy load** — shows the thumbnail and only loads the player iframe when the
  visitor clicks it.
- **Colorbox** — shows the thumbnail and opens the video in a Colorbox modal.
- **Video URL** — outputs the raw URL, useful for a decoupled front end.

Common formatter settings include **autoplay** (on by default, but bypassed for
roles that have the "never autoplay videos" permission), the iframe **`loading`**
attribute (`lazy` or `eager`), and — for the thumbnail‑based formatters — an
**image style** and where the image links to. Colorbox adds a **modal max width**.

**3. Tune autoplay and accessibility.** Under **People → Permissions**, grant or
withhold **Never autoplay videos** per role. Roles with that permission never get
autoplaying videos even when a formatter has autoplay switched on.

Two optional submodules extend the field further — enable them only if you need
them (see [Installation](installation/index.md)): **Video Embed Media** to use the
field inside the core Media library, and **Video Embed WYSIWYG** to insert videos
directly in CKEditor 5.
