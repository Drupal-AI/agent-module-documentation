<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Camera Capture — form & capture/save flow

Source: `camera_capture.routing.yml`, `src/Form/CameraCaptureForm.php`, `js/camera.js`,
`camera_capture.libraries.yml`.

## Install / enable
`drush en camera_capture -y`. No configuration step; there is no settings route and no config
objects. Visit `/camera-capture`. Camera access needs a secure context (HTTPS or
`http://localhost`) — otherwise `getUserMedia` fails in the browser.

## Route & access
`camera_capture.routing.yml`:
- `camera_capture.form` → path `/camera-capture`, `_form: '\Drupal\camera_capture\Form\CameraCaptureForm'`,
  title "Camera Capture", requirement `_permission: 'access content'`.

There is no menu link, tab, or admin page — it is a standalone form path.

## Form: `CameraCaptureForm` (extends `FormBase`)
`getFormId()` → `camera_capture_form`.

`buildForm()` renders (all inside a `#container` with id `camera-capture-root`):
- a `<video id="camera-preview">` live-preview element and a hidden `<canvas id="camera-canvas">`;
- three plain `<button type="button">` controls: `#capture-btn` (Capture Photo),
  `#record-btn` (Record 10s Video), `#stop-btn` (Stop);
- a `<video id="video-preview" controls>` for playback of a recording;
- two `#type => 'hidden'` fields, `captured_image` (id `captured-image`) and `captured_video`
  (id `captured-video`), which the JS fills with base64 data URLs;
- a submit button "Save Media".
- attaches library `camera_capture/camera`.

`validateForm()`: reads `captured_image` / `captured_video` values. Errors if both are empty.
If `captured_image` is non-empty it must start with `data:image/png;base64,`; if `captured_video`
is non-empty it must start with `data:video/webm;base64,` (string-prefix checks only).

`submitForm()`:
- `\Drupal::service('file_system')->prepareDirectory('public://', CREATE_DIRECTORY)`.
- for a present image: strips the `data:image/png;base64,` prefix, `base64_decode()`, and if the
  prefix matched writes it with
  `\Drupal::service('file.repository')->writeData($decoded, $uri, FileSystemInterface::EXISTS_RENAME)`,
  where `$uri = 'public://' . sprintf('camera_photo_%d_%s.png', $requestTime, Random::name(8))`.
- same for a present video → `camera_video_%d_%s.webm`.
- adds a status/error/warning message per outcome; sets no redirect (stays on the form).

Files are created as Drupal **managed** File entities in `public://`; names are server-generated and
the extension is fixed (`.png` / `.webm`). Nothing is attached to a content entity — the form just
saves standalone files. A site building a real capture flow would extend the form (e.g. add a
`file` field reference, ownership, or a redirect) rather than use it as-is.

## JS behavior: `js/camera.js`
`Drupal.behaviors.cameraCapture` scopes to `#camera-capture-root`, waits (via `MutationObserver` +
a 500 ms fallback) until all elements exist, then:
- `startStream()` calls `navigator.mediaDevices.getUserMedia({ video: true, audio: true })`, plays
  the preview, and creates a `MediaRecorder`.
- Capture Photo: draws the current video frame to the canvas (sized to the actual `videoWidth`/
  `videoHeight`) and puts `canvas.toDataURL('image/png')` into the `captured_image` hidden field.
- Record 10s: starts `MediaRecorder`, auto-stops after 10 000 ms; on stop, reads the WebM blob as a
  data URL (`FileReader.readAsDataURL`) into the `captured_video` hidden field.
- Stop: stops an in-progress recording early.

The server trusts the posted hidden-field values; the JS is the intended producer but is not the
only possible source of those values.
