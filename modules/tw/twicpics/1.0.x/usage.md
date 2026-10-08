<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
TwicPics maps Drupal image-style effects to TwicPics URL transformation parameters so images are transformed on the TwicPics CDN instead of locally.

---

TwicPics integrates the TwicPics image CDN. An admin settings form (`/admin/config/services/twicpics`, permission `administer site configuration`) stores the TwicPics domain, public/private paths, max width/height and API version in `twicpics.admin_settings`. A `MappingImageStyle` service translates a Drupal image style's effects (scale, crop, convert, rotate, focus/anchor, etc.) into TwicPics URL path parameters (e.g. `/resize=WxH`, `/focus=center`, `/output=webp`), and a `Compute` service builds the size fragments. The module rewrites image URLs to point at the configured TwicPics domain with those parameters appended, so resizing/format conversion happens on TwicPics' side. The domain is entered by an admin and validated against a domain regex; the module builds URL strings only and does not itself fetch remote URLs server-side.

---

- Offload image resizing to the TwicPics CDN.
- Map Drupal image style effects to TwicPics params.
- Rewrite derivative URLs to the TwicPics domain.
- Serve WebP/format-converted images via TwicPics output param.
- Apply focus/anchor as TwicPics focus param.
- Translate scale to contain / contain-max.
- Translate scale-and-crop to cover.
- Translate crop and resize effects.
- Apply rotate as a TwicPics turn param.
- Cap variant size with max width/height settings.
- Configure separate public and private image paths.
- Select the TwicPics API version.
- Reduce local image derivative generation load.
- Keep responsive images without storing many derivatives.
- Configure everything from one admin settings form.
