<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor Audio Plugin (ckeditor5_audio_plugin) — agent index

CKEditor 5 plugin that inserts an HTML5 `<audio controls>` player into rich text, either by uploading
an audio file or by entering an audio URL. Version 1.0.5. Core `^9 || ^10 || ^11`.

- **Dependency:** core `ckeditor5` (`ckeditor5_audio_plugin.info.yml`). No composer requirements, no submodules, no permissions, no Drush.
- **CKEditor 5 plugin:** `ckeditor5_audio_plugin_audio` → JS `audio.Audio`, PHP `src/Plugin/CKEditor5Plugin/Audio.php` (`ckeditor5_audio_plugin.ckeditor5.yml`). Adds toolbar item `audio` ("Insert Audio"). Allowed elements: `<div>`, `<div class>`, `<audio>`, `<audio src class controls>`.
- **Config:** per-text-format plugin settings `ckeditor5_audio` = `{status, directory, max_size}`; schema in `config/schema/ckeditor5_audio_plugin.schema.yml`. No standalone settings route (`configure: null`) — configured inside each format's editor form. See [agent/plugins/audio.md](plugins/audio.md).
- **Route/controller:** `ckeditor5_audio_plugin.upload` → `POST /ckeditor5-audio-upload` → `src/Controller/AudioUploadController::upload()`; returns JSON `{url}`. The JS upload adapter POSTs `file`, `directory`, `max_size`. See [agent/api/upload.md](api/upload.md).
- **Libraries:** `ckeditor5_audio_plugin/ckeditor5_audio` (build JS), `ckeditor5_audio_plugin/ckeditor5_audio_admin` (admin CSS) (`ckeditor5_audio_plugin.libraries.yml`).
- **JS:** `js/build/audio.js` — model schema `audioContainer`/`audio`, `insertAudio` command, upload vs. URL-dialog button behavior.

Solution docs: [plugins/audio.md](plugins/audio.md) · [api/upload.md](api/upload.md)
