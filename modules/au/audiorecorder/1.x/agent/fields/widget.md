<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audio Recorder widget & element

Everything the module does lives in two PHP classes plus one JS file. There is no route,
controller, service, permission, hook, or `config/install`.

## Install / enable

1. `drush en audiorecorder`. Only core `file` is required.
2. Install the vmsg browser library at `libraries/vmsg/` (`vmsg.js`, `vmsg.wasm`, `vmsg.css`).
   `js/recorder.js` loads it from `<base_path>libraries/vmsg/`. The README covers the composer
   repository + installer-path setup and the `AddType application/wasm wasm` `.htaccess` line.
3. Serve over HTTPS — `getUserMedia`/microphone access needs a secure context. Without the Web
   Audio API the widget silently falls back to the plain file-upload control.

## The field widget — `AudioRecorderWidget`

`src/Plugin/Field/FieldWidget/AudioRecorderWidget.php`, `@FieldWidget(id="file_audio_recorder",
label="Audio Recorder", field_types={"file"})`, extends core `FileWidget`, implements
`ContainerFactoryPluginInterface` (injects `element_info` + `string_translation`).

- `defaultSettings()`: adds `max_recording_time => 0` (0 = unlimited) on top of file_generic.
- `settingsForm()`: adds a *"Maximum Recording Time (seconds)"* textfield.
- `settingsSummary()`: prints "Max Recording time: unlimited" or "… @n seconds".
- `formElement()`: calls parent, stashes `getFieldSettings()` into `$element['#field_settings']`,
  sanitizes `max_recording_time` (non-numeric/negative → 0, else cast to number), and adds the
  container class `form-audio-recorder-file`.
- `process()` (static `#process`): after `FileWidget::process()`, if an `upload` control exists it
  **replaces** `$element['upload']` with a `#type => 'audio_recorder_file'` element, intersecting
  the field's allowed extensions with the supported set `['mp3']` (defaulting to `mp3`), sets
  `#accept => 'audio/*'`, `#upload_validators['file_validate_extensions']`, and
  `#max_recording_time`. It attaches the `audiorecorder/audiorecorder.recorder` library and
  `drupalSettings.audiorecorder = { max_recording_time, base_path }`.
- `value()`: fixes the `display` checkbox, then delegates to
  `AudioFileRecorder::valueCallback()`; if nothing came back it falls through to
  `FileWidget::value()` (delete handling), otherwise fills defaults (`fids`, `display`,
  `description`).

Configure it per field via *Manage form display* (or set the widget `type` to `file_audio_recorder`
in `core.entity_form_display.*` with `settings.max_recording_time`).

## The render element — `AudioFileRecorder`

`src/Element/AudioFileRecorder.php`, `@FormElement("audio_recorder_file")`, extends core
`ManagedFile`.

- `processManagedFile()`: runs `ManagedFile::processManagedFile()` then adds a **hidden** input
  `recording` (class `audio_recorder_file-recording`). The JS writes the base64 audio into it.
- `valueCallback()`: the save path. After `ManagedFile::valueCallback()`, if there are no `fids`
  yet but `upload[recording]` is set:
  - Ensures the destination (`$element['#upload_location']`) exists via
    `file_system->prepareDirectory(..., CREATE_DIRECTORY)`; logs + `setError()` on failure.
  - Matches `^data:([^;]+);base64,(.*)$`; `base64_decode()`s the payload; if the declared MIME is
    `audio/mpeg` the extension is `.mp3`, otherwise empty. The file is always named `recording`
    (+ extension) under `#upload_location`.
  - Writes with `\Drupal::service('file.repository')->writeData($data, $location)`, then
    `setMimeType()` + `save()`, and appends the new file id to `$return['fids']`. On write failure
    it logs a warning and `setError()`s the element.

The saved file is a normal managed `file` entity, so it obeys core file access and the field's
storage scheme; use a **private** file field when recordings are sensitive.

## The browser side — `js/recorder.js`

`Drupal.behaviors.audiorecorder`:

- Rewrites existing `.file--audio` links inside the widget into inline `<audio controls>` previews.
- Bails if there is no `AudioContext` (unsupported browser → native upload stays) or no recorder
  input in context.
- Dynamically `import()`s `libraries/vmsg/vmsg.js`, hides the file input, and adds a **Record**
  button. `vmsg.record({ wasmURL: …vmsg.wasm })` returns an MP3 `Blob`; a `FileReader` reads it as
  a data-URL and writes it into the hidden `recording` input so it POSTs with the form. A preview
  `<audio>` is shown and the button becomes "Record Again".
- If `max_recording_time > 0`, a `MutationObserver` waits for vmsg's record button, then arms a
  `setTimeout` that clicks vmsg's stop button after `max_recording_time` seconds.

## Config schema

`config/schema/audiorecorder.schema.yml` defines `field.widget.settings.file_audio_recorder`
extending `field.widget.settings.file_generic` with one key: `max_recording_time` (integer).
