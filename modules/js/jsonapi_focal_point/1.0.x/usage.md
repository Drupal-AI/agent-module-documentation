<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
JSON:API Image Styles Focal Point enhances JSON:API images with Focal Point (crop-focus) data, exposing it to decoupled front ends.

---

JSON:API Image Styles Focal Point enhances JSON:API image output with Focal Point data — exposing an
image's focal point (crop-focus coordinates) through JSON:API so a decoupled/headless front end can apply
correct focal-point-aware cropping client-side. It depends on Focal Point and JSON:API Extras. This fills
the gap where JSON:API doesn't expose focal-point data by default.

Use it on decoupled sites using Focal Point where the front end needs the focus data to crop images
correctly. It is a decoupled/web-services feature exposing image metadata; ensure the JSON:API resources
are appropriately access-controlled as with any API surface, and it has no access-control role of its own.
Configure via JSON:API Extras.

---

- Expose Focal Point data via JSON:API.
- Enhance JSON:API images with focus data.
- Support decoupled focal-point cropping.
- Depend on Focal Point and JSON:API Extras.
- Give the front end crop-focus coordinates.
- Fill the JSON:API focal-point gap.
- Crop images correctly client-side.
- Access-control the JSON:API resources.
- Have no access-control role.
- Configure via JSON:API Extras.
- Support headless image cropping.
- Expose image metadata.
- Provide focus data to consumers.
- Enhance decoupled images.
- Serve focal-point data.
- Support responsive decoupled images.
- Add focus to JSON:API.
- Handle image focus headlessly.
- Configure the enhancement.
- Expose crop focus.
