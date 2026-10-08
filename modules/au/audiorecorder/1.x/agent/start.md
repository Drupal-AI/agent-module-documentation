<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audio Recorder (audiorecorder) — agent index

A field **widget** that records audio in the browser (vmsg HTML5/WebAssembly → MP3) and saves it
into a core **file** field, degrading to a normal file upload where the browser lacks the APIs.
Core `^9 || ^10 || ^11`. Depends only on core **`file`**. License GPL-2.0-or-later. Version 1.0.1
(version-dir `1.x`). No permissions, no routes, no Drush, no hooks, no services.

- **The widget, the render element, settings, the record→save data flow, and the vmsg library** →
  [fields/widget.md](fields/widget.md)

## What it provides (from source)

- **Field widget** `AudioRecorderWidget` (id **`file_audio_recorder`**, label *"Audio Recorder"*),
  `src/Plugin/Field/FieldWidget/AudioRecorderWidget.php`, extends core `FileWidget`,
  `field_types = { "file" }`. Adds one setting `max_recording_time` (seconds, `0` = unlimited).
- **Form/render element** `AudioFileRecorder` (`@FormElement("audio_recorder_file")`),
  `src/Element/AudioFileRecorder.php`, extends core `ManagedFile`. Adds a hidden `recording`
  input and, in `valueCallback()`, decodes a submitted `data:…;base64,…` audio URL into a
  managed file via `file.repository`.
- **Config schema** `config/schema/audiorecorder.schema.yml`: `field.widget.settings.file_audio_recorder`
  (extends `field.widget.settings.file_generic`, adds `max_recording_time` integer). No `config/install`.
- **Library** `audiorecorder.recorder` (`audiorecorder.libraries.yml`): `js/recorder.js` +
  `css/recorder.css` + vmsg CSS from `/libraries/vmsg/`; deps jquery, drupal, once, drupalSettings.
  `js/recorder.js` dynamically `import()`s `libraries/vmsg/vmsg.js` (WebAssembly) at record time.
- **Submodule** `audiorecorder_webform_integration` (documented separately) — exposes the recorder
  as a Webform file element.

## Operate it

- Enable the module; install the `npm-asset/vmsg` library into `libraries/vmsg/` (see README —
  requires root composer.json repository + installer-path tweaks and a `.wasm` MIME type in
  `.htaccess`). Serve the site over HTTPS (microphone access requires a secure context).
- Add a core **file** field, set *Allowed file extensions* to `mp3`, then on *Manage form display*
  pick the **Audio Recorder** widget and optionally set *Maximum Recording Time*.
