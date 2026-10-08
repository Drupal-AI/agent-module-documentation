<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Camera Capture provides a form that takes a photo or a short (10-second) video from the browser camera and saves it as a file.

---

Camera Capture adds a single route, `/camera-capture`, rendering a form that uses the browser's `getUserMedia` and `MediaRecorder` APIs (via `js/camera.js`) to capture a photo or record a 10-second video from the device camera. The photo is written as a PNG and the video as a WebM into Drupal's public files directory as managed files, with server-generated names. It is aimed at EKYC and identity-verification style flows where the media should be captured live rather than uploaded from an existing file. It works on desktop, laptop, tablet, and mobile in browsers that support the MediaDevices API (Edge, Chrome, Firefox, Safari). Because camera access requires a secure context, it functions only over HTTPS or on `http://localhost`. The module ships no configuration, no permissions of its own, and no services — just the route, the `CameraCaptureForm`, and one JS behavior.

---

- Let a user take a photo directly from their webcam or phone camera in the browser.
- Record a short 10-second video clip from the device camera.
- Save captured photos as PNG files in the public files directory.
- Save captured videos as WebM files in the public files directory.
- Capture identity photos for EKYC / know-your-customer onboarding flows.
- Support online bank or financial account opening with a live photo step.
- Support government or portal identity-verification workflows.
- Collect photo/video proof for membership or subscription sign-up.
- Capture live media instead of accepting a pre-existing file upload.
- Provide a mobile-friendly camera capture experience (tablet and phone).
- Preview the live camera feed before capturing.
- Preview the recorded video before saving.
- Auto-stop recording after 10 seconds, or stop it manually.
- Work on Drupal 10 and Drupal 11 sites.
- Run over HTTPS in production or on http://localhost during development.
- Store captured media as standard Drupal managed files for later reference.
- Give staff a quick "snap a photo now" tool inside the site.
- Capture a profile or badge photo at the point of registration.
- Record a short verbal-consent or liveness video clip.
- Serve as a starting point for custom camera-based capture features.
