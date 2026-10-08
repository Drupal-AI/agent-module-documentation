# CKEditor 5 Audio Plugin — manual setup guide

**CKEditor 5 Audio Plugin** (`ckeditor5_audio_plugin`) adds audio support to
Drupal's CKEditor 5 rich‑text editor. With it, content editors can drop an audio
clip straight into the body of a page — either by **uploading an audio file** or
by **embedding audio from an external link** — without leaving the WYSIWYG editor.

Out of the box, CKEditor 5 has no way to place a playable audio element in
content. This module fills that gap by adding a toolbar button that inserts an
audio embed, giving editors a smooth, in-editor experience for adding sound to
articles, podcasts show notes, pronunciation guides, and similar content.

The module depends only on core's CKEditor 5 module and works on Drupal 9, 10, and
11. It has no settings page of its own — you enable its toolbar button per text
format, as described below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module. You make its button available
per text format, described below.

## How to use it

This is a CKEditor 5 plugin module: it adds a toolbar button you enable per text
format.

1. Go to **Administration → Configuration → Content authoring → Text formats and
   editors** (`/admin/config/content/formats`).
2. Edit the text format whose editor is CKEditor 5.
3. In the CKEditor 5 toolbar configuration, drag the **Audio** button from the
   list of available buttons into your active toolbar.
4. If the text format uses the *Limit allowed HTML tags* filter, make sure the
   markup the plugin produces (the `<audio>` element and its attributes) is
   permitted, otherwise it will be stripped on save.
5. Save the text format.

Editors can now click the Audio button while writing, then either upload an audio
file or paste a link to embed audio directly in the content.
