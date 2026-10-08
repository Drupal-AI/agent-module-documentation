# Video — manual setup guide

**Video** (`video`) adds a **`video` field type** so any content type or other
entity can hold videos — either uploaded files or embed codes from remote hosts
like YouTube and Vimeo. It comes with widgets to capture videos and formatters to
play them back, and it only requires Drupal core's File module.

There are two ways editors add a video, chosen by which **widget** you put on the
field's form. The **Video Upload** widget (`video_upload`) accepts a local file
upload (mp4, ogv, or webm by default) with per‑field control over the folder,
allowed extensions, maximum size, and storage scheme. The **Video Embed** widget
(`video_embed`) accepts a provider URL, validates it against the enabled embed
providers, and — on save — stores it as a managed file under a provider‑specific
stream wrapper (for example `youtube://<id>`).

For display you pick a **formatter**. Uploaded files play in an HTML5 `<video>`
element via **Video Player** (`video_player`) or **Video Player (list)**
(`video_player_list`), with settings for width, height, controls, autoplay, loop,
mute, and preload. Remote videos render via **Embedded Video Player**
(`video_embed_player`), as an image‑styled **thumbnail** (`video_embed_thumbnail`),
or as the raw **URL** (`video_url`) for custom theming. Remote hosts are a plugin
type, so the bundled set — YouTube, Vimeo, Dailymotion, Facebook, Instagram, and
Vine — can be extended with your own provider. A companion submodule,
**Video Transcode** (`video_transcode`), adds local FFmpeg transcoding of
uploaded files into web‑friendly formats using reusable presets.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and the optional Video Transcode submodule.

There is **no configuration page** for this module — it has no global settings.
Everything is set up on the field itself, which is covered in "How to use it"
below.

## Where it lives in the admin menu

Video has no admin settings page of its own. You configure it entirely through
**Structure → Content types → *(your type)* → Manage fields / Manage form
display / Manage display**, like any other field.

## How to use it

1. Go to **Structure → Content types**, pick a content type, and open **Manage
   fields → Add field**.
2. Choose the **Video** field type (listed under the "reference" category) and
   save. By default it uses the Video Embed widget and the Embedded Video Player
   formatter.
3. Under **Manage form display**, pick the widget you want:
   - **Video Embed** — for pasting YouTube/Vimeo URLs. Its settings let you
     restrict which providers are allowed, set the thumbnail folder, and choose
     the storage scheme.
   - **Video Upload** — for uploading files. Its settings cover allowed
     extensions (default `mp4 ogv webm`), upload folder, maximum size, and
     storage scheme.
4. Under **Manage display**, pick a formatter to match — an HTML5 player for
   uploaded files, or an embed player/thumbnail/URL for remote videos — and tune
   its options (dimensions, autoplay, controls, image style, and so on).
5. To store several videos in one field (for example multiple HTML5 source
   formats), raise the field's **cardinality** under Storage settings.

> **Tip:** To keep uploaded videos on remote or cloud storage, pair Video with
> the [Flysystem](https://www.drupal.org/project/flysystem) module.
