<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
remove.bg adds an Image API effect that strips the background from images by sending them to the remove.bg (or rembg.com) cloud API, so a configured image style produces a transparent-background derivative.

---


The settings form (`/admin/config/removebg`, permission `administer removebg`) stores the API provider (`removebg` or `rembg`), the API key, and output format, and shows account status by calling the provider's `/account` endpoint. The `RemoveBgImageEffect` image-effect plugin, when applied in an image style, writes the source image to a temp file and POSTs it (multipart) to the provider's fixed endpoint (`api.remove.bg/v1.0/removebg` or `api.rembg.com/rmbg`) with the API key header, then replaces the derivative with the returned processed image. The image sent is the one being processed by the style pipeline — not a request-supplied URL — so there is no SSRF surface, and the Guzzle client uses default TLS verification.

Setup: get a remove.bg API key, enter it and the provider/format on the settings form, then add the "remove.bg" effect to an image style.
---
- Remove image backgrounds automatically via image styles.
- Configure the remove.bg API key.
- Choose the provider (remove.bg or rembg.com).
- Set the output format (e.g. PNG).
- Add the remove.bg effect to an image style.
- Produce transparent-background derivatives.
- Check API account status/credits from the settings form.
- Generate cutout product images.
- Prepare portraits with removed backgrounds.
- Integrate background removal with Image Effects.
- Restrict settings with `administer removebg`.
- Apply background removal on upload via a style.
- Batch-process existing images by flushing styles.
- Swap providers without changing image styles.
- Send images securely over HTTPS to the API.
- Cache processed derivatives like any image style.
- Use free preview calls during testing.
