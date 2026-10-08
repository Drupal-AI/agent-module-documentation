<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audio Recorder Webform Integration (audiorecorder_webform_integration) — agent index

Submodule of **audiorecorder**. Exposes the browser audio recorder as a **Webform** file element.
Core `^9 || ^10 || ^11`. Depends on `audiorecorder:audiorecorder` and `webform:webform`.
License GPL-2.0-or-later. Version 1.0.1 (version-dir `1.x`). No routes, permissions, services,
Drush, or config.

- **The Webform element plugin, its render element, and settings** →
  [plugins/webform-element.md](plugins/webform-element.md)

## What it provides (from source)

- **Webform element plugin** `WebFormAudioRecorderFileElement`
  (`@WebformElement(id="webform_audio_recorder_file_element", label="Audio recorder",
  category="File upload elements")`),
  `src/Plugin/WebformElement/WebFormAudioRecorderFileElement.php`, extends Webform's
  `WebformAudioFile`. Adds default property `max_recording_time => 45` (required in the form),
  forces the `mp3` extension note, and disables the file-preview toggle (always HTML5 audio).
- **Render element** `WebformAudioRecorderFileElement`
  (`@FormElement("webform_audio_recorder_file_element")`),
  `src/Element/WebformAudioRecorderFileElement.php`, extends the parent module's
  `AudioFileRecorder`. In `processManagedFile()` it replaces `upload` with a
  `#type => 'audio_recorder_file'` element (extensions intersected with `['mp3']`,
  `#accept => 'audio/*'`, `#max_recording_time`), and attaches
  `audiorecorder/audiorecorder.recorder` + `drupalSettings.audiorecorder`.
- Reuses the parent module's `AudioFileRecorder::valueCallback()` (base64 data-URL → managed file)
  and `js/recorder.js`. Nothing else.

## Operate it

- Ensure `audiorecorder` (with the vmsg library) and `webform` are installed; `drush en
  audiorecorder_webform_integration`.
- In the Webform builder, add an **Audio recorder** element (under *File upload elements*), set its
  *Maximum Recording Time*. HTTPS is required for microphone capture; unsupported browsers get the
  standard file upload.
