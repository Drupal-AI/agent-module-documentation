<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Image Style Metadata stores metadata of derivative images.

---

Image Style Metadata **stores metadata of derivative (image-style) images** — capturing dimensions and
other data (e.g. BlurHash placeholders) for generated image derivatives, exposing them (including via JSON:API)
for front-ends that need image dimensions/placeholders. It depends on core Image and Config, provides its own
permissions, with `blurhash_image_style_metadata` and `jsonapi_image_style_metadata` submodules.

Use it to expose derivative-image metadata (e.g. for responsive/blur-up front-ends). It is a media/decoupled
feature; the metadata is derived from images that follow file/image access and it has no access-control role.
Configure the metadata capture.

---

- Store derivative-image metadata.
- Capture dimensions/blurhash.
- Expose via JSON:API (submodule).
- Depend on core Image and Config.
- Provide its own permissions.
- Serve responsive/decoupled front-ends.
- Derive metadata from access-respecting images.
- Have no access-control role.
- Configure the metadata capture.
- Handle image metadata.
- Store metadata.
- Configure the capture.
- Expose dimensions.
- Handle the derivatives.
- Add blurhash.
- Configure media.
- Handle the display.
- Store dimensions.
- Set the capture.
- Provide image-style metadata.
