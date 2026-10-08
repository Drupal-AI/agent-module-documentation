<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform "Audio recorder" element

This submodule is two small classes that plug the parent module's recorder into Webform. There is
no route, service, permission, hook, or config.

## Install / enable

`drush en audiorecorder_webform_integration`. Requires `audiorecorder` (and the vmsg library
installed at `libraries/vmsg/` — see the parent README) and `webform`. Serve over HTTPS for
microphone access.

## Webform element plugin — `WebFormAudioRecorderFileElement`

`src/Plugin/WebformElement/WebFormAudioRecorderFileElement.php`,
`@WebformElement(id="webform_audio_recorder_file_element", label="Audio recorder",
description="Allows to record audio from the browser.", category="File upload elements",
states_wrapper=TRUE, dependencies={"file"})`, extends Webform's
`Drupal\webform\Plugin\WebformElement\WebformAudioFile`.

- `defineDefaultProperties()`: adds `max_recording_time => 45` on top of the audio-file defaults.
- `form()`: extends the element-configuration form — appends a note to `file_extensions` ("will
  always add mp3, no matter the extensions chosen"), disables `file_preview` (always the HTML5
  player), and adds a required *"Maximum Recording Time (seconds)"* textfield (rendered as a
  number input) under an "Audiorecorder" fieldset.

Because it extends `WebformAudioFile`, all standard Webform file handling (storage, private/public
scheme, submission access, file usage) comes from Webform core; this plugin only adds the recorder
UI and the max-time property.

## Render element — `WebformAudioRecorderFileElement`

`src/Element/WebformAudioRecorderFileElement.php`,
`@FormElement("webform_audio_recorder_file_element")`, extends the parent module's
`AudioFileRecorder` (so it inherits the hidden `recording` input and the base64 data-URL →
managed-file `valueCallback()` verbatim).

- `processManagedFile()`: after `AudioFileRecorder::processManagedFile()`, if an `upload` control
  exists it replaces `$element['upload']` with a `#type => 'audio_recorder_file'` element:
  extensions are `array_intersect(explode(' ', $element['#file_extensions']), ['mp3'])` (default
  `mp3`), `#accept => 'audio/*'`, `#upload_validators['file_validate_extensions']`, and
  `#max_recording_time => $element['#max_recording_time']`. It attaches
  `audiorecorder/audiorecorder.recorder` and
  `drupalSettings.audiorecorder = { max_recording_time }`.

## Operate it

Add the **Audio recorder** element in the Webform builder (Build → Add element → File upload
elements), set *Maximum Recording Time*, and save. Submissions store the recording as a managed
file exactly like Webform's built-in audio-file element; use a private file scheme for sensitive
audio. The client-side capture and preview are handled by the parent module's `js/recorder.js` and
vmsg.
