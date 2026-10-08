<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor Video IMCE (ckeditor_video_imce) — agent index

A **CKEditor 5 plugin** that adds a toolbar button to insert an HTML5 `<video>` element,
picking the video file through the **IMCE file browser**. Everything runs **client-side**:
there is no route, controller, service, config schema, permission, or install/update hook in
this module. Package `CKEditor`. Core `^10 || ^11 || ^12`. License GPL-2.0-or-later.
Installed **2.0.1** (version dir `2.0.x`).

## Dependencies

- Drupal modules: **`ckeditor5`** (core) and **`imce`** (contrib) — both required (`.info.yml`).
- Composer: `drupal/imce` `^3.0 || ^4.0` (`composer.json`). No PHP libraries.

## What it provides (from source)

- **CKEditor 5 plugin** `ckeditor_video_imce_video` (`ckeditor_video_imce.ckeditor5.yml`),
  Drupal class `Plugin/CKEditor5Plugin/VideoImce` (an **empty** subclass of
  `CKEditor5PluginDefault` — no server-side behavior/config). Label "Video (IMCE)"; toolbar
  item `videoImce` ("Insert video using IMCE"). Declared allowed elements: `<video>` with
  `controls autoplay loop muted preload poster width height crossorigin style`, and `<source>`
  with `src type`.
- **Library** `ckeditor_video_imce/videoImce` (`.libraries.yml`) → `js/ckeditor5_plugins/videoImce/videoImce.js`
  (marked `minified: true`), depending on `ckeditor5/internal.drupal.ckeditor5` and
  **`imce/drupal.imce.input`** (the `window.imceInput` bridge).
- **JS plugin** (`videoImce.js`) — registers the `videoImce` button, defines the `videoBlock`
  model schema, upcast/downcast converters (model ⇄ `<video><source></video>`), and the IMCE
  open/insert flow. Details → [plugin/video-plugin.md](plugin/video-plugin.md).

## Notable facts / gotchas

- **No settings page** (`configure: null`). Configuration is per text format: enable the button
  in the CKEditor 5 toolbar at `/admin/config/content/formats`, and ensure the format's HTML
  filter allows `<video>`/`<source>` and their attributes.
- **README is stale**: it describes a "CKEditor 4 plugin" and `data-cke-saved-*` attributes;
  the actual code is a **CKEditor 5** plugin. Trust the source, not the README.
- **File access is governed entirely by IMCE** — this module has no server surface of its own;
  which files a user can browse/select comes from IMCE's profiles and permissions.
- If `window.imceInput` is unavailable, the button falls back to a plain `prompt()` for a URL.

## Solution docs

- **JS plugin internals — schema, converters, IMCE flow, inserted markup** →
  [plugin/video-plugin.md](plugin/video-plugin.md)
