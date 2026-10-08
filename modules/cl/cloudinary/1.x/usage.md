<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Cloudinary integrates the Cloudinary image/video management and transformation service, with a stream wrapper, storage, media library widget, SDK and video submodules.

---

Cloudinary is a media CDN and transformation service (resize, optimise, deliver images/video). This module integrates it into Drupal, with submodules for a stream wrapper, storage (including DB-backed), a media-library widget, the SDK, source migration and video. It offloads media storage and transformation to Cloudinary. The security considerations: the Cloudinary API key and secret are credentials (keep out of plain config), media uploaded to Cloudinary resides there (a data-location decision — media leaves your infrastructure), and Cloudinary's signed-URL/transformation model should be configured so that private media (if any) is not made publicly transformable. Confirm the credentials are secured, and that any non-public media is handled appropriately given files live on Cloudinary.

---

- Offload media to Cloudinary.
- Transform images via Cloudinary.
- Deliver media from a CDN.
- Use a Cloudinary stream wrapper.
- Add a media library widget.
- Keep the Cloudinary secret secure.
- Note media resides on Cloudinary.
- Handle private media appropriately.
- Optimise image delivery.
- Configure the SDK.
- Migrate sources to Cloudinary.
- Deliver video via Cloudinary.
- Enable when needed.
- Keep disabled otherwise.
- Restrict administration.
- Confirm on your site.
- Test before production.
- Review configuration.
- Pair with related modules.
- Verify theme fit.
- Match your use case.
- Confirm compatibility.