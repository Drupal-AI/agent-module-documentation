<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Camera Capture (camera_capture) — agent index

Browser-camera photo / 10-second-video capture saved as a managed file in `public://`.
Version **1.1.0** (dir `1.1.x`). Core `^10 || ^11`. Package Utility. License GPL-2.0-or-later.

## What it is
A single form that uses the browser `getUserMedia` + `MediaRecorder` APIs (JS behavior in
`js/camera.js`) to grab a photo (PNG) or a 10s video (WebM) from the device camera and save it to
the public files directory. Aimed at EKYC / identity-verification flows. Requires a secure context
(HTTPS or `http://localhost`).

## Dependencies
- No module dependencies, no Composer requirements.
- JS library `camera_capture/camera` (`camera_capture.libraries.yml`) → depends on `core/drupal`.
- Ships **no** config, **no** permissions of its own, **no** services, **no** `.install`/`.module`.

## What it provides
- **Route** `camera_capture.form`: `GET/POST /camera-capture`, `_form` →
  `CameraCaptureForm`, requirement `_permission: 'access content'`.
- **Form** `Drupal\camera_capture\Form\CameraCaptureForm` (`FormBase`, id `camera_capture_form`).
- **JS behavior** `Drupal.behaviors.cameraCapture` in `js/camera.js`.
- No entities, no plugins, no services, no Drush commands.

## Docs
- Form + capture/save flow: [agent/forms/capture-form.md](forms/capture-form.md)
