<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Imgix renders Drupal images through Imgix, a real-time image processing service and CDN.

---

Imgix renders Drupal images through Imgix — a real-time image processing service and CDN — so image
derivatives (resizing, cropping, format conversion, optimization) are generated on-demand by Imgix and
served from its CDN, offloading image processing and delivery. It depends on core File.

Use it to offload image processing/delivery to Imgix. The security-relevant point is the Imgix credentials/
source configuration: Imgix URLs are often signed with a secure token to prevent unauthorized
transformations — store any Imgix API/secure-URL token as a secret, and configure the Imgix source/domain
correctly. Note that images are served from Imgix's CDN (a dependency and a data-flow consideration for
private images — don't route access-restricted images through a public CDN source). It is a media/
performance feature with no access-control role. Configure the Imgix source.

---

- Render images through Imgix.
- Process images in real time.
- Serve images from Imgix's CDN.
- Offload image processing.
- Depend on core File.
- Generate derivatives on-demand.
- Store the Imgix secure-URL token as a secret.
- Sign Imgix URLs.
- Configure the Imgix source/domain.
- Not route private images through a public CDN.
- Optimize image delivery.
- Convert image formats.
- Have no access-control role.
- Resize/crop via Imgix.
- Serve optimized images.
- Configure Imgix.
- Handle credentials securely.
- Use a real-time image CDN.
- Offload to Imgix.
- Process images externally.
