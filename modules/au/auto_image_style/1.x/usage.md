<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Auto Image Style applies a different image style depending on the orientation (portrait/landscape/square) of the original image.

---

A single image style does not suit every image: a crop tuned for landscape photos mangles portraits, and vice versa. The usual fix is manual — pick a style per image — which does not scale. Auto Image Style automates it: it detects the original image's orientation and applies a corresponding image style, so portrait images get the portrait style and landscape images the landscape one, automatically at render.

It is a display-layer formatter/logic with no security surface. The setup is to define the image styles for each orientation and map them; the value is that editors upload whatever they have and the right crop applies without per-image intervention.

For galleries, listings, and any mixed-orientation image content, it removes a recurring manual step. Confirm the orientation-to-style mapping produces the crops you want for each shape, since the whole benefit is in that mapping being right.

---

- Apply a style by image orientation.
- Use different crops for portrait and landscape.
- Auto-select an image style.
- Handle mixed-orientation images.
- Avoid manual per-image styles.
- Crop portraits and landscapes differently.
- Detect image orientation.
- Map orientation to a style.
- Improve a mixed gallery.
- Apply the right crop automatically.
- Handle square images.
- Configure per-orientation styles.
- Render orientation-aware images.
- Remove a manual step.
- Confirm the style mapping.
- Style uploads automatically.
- Fit varied images to a layout.
- Auto-crop by shape.
- Support editor uploads.
- Apply consistent crops.